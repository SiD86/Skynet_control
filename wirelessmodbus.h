#ifndef WIRELESSMODBUS_H
#define WIRELESSMODBUS_H

#include <QObject>
#include <QTcpSocket>
#include <QTimer>


class WirelessModbus : public QObject {

	Q_OBJECT

protected:
	QTcpSocket m_socket;
	QTimer timeoutTimer;

protected:
	uint16_t calculateCRC16(const uint8_t* frame, uint32_t size);

public:
	explicit WirelessModbus(QObject* parent = nullptr);
	virtual bool connectToServer(void);
	virtual bool disconnectFromServer(void);
	virtual bool readRAM(uint16_t address, uint8_t* buffer, uint8_t bytesCount);
	virtual bool writeRAM(uint16_t address, uint8_t* data, uint8_t bytesCount);
	virtual bool readEEPROM(uint16_t address, uint8_t* buffer, uint8_t bytesCount);
	virtual bool writeEEPROM(uint16_t address, uint8_t* data, uint8_t bytesCount);
};

#endif // WIRELESSMODBUS_H
