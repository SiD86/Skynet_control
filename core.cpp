#include "core.h"
#include <QDebug>


void Core::statusUpdateTimer() {

	QByteArray bytes;
	if (m_wirelessModbus.readRAM(ERROR_STATUS_ADDRESS, bytes, 4) == false) {
		return;
	}

	uint32_t errorStatus = static_cast<uint32_t>((bytes[3] << 24) | (bytes[2] << 16) | (bytes[1] << 8) | (bytes[0] << 0));
	emit systemStatusUpdated(errorStatus);
}

Core::Core(QObject *parent) : QObject(parent) {

	m_timer.setInterval(1000);
	connect(&m_timer, &QTimer::timeout, this, &Core::statusUpdateTimer);
}

Core::~Core() {
	m_wirelessModbus.disconnectFromServer();
}

bool Core::connectToServer() {

	if (m_wirelessModbus.connectToServer() == true) {
		m_timer.start();
		return true;
	}

	return false;
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

