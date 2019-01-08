#ifndef WIRELESSMODBUS_H
#define WIRELESSMODBUS_H

#include <QObject>
#include <QTcpSocket>
#include <QTimer>

#define WIRELESS_MODBUS_FRAME_SIZE						(sizeof(wireless_frame_t))
#define WIRELESS_MODBUS_FRAME_DATA_SIZE					(1017)
#define WIRELESS_MODBUS_FRAME_CRC_SIZE					(2)

#define WIRELESS_MODBUS_CMD_WRITE_RAM					(0x41)	// Function Code: Write RAM
#define WIRELESS_MODBUS_CMD_READ_RAM					(0x44)	// Function Code: Read RAM
#define WIRELESS_MODBUS_CMD_READ_MULTIMEDIA_DATA_SIZE	(0x60)	// Function Code: Read multimedia data size
#define WIRELESS_MODBUS_CMD_READ_MULTIMEDIA_DATA		(0x61)	// Function Code: Read multimedia data
#define WIRELESS_MODBUS_EXCEPTION						(0x80)	// Function Code: Exception


// Frame size - 1024 bytes
#pragma pack (push, 1)
typedef struct {

	uint8_t  function_code;
	uint16_t address;
	uint16_t bytes_count;
	uint8_t  data[WIRELESS_MODBUS_FRAME_DATA_SIZE];
	uint16_t crc;

} wireless_frame_t;
#pragma pack (pop)


class WirelessModbus : public QObject {

	Q_OBJECT

protected:
	QTcpSocket m_socket;
	QTimer timeoutTimer;
	wireless_frame_t m_request;

protected:
	bool processWirelessModbusTransaction(const wireless_frame_t& request,
										  wireless_frame_t& response,
										  bool isWrongFrameSizeCriticalError = true);
	bool verifyWirelessModbusResponse(const wireless_frame_t& request,
									  const wireless_frame_t& response);
	uint16_t calculate_crc16(const uint8_t* frame, uint32_t size);

public:
	explicit WirelessModbus(QObject* parent = nullptr);
	virtual bool connectToServer(void);
	virtual bool disconnectFromServer(void);
	virtual bool readRAM(uint16_t address, uint8_t* buffer, uint16_t bytesCount);
	virtual bool writeRAM(uint16_t address, uint8_t* data, uint16_t bytesCount);
	virtual bool readImage(uint8_t* buffer, uint16_t* imageSize);
};

#endif // WIRELESSMODBUS_H
