#include "core.h"
#include <QDebug>
#include <QtConcurrentRun>


void Core::statusUpdateTimer() {

	if (m_concurrentFuture.isFinished() == false) return;


	// Make error status
	const QByteArray& buffer = m_wirelessModbus.getInternalRecvBuffer();
	if (buffer.size() >= 4) {
		uint32_t errorStatus = static_cast<uint32_t>((buffer[3] << 24) | (buffer[2] << 16) | (buffer[1] << 8) | (buffer[0] << 0));
		emit systemStatusUpdated(errorStatus);
	}

	// Send next request
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::readRAM, ERROR_STATUS_ADDRESS, nullptr, 4);
}

Core::Core(QObject *parent) : QObject(parent) {

	m_statusUpdateTimer.setInterval(1000);
	connect(&m_statusUpdateTimer, &QTimer::timeout, this, &Core::statusUpdateTimer);
}

Core::~Core() {
	m_wirelessModbus.disconnectFromServer();
}

bool Core::connectToServer() {

	if (m_wirelessModbus.connectToServer() == true) {
		m_statusUpdateTimer.start();
		return true;
	}

	return false;
}

void Core::sendGetUpCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_UP));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendGetDownCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_DOWN));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendDirectMoveCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_DIRECT_MOVEMENT));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendReverseMoveCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_REVERSE_MOVEMENT));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendRotateLeftCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_ROTATE_LEFT));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendRotateRightCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_ROTATE_RIGHT));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendUpdateHeightCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_UPDATE_HEIGHT));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendStopMoveCommand() {

	if (m_concurrentFuture.isFinished() == false) return;


	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SELECT_SEQUENCE_NONE));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}

void Core::sendSetHeightCommand(QVariant height) {

	if (m_concurrentFuture.isFinished() == false) return;


	uint32_t height32 = static_cast<uint32_t>(height.toInt());

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SET_HEXAPOD_HEIGHT));
	data.push_back(static_cast<char>((height32 >> 24) & 0xFF));
	data.push_back(static_cast<char>((height32 >> 16) & 0xFF));
	data.push_back(static_cast<char>((height32 >>  8) & 0xFF));
	data.push_back(static_cast<char>((height32 >>  0) & 0xFF));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
}
