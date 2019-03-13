#include "core.h"
#include <QDebug>


void Core::timerHandler() {
	emit systemStatusUpdated(0x00/*rand() * 1000*/);
}

Core::Core(QObject *parent) : QObject(parent) {

	/*m_timer.setInterval(2500);
	m_timer.start();
	connect(&m_timer, &QTimer::timeout, this, &Core::timerHandler);*/


	/*m_wirelessModbus.connectToServer();

	uint8_t buffer[30] = {0};
	m_wirelessModbus.readRAM(0x0020, buffer, 6);

	qDebug() << buffer[0] << ' ' << buffer[1] << ' '
			 << buffer[2] << ' ' << buffer[3] << ' '
			 << buffer[4] << ' ' << buffer[5] << ' ';*/
}

bool Core::connectToServer() {

	return m_wirelessModbus.connectToServer();
}

bool Core::sendGetUpCommand() {

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_UP));

	return m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}

bool Core::sendGetDownCommand() {

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_DOWN));

	return m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}

bool Core::sendDirectMoveCommand() {

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_DIRECT_MOVEMENT));

	return m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}

bool Core::sendReverseMoveCommand() {

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_REVERSE_MOVEMENT));

	return m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}

bool Core::sendRotateLeftCommand() {

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_ROTATE_LEFT));

	return m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}

bool Core::sendRotateRightCommand() {

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_ROTATE_RIGHT));

	return m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}

bool Core::sendStopMoveCommand() {

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_NONE));

	return m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}

