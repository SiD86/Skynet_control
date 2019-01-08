#include <QGuiApplication>
#include <QHostAddress>
#include <QDebug>
#include "wirelessmodbus.h"
#define SERVER_IP_ADDRESS		("111.111.111.111")
#define SERVER_PORT				(3333)
#define CRC16_POLYNOM			(0xA001)


//
// PROTECTED
//
bool WirelessModbus::processWirelessModbusTransaction(const wireless_frame_t& request,
													  wireless_frame_t& response,
													  bool isWrongFrameSizeCriticalError) {
	// Clear socket
	m_socket.readAll();

	// Send request
	m_socket.write(reinterpret_cast<const char*>(&request), WIRELESS_MODBUS_FRAME_SIZE);
	m_socket.flush();

	// Wait send request complete
	timeoutTimer.start(200);
	while (m_socket.bytesToWrite() != 0) {

		if (timeoutTimer.isActive() == false) {
			qDebug() << "WirelessModbus: send request timeout";
			return false; // Send request timeout
		}
		QGuiApplication::processEvents();
	}

	// Wait response
	timeoutTimer.start(1000);
	while (m_socket.bytesAvailable() != WIRELESS_MODBUS_FRAME_SIZE) {

		if (timeoutTimer.isActive() == false) {
			break;
		}
		QGuiApplication::processEvents();
	}

	if (m_socket.bytesAvailable() != WIRELESS_MODBUS_FRAME_SIZE) {

		if (m_socket.bytesAvailable() == 0) {
			qDebug() << "WirelessModbus: receive response timeout";
			return false; // Response timeout
		}

		qDebug() << "WirelessModbus: wrong frame size. Bytes received: " << m_socket.bytesAvailable();

		if (isWrongFrameSizeCriticalError == true) {
			return false;
		}

		memset(response.data, 0x00, WIRELESS_MODBUS_FRAME_DATA_SIZE);
		return true;
	}

	// Copy response
	m_socket.read(reinterpret_cast<char*>(&response), WIRELESS_MODBUS_FRAME_SIZE);

	return true;
}

bool WirelessModbus::verifyWirelessModbusResponse(const wireless_frame_t& request,
												  const wireless_frame_t& response) {
	// Verify CRC
	uint32_t crc = calculate_crc16(reinterpret_cast<const uint8_t*>(&request), WIRELESS_MODBUS_FRAME_SIZE);
	if (crc != 0) {
		qDebug() << "WirelessModbus: wrong CRC";
		return false;
	}

	// Check function code
	if (response.function_code & WIRELESS_MODBUS_EXCEPTION) {
		qDebug() << "WirelessModbus: exception";
		return false;
	}
	if (response.function_code != request.function_code) {
		qDebug() << "WirelessModbus: response.function_code != request.function_code";
		return false;
	}

	return true;
}

uint16_t WirelessModbus::calculate_crc16(const uint8_t* frame, uint32_t size) {

	uint16_t crc16 = 0xFFFF;
	uint16_t data = 0;
	uint16_t k = 0;

	while (size--) {
		crc16 ^= *frame++;
		k = 8;
		while (k--) {
			data = crc16;
			crc16 >>= 1;
			if (data & 0x0001) {
				crc16 ^= CRC16_POLYNOM;
			}
		}
	}
	return crc16;
}


//
// PUBLIC
//
WirelessModbus::WirelessModbus(QObject* parent) : QObject(parent) {

	if (sizeof(wireless_frame_t) != WIRELESS_MODBUS_FRAME_SIZE) {
		qDebug() << "sizeof(wireless_frame_t) != 1024";
		return;
	}

	timeoutTimer.setSingleShot(true);
}

bool WirelessModbus::connectToServer(void) {

	// Check socket state
	if (m_socket.state() == QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: wrong socket state";
		return true;
	}

	// Connect to server
	m_socket.connectToHost(QHostAddress(SERVER_IP_ADDRESS), SERVER_PORT);

	// Wait connect to server
	timeoutTimer.start(5000);
	while (m_socket.state() == QTcpSocket::SocketState::ConnectingState) {

		if (timeoutTimer.isActive() == false) {
			qDebug() << "WirelessModbus: cannot connect to server";
			m_socket.disconnectFromHost();
			return false; // Connection timeout
		}
		QGuiApplication::processEvents();
	}

	return m_socket.state() == QTcpSocket::SocketState::ConnectedState;
}

bool WirelessModbus::disconnectFromServer(void) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: wrong socket state";
		return true;
	}

	m_socket.disconnectFromHost();
	return m_socket.waitForDisconnected(1000);
}

bool WirelessModbus::readRAM(uint16_t address, uint8_t* buffer, uint16_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: wrong socket state";
		return false;
	}

	// Check input parameters
	if (bytesCount > WIRELESS_MODBUS_FRAME_DATA_SIZE) {
		qDebug() << "WirelessModbus: wrong block size";
		return false;
	}

	// Make request
	wireless_frame_t request;
	request.function_code = WIRELESS_MODBUS_CMD_READ_RAM;
	request.address = address;
	request.bytes_count = bytesCount;
	memset(request.data, 0x00, sizeof(request.data));
	request.crc = calculate_crc16(reinterpret_cast<const uint8_t*>(&request),
								  WIRELESS_MODBUS_FRAME_SIZE - WIRELESS_MODBUS_FRAME_CRC_SIZE);
	// Process modbus transaction
	wireless_frame_t response;
	if (processWirelessModbusTransaction(request, response) == false) {
		return false;
	}

	// Verify response
	if (verifyWirelessModbusResponse(request, response) == false) {
		return false;
	}

	// Copy data
	memcpy(buffer, response.data, bytesCount);

	return true;
}

bool WirelessModbus::writeRAM(uint16_t address, uint8_t* data, uint16_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: wrong socket state";
		return false;
	}

	// Check input parameters
	if (bytesCount > WIRELESS_MODBUS_FRAME_DATA_SIZE) {
		qDebug() << "WirelessModbus: wrong block size";
		return false;
	}

	// Make request
	wireless_frame_t request;
	request.function_code = WIRELESS_MODBUS_CMD_WRITE_RAM;
	request.address = address;
	request.bytes_count = bytesCount;
	memcpy(request.data, data, bytesCount);
	request.crc = calculate_crc16(reinterpret_cast<const uint8_t*>(&request),
								  WIRELESS_MODBUS_FRAME_SIZE - WIRELESS_MODBUS_FRAME_CRC_SIZE);
	// Process modbus transaction
	wireless_frame_t response;
	if (processWirelessModbusTransaction(request, response) == false) {
		return false;
	}

	// Verify response
	if (verifyWirelessModbusResponse(request, response) == false) {
		return false;
	}

	return true;
}

bool WirelessModbus::readImage(uint8_t* buffer, uint16_t* imageSize) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: wrong socket state";
		return false;
	}

	//
	// Read image size
	//

	// Make request
	wireless_frame_t request;
	request.function_code = WIRELESS_MODBUS_CMD_READ_MULTIMEDIA_DATA_SIZE;
	request.address = 0x0000;
	request.bytes_count = 2;
	memset(request.data, 0x00, sizeof(request.data));
	request.crc = calculate_crc16(reinterpret_cast<const uint8_t*>(&request),
								  WIRELESS_MODBUS_FRAME_SIZE - WIRELESS_MODBUS_FRAME_CRC_SIZE);
	// Process modbus transaction
	wireless_frame_t response;
	if (processWirelessModbusTransaction(request, response) == false) {
		return false;
	}

	// Verify response
	if (verifyWirelessModbusResponse(request, response) == false) {
		return false;
	}

	// Copy data
	memcpy(imageSize, response.data, 2);


	//
	// Read image
	//
	uint16_t address = 0;
	uint16_t receivedBytes = 0;
	while (receivedBytes < *imageSize) {

		// Calculate block size
		uint16_t blockSize = *imageSize - receivedBytes;
		if (blockSize > WIRELESS_MODBUS_FRAME_DATA_SIZE) {
			blockSize = WIRELESS_MODBUS_FRAME_DATA_SIZE;
		}

		// Make request
		request.function_code = WIRELESS_MODBUS_CMD_READ_MULTIMEDIA_DATA;
		request.address = address;
		request.bytes_count = blockSize;
		memset(request.data, 0x00, sizeof(request.data));
		request.crc = calculate_crc16(reinterpret_cast<const uint8_t*>(&request),
									  WIRELESS_MODBUS_FRAME_SIZE - WIRELESS_MODBUS_FRAME_CRC_SIZE);
		// Process modbus transaction
		if (processWirelessModbusTransaction(request, response, false) == false) {
			return false;
		}

		// Verify response
		if (verifyWirelessModbusResponse(request, response) == false) {
			return false;
		}

		// Copy data
		memcpy(&buffer[address], response.data, blockSize);

		address += blockSize;
		receivedBytes += blockSize;
	}

	return true;
}
