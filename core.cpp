#include "core.h"
#include <QDebug>


void Core::timerHandler() {
	emit systemStatusUpdated(0x00/*rand() * 1000*/);
}

Core::Core(QObject *parent) : QObject(parent) {

	m_timer.setInterval(2500);
	m_timer.start();
	connect(&m_timer, &QTimer::timeout, this, &Core::timerHandler);
}
