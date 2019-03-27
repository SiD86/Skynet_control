#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QTimer>
#include "wirelessmodbus.h"

class Core : public QObject {

	Q_OBJECT

protected:
	WirelessModbus m_wirelessModbus;
	QTimer m_timer;

signals:
	void systemStatusUpdated(QVariant newSystemStatus);

public slots:
	void statusUpdateTimer();

public:
	explicit Core(QObject *parent = nullptr);
	virtual ~Core();
	Q_INVOKABLE bool connectToServer();
	Q_INVOKABLE bool sendGetUpCommand();
	Q_INVOKABLE bool sendGetDownCommand();
	Q_INVOKABLE bool sendDirectMoveCommand();
	Q_INVOKABLE bool sendReverseMoveCommand();
	Q_INVOKABLE bool sendRotateLeftCommand();
	Q_INVOKABLE bool sendRotateRightCommand();
	Q_INVOKABLE bool sendUpdateHeightCommand();
	Q_INVOKABLE bool sendStopMoveCommand();

	Q_INVOKABLE bool sendSetHeightCommand(QVariant height);
};

#endif // CORE_H
