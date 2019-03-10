#include "core.h"
#include <QDebug>


void Core::timerHandler() {
	emit systemStatusUpdated(0x00/*rand() * 1000*/);
}

Core::Core(QObject *parent) : QObject(parent) {

	/*m_timer.setInterval(2500);
	m_timer.start();
	connect(&m_timer, &QTimer::timeout, this, &Core::timerHandler);*/


	m_wirelessModbus.connectToServer();

	uint8_t buffer[30] = {0};
	m_wirelessModbus.readRAM(0x0020, buffer, 6);

	qDebug() << buffer[0] << ' ' << buffer[1] << ' '
			 << buffer[2] << ' ' << buffer[3] << ' '
			 << buffer[4] << ' ' << buffer[5] << ' ';
}
