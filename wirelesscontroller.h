#ifndef WIRELESSCONTROLLER_H
#define WIRELESSCONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QtNetwork/qudpsocket.h>
#include "TXRX_PROTOCOL.h"

class WirelessController : public QObject
{
	Q_OBJECT
protected:
	QUdpSocket m_UDPSocket;
	QTimer m_sendTimer;
	quint8* m_txDataAddress;
	quint8* m_rxDataAddress;

	int m_txCount;
	int m_rxCount;
	int m_skipCount;
	int m_errorCount;

protected:
	quint32 calcCRC(const quint8 *data);

public slots:
	void UDPSend();
	void UDPRecv();

public slots: // From QML
	bool runConnection();
	void stopConnection();
	bool start();
	void stop();

signals:
	void beginTxData();
	void dataRxSuccess();
	void updateCounters(int tx, int rx, int skip, int error);

public:
	explicit WirelessController(QObject* parent = 0);
	void initialize(quint8* txData, quint8* rxData);
};

#endif // WIRELESSCONTROLLER_H
