#ifndef WIRELESSCONTROLLER_H
#define WIRELESSCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QtNetwork/qudpsocket.h>
#include "wireless_protocol.h"

class WirelessController : public QObject
{
	Q_OBJECT
protected:
	QUdpSocket m_socket;
	QTimer m_sendTimer;
	quint8* m_txDataAddress;
	quint8* m_rxDataAddress;

	int m_txCounter;
	int m_rxCounter;
	int m_skipCounter;
	int m_errorCounter;

public slots:
	void send();
	void recv();

public slots: // From QML
	bool start();
	void stop();

signals:
	void prepareTxData();
	void dataRxSuccess();
	void countersUpdated(int tx, int rx, int skip, int error);

public:
	explicit WirelessController();
	void init(quint8* txDataAddress, quint8* rxDataAddress);
};

#endif // WIRELESSCONTROLLER_H
