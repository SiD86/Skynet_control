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
	void systemStatusUpdated(QVariant systemStatus);

public slots:
	void timerHandler();

public:
	explicit Core(QObject *parent = nullptr);
	Q_INVOKABLE bool connectToServer();

};

#endif // CORE_H
