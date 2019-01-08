#ifndef CORE_H
#define CORE_H

#include <QObject>
#include "wirelessmodbus.h"

class Core : public QObject {

	Q_OBJECT

protected:
	WirelessModbus m_wirelessModbus;

public:
	explicit Core(QObject *parent = nullptr);

};

#endif // CORE_H
