#ifndef WIRELESSMODBUS_H
#define WIRELESSMODBUS_H

#include <QObject>
#include <QTcpSocket>
#include <QTimer>

#define SCR_REGISTER_ADDRESS							(0x0060)
#define		SCR_CMD_SELECT_SEQUENCE_UP					(0x01)
#define		SCR_CMD_SELECT_SEQUENCE_DOWN				(0x02)
#define		SCR_CMD_SELECT_SEQUENCE_DIRECT_MOVEMENT		(0x03)
#define		SCR_CMD_SELECT_SEQUENCE_REVERSE_MOVEMENT	(0x04)
#define		SCR_CMD_SELECT_SEQUENCE_ROTATE_LEFT			(0x05)
#define		SCR_CMD_SELECT_SEQUENCE_ROTATE_RIGHT		(0x06)
#define		SCR_CMD_SELECT_SEQUENCE_NONE				(0x90)


class WirelessModbus : public QObject {

	Q_OBJECT

public:
	explicit WirelessModbus(QObject* parent = nullptr);
	virtual bool connectToServer(void);
	virtual bool disconnectFromServer(void);
	virtual bool readRAM(uint16_t address, QByteArray& buffer, uint8_t bytesCount);
	virtual bool writeRAM(uint16_t address, const QByteArray& data);
	virtual bool readEEPROM(uint16_t address, QByteArray& buffer, uint8_t bytesCount);
	virtual bool writeEEPROM(uint16_t address, const QByteArray& data);

protected:
	bool processModbusTransaction(const QByteArray& request, QByteArray* responseData);
	uint16_t calculateCRC16(const QByteArray &frameByteArray);

private:
	QTcpSocket m_socket;
	QTimer timeoutTimer;
};

#endif // WIRELESSMODBUS_H
