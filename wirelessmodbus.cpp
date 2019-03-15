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

#define MODBUS_MIN_RESPONSE_LENGTH			(4)



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
	while (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {

		if (timeoutTimer.isActive() == false) {
			qDebug() << "WirelessModbus: [connectToServer] Cannot connect to server";
			m_socket.disconnectFromHost();
			return false; // Connection timeout
		}
		QGuiApplication::processEvents();
	}

	qDebug() << "WirelessModbus: [connectToServer] Connect success";
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

bool WirelessModbus::readRAM(uint16_t address, QByteArray& buffer, uint8_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [readRAM] Wrong socket state";
		return false;
	}


	// Make request
	QByteArray request;
	request.push_back(static_cast<char>(0xFE));
	request.push_back(static_cast<char>(MODBUS_CMD_READ_RAM));
	request.push_back(static_cast<char>((address & 0xFF00) >> 8));
	request.push_back(static_cast<char>((address & 0x00FF) >> 0));
	request.push_back(static_cast<char>(bytesCount));

	uint16_t crc = calculateCRC16(request);
	request.push_back(static_cast<char>((crc & 0x00FF) >> 0));
	request.push_back(static_cast<char>((crc & 0xFF00) >> 8));

	// Send request and receive response
	return processModbusTransaction(request, &buffer);
}

bool WirelessModbus::writeRAM(uint16_t address, const QByteArray& data) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [writeRAM] Wrong socket state";
		return false;
	}


	// Make request
	QByteArray request;
	request.push_back(static_cast<char>(0xFE));
	request.push_back(static_cast<char>(MODBUS_CMD_WRITE_RAM));
	request.push_back(static_cast<char>((address & 0xFF00) >> 8));
	request.push_back(static_cast<char>((address & 0x00FF) >> 0));
	request.push_back(static_cast<char>(data.size()));
	for (int i = 0; i < data.size(); ++i) {
		request.push_back(static_cast<char>(data[i]));
	}

	uint16_t crc = calculateCRC16(request);
	request.push_back(static_cast<char>((crc & 0x00FF) >> 0));
	request.push_back(static_cast<char>((crc & 0xFF00) >> 8));

	// Send request and receive response
	return processModbusTransaction(request, nullptr);
}

bool WirelessModbus::readEEPROM(uint16_t address, QByteArray& buffer, uint8_t bytesCount) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [readRAM] Wrong socket state";
		return false;
	}


	// Make request
	QByteArray request;
	request.push_back(static_cast<char>(0xFE));
	request.push_back(static_cast<char>(MODBUS_CMD_READ_EEPROM));
	request.push_back(static_cast<char>((address & 0xFF00) >> 8));
	request.push_back(static_cast<char>((address & 0x00FF) >> 0));
	request.push_back(static_cast<char>(bytesCount));

	uint16_t crc = calculateCRC16(request);
	request.push_back(static_cast<char>((crc & 0x00FF) >> 0));
	request.push_back(static_cast<char>((crc & 0xFF00) >> 8));

	// Send request and receive response
	return processModbusTransaction(request, &buffer);
}

bool WirelessModbus::writeEEPROM(uint16_t address, const QByteArray& data) {

	// Check socket state
	if (m_socket.state() != QTcpSocket::SocketState::ConnectedState) {
		qDebug() << "WirelessModbus: [writeRAM] Wrong socket state";
		return false;
	}


	// Make request
	QByteArray request;
	request.push_back(static_cast<char>(0xFE));
	request.push_back(static_cast<char>(MODBUS_CMD_WRITE_EEPROM));
	request.push_back(static_cast<char>((address & 0xFF00) >> 8));
	request.push_back(static_cast<char>((address & 0x00FF) >> 0));
	request.push_back(static_cast<char>(data.size()));
	for (int i = 0; i < data.size(); ++i) {
		request.push_back(static_cast<char>(data[i]));
	}

	uint16_t crc = calculateCRC16(request);
	request.push_back(static_cast<char>((crc & 0x00FF) >> 0));
	request.push_back(static_cast<char>((crc & 0xFF00) >> 8));

	// Send request and receive response
	return processModbusTransaction(request, nullptr);
}




bool WirelessModbus::processModbusTransaction(const QByteArray& request, QByteArray* responseData) {

	// Send request
	m_socket.write(request);
	if (m_socket.waitForBytesWritten(20) == false) {
		qDebug() << "WirelessModbus: [processModbusTransaction] waitForBytesWritten";
		return false;
	}

	// Wait response
	timeoutTimer.start(150);
	while (m_socket.bytesAvailable() < MODBUS_MIN_RESPONSE_LENGTH) {

		if (timeoutTimer.isActive() == false) {
			qDebug() << "WirelessModbus: [processModbusTransaction] Receive response timeout. Bytes received: " << m_socket.bytesAvailable();
			return false;
		}
		QGuiApplication::processEvents();
	}
	qDebug() << "WirelessModbus: [processModbusTransaction] Frame received: " << m_socket.bytesAvailable();

	// Read response
	QByteArray response = m_socket.readAll();

	// Verify response
	if (this->calculateCRC16(response) != 0) {
		qDebug() << "WirelessModbus: [processModbusTransaction] Wrong CRC";
		return false;
	}

	// Check function code or exception
	if (response[1] & MODBUS_EXCEPTION) {
		qDebug() << "WirelessModbus: [processModbusTransaction] Exception received: " << response[2];
		return false;
	}

	// Copy data from response
	if (request[1] == MODBUS_CMD_READ_RAM || request[1] == MODBUS_CMD_READ_EEPROM) {
		*responseData = response.mid(3);
	}

	qDebug() << "WirelessModbus: [processModbusTransaction] Response received";
	return true;
}

uint16_t WirelessModbus::calculateCRC16(const QByteArray& frameByteArray) {

	uint8_t size = static_cast<uint8_t>(frameByteArray.size());
	const uint8_t* frame = reinterpret_cast<const uint8_t*>(frameByteArray.data());


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
