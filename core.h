#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QQuickItem>
#include "wireless_protocol.h"
#include "wirelesscontroller.h"

class Core : public QObject
{
	Q_OBJECT
private:
	wireless_protocol_control_data_t m_controlData;
	wireless_protocol_state_data_t m_stateData;

signals: // To QML interface
	void wirelessControllerCountersUpdated(int rx, int tx, int error);
	void updateQML();

public slots:
	QVariant getVersion();
	void constructControlPacket();				// From WirelessController
	//void statePacketProcess();					// From WirelessController

public:
	explicit Core();
	virtual ~Core();
	void initialize(QQuickItem* rootObject);
};
#endif // MAINWINDOW_H
