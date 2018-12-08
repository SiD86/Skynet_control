#ifndef CONFIGURATIONCORE_H
#define CONFIGURATIONCORE_H

#include <QObject>
#include <QVariant>
#include <QSerialPort>
#include <QQuickItem>
#include "TXRX_PROTOCOL.h"

class ConfigurationCore : public QObject
{
	Q_OBJECT

private:
	Q_PROPERTY(QString	deviceID			READ getDeviceID			NOTIFY updateQML)
	Q_PROPERTY(QString	firmwareVersion     READ getFirmwareVersion     NOTIFY updateQML)

	QString getDeviceID()			 { return m_deviceID;			}
	QString getFirmwareVersion()     { return m_firmwareVersion;	}

private:
	QQuickItem* m_configWidget;
	QSerialPort m_serialPort;
	QString m_deviceID;
	QString m_firmwareVersion;

protected:
	bool sendFrame(TXRX::configuration_data_t* request);
	bool waitFrame(TXRX::configuration_data_t* response);
	bool checkFrame(TXRX::configuration_data_t* response, int command);
	bool sendCommand(TXRX::configuration_data_t* request, TXRX::configuration_data_t* response, bool isDisplaySteps);
	quint32 calcCRC(quint8* data);
	void displayOperation(QString text, QString color, bool isUsePortName, bool isDisplayOperation);

signals:
	void setMessageText(QVariant text, QVariant color = "#FFFFFF");
	void deviceFinded(QVariant ID, QVariant firmware_version);
	void updateQML();

public slots: // For QML interface
	bool runConnection();
	void stopConnection();

	// Commands
	void readMemoryDump();
	void writeMemoryDump();
	void saveDumpToFile();
	void loadDumpFromFile();
	void softwareResetController();

public:
	explicit ConfigurationCore(QObject *parent = nullptr);
	void initialize(QQuickItem* rootObject);
};

#endif // CONFIGURATIONCORE_H
