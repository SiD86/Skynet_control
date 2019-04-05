#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QTimer>
#include <QtConcurrentRun>
#include <QFuture>
#include "wirelessmodbus.h"

class Core : public QObject {

	Q_OBJECT

public:
	explicit Core(QObject *parent = nullptr);
	Q_INVOKABLE bool connectToServer();
	Q_INVOKABLE void disconnectFromServer();

	Q_INVOKABLE void sendGetUpCommand();
	Q_INVOKABLE void sendGetDownCommand();
	Q_INVOKABLE void sendDirectMoveCommand();
	Q_INVOKABLE void sendReverseMoveCommand();
	Q_INVOKABLE void sendRotateLeftCommand();
	Q_INVOKABLE void sendRotateRightCommand();
	Q_INVOKABLE void sendDirectMoveShortCommand();
	Q_INVOKABLE void sendReverseMoveShortCommand();
	Q_INVOKABLE void sendRotateLeftShortCommand();
	Q_INVOKABLE void sendRotateRightShortCommand();
	Q_INVOKABLE void sendAttackLeftCommand();
	Q_INVOKABLE void sendAttackRightCommand();
	Q_INVOKABLE void sendDanceCommand();
	Q_INVOKABLE void sendUpdateHeightCommand();
	Q_INVOKABLE void sendStopMoveCommand();

	Q_INVOKABLE void sendSetHeightCommand(QVariant height);

signals:
	void systemStatusUpdatedSignal(QVariant newSystemStatus);
	void connectToServerSignal();
	void disconnectFromServerSignal();
	void writeDataToRamSignal(int address, QByteArray data);
	void readDataFromRamSignal(int address, QByteArray* data, int bytesCount);

public slots:
	void statusUpdateTimer();

protected:
	void writeToSCR(int cmd, int retryCount);
	void waitOperationCompleted();

protected:
	QThread m_thread;
	WirelessModbus* m_wirelessModbus;
	QTimer m_statusUpdateTimer;
	QFuture<bool> m_concurrentFuture;
};

#endif // CORE_H
