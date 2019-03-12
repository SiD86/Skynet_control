#include <QGuiApplication>
#include <QHostAddress>
#include <QDebug>
#include "wirelessmodbus.h"
#define SERVER_IP_ADDRESS					("111.111.111.111")
#define SERVER_PORT							(3333)
#define CRC16_POLYNOM						(0xA001)

#define MODBUS_CMD_WRITE_RAM				(0x41)	// Function Code: Write RAM
#define MODBUS_CMD_WRITE_EEPROM				(0x43)	// Function Code: Write EEPROM
#define MODBUS_CMD_READ_RAM					(0x44)	// Function Code: Read RAM
#define MODBUS_CMD_READ_EEPROM				(0x46)	// Function Code: Read EEPROM
#define MODBUS_EXCEPTION					(0x80)	// Function Code: Exception


WirelessModbus::WirelessModbus(QObject* parent) : QObject(parent) {

	timeoutTimer.setSingleShot(true);
}

bool WirelessModbus::connectToServer(void) {

	// Check socket state
	if (m_socket.state() == QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [connectToServer] Wrong socket state";
		return true;
	}

	// Connect to server
	m_socket.connectToHost(QHostAddress(SERVER_IP_ADDRESS), SERVER_PORT);

	// Wait connect to server
	timeoutTimer.start(5000);
	while (m_socket.state() == QTcpSocket::SocketState::ConnectingState) {

		if (timeoutTimer.isActive() == false) {
			qDebug() << "WirelessModbus: [connectToServer] Cannot connect to server";
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
		qDebug() << "WirelessModbus: [disconnectFromServer] Wrong socket state";
		return true;
	}

	m_socket.disconnectFromHost();
	return m_socket.waitForDisconnected(1000);
}

bool WirelessModbus::readRAM(uint16_t address, uint8_t* buffer, uint8_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [readRAM] Wrong socket state";
		return false;
	}


	// Make request
	uint8_t request[256] = {0};
	uint8_t request_size = 0;

	request[request_size++] = 0xFE;
	request[request_size++] = MODBUS_CMD_READ_RAM;
	request[request_size++] = (address & 0xFF00) >> 8;
	request[request_size++] = (address & 0x00FF) >> 0;
	request[request_size++] = bytesCount;

	uint16_t crc = calculateCRC16(request, request_size);
	request[request_size++] = (crc & 0x00FF) >> 0;
	request[request_size++] = (crc & 0xFF00) >> 8;

	// Send request
	m_socket.write(reinterpret_cast<char*>(request), request_size);
	if (m_socket.waitForBytesWritten(50) == false) {
		qDebug() << "WirelessModbus: [readRAM] waitForBytesWritten";
		return false;
	}

	// Wait response
	timeoutTimer.start(250);
	while (m_socket.bytesAvailable() != 3 + bytesCount + 2) {	// Device address + Function code + Bytes count + Data + CRC16

		if (timeoutTimer.isActive() == false) {
			qDebug() << "WirelessModbus: [readRAM] Receive response timeout. Bytes received: " << m_socket.bytesAvailable();
			return false;
		}
		QGuiApplication::processEvents();
	}

	// Read response
	uint8_t response[256] = {0};
	uint8_t response_size = static_cast<uint8_t>(m_socket.bytesAvailable());
	m_socket.read(reinterpret_cast<char*>(response), response_size);

	qDebug() << "WirelessModbus: [readRAM] Response received: " << response_size;
	qDebug() << "WirelessModbus: [readRAM] Response CRC: " << calculateCRC16(response, response_size);

	// Verify response
	if (calculateCRC16(response, response_size) != 0) {
		qDebug() << "WirelessModbus: [readRAM] Wrong CRC";
		return false;
	}

	memcpy(buffer, &response[3], bytesCount);
	return true;
}

bool WirelessModbus::writeRAM(uint16_t address, uint8_t* data, uint8_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [writeRAM] Wrong socket state";
		return false;
	}


	return true;
}

bool WirelessModbus::readEEPROM(uint16_t address, uint8_t* buffer, uint8_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [readEEPROM] Wrong socket state";
		return false;
	}


	return true;
}

bool WirelessModbus::writeEEPROM(uint16_t address, uint8_t* data, uint8_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [writeEEPROM] Wrong socket state";
		return false;
	}



	return true;
}




uint16_t WirelessModbus::calculateCRC16(const uint8_t* frame, uint32_t size) {

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
