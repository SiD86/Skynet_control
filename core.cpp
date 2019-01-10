#include "core.h"
#include <QDebug>


void Core::timerHandler() {
	emit systemStatusUpdated(rand() * 1000);
	qDebug() << "TIMER EVENT";
}

Core::Core(QObject *parent) : QObject(parent) {

	m_timer.setInterval(2500);
	m_timer.start();
	connect(&m_timer, &QTimer::timeout, this, &Core::timerHandler);
}
