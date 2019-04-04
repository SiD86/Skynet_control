#include "core.h"
#include <QGuiApplication>
#include <QDebug>
#include <QEventLoop>
#include <QtConcurrentRun>


Core::Core(QObject *parent) : QObject(parent) {

	m_statusUpdateTimer.setInterval(1000);
	m_timeoutTimer.setInterval(250);

	connect(&m_statusUpdateTimer, &QTimer::timeout, this, &Core::statusUpdateTimer);
	connect(&m_timeoutTimer, &QTimer::timeout, this, &Core::timeoutTimerEvent);
}

bool Core::connectToServer() {

	m_wirelessModbus.startConnectToServer();

	QTimer timeoutTimer;
	timeoutTimer.setSingleShot(true);
	timeoutTimer.setInterval(5000);
	timeoutTimer.start();
	while (m_wirelessModbus.isConnected() == false) {

		QGuiApplication::processEvents();

		if (timeoutTimer.isActive() == false) {
			m_wirelessModbus.disconnectFromServer();
			return false;
		}
	}

	m_statusUpdateTimer.start();
	return true;
}

void Core::disconnectFromServer() {

	m_statusUpdateTimer.stop();
	m_wirelessModbus.disconnectFromServer();
}

void Core::sendGetUpCommand()            { writeToSCR(SCR_CMD_SELECT_SEQUENCE_UP);                     }
void Core::sendGetDownCommand()          { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DOWN);                   }
void Core::sendDirectMoveCommand()       { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DIRECT_MOVEMENT);        }
void Core::sendReverseMoveCommand()      { writeToSCR(SCR_CMD_SELECT_SEQUENCE_REVERSE_MOVEMENT);       }
void Core::sendRotateLeftCommand()       { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_LEFT);            }
void Core::sendRotateRightCommand()      { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_RIGHT);           }
void Core::sendDirectMoveShortCommand()  { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DIRECT_MOVEMENT_SHORT);  }
void Core::sendReverseMoveShortCommand() { writeToSCR(SCR_CMD_SELECT_SEQUENCE_REVERSE_MOVEMENT_SHORT); }
void Core::sendRotateLeftShortCommand()  { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_LEFT_SHORT);      }
void Core::sendRotateRightShortCommand() { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_RIGHT_SHORT);     }
void Core::sendAttackLeftCommand()       { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ATTACK_LEFT);            }
void Core::sendAttackRightCommand()      { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ATTACK_RIGHT);           }
void Core::sendDanceCommand()            { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DANCE);                  }
void Core::sendUpdateHeightCommand()     { writeToSCR(SCR_CMD_SELECT_SEQUENCE_UPDATE_HEIGHT);          }
void Core::sendStopMoveCommand()         { writeToSCR(SCR_CMD_SELECT_SEQUENCE_NONE);                   }

void Core::sendSetHeightCommand(QVariant height) {

	if (m_concurrentFuture.isFinished() == false) return;


	uint32_t height32 = static_cast<uint32_t>(height.toInt());

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SET_HEXAPOD_HEIGHT));
	data.push_back(static_cast<char>((height32 >> 24) & 0xFF));
	data.push_back(static_cast<char>((height32 >> 16) & 0xFF));
	data.push_back(static_cast<char>((height32 >>  8) & 0xFF));
	data.push_back(static_cast<char>((height32 >>  0) & 0xFF));
	m_wirelessModbus.writeRAM(SCR_REGISTER_ADDRESS, data);
}


void Core::writeToSCR(int cmd) {

	if (m_concurrentFuture.isFinished() == false) return;


	m_statusUpdateTimer.stop();

	QByteArray data;
	data.push_back(static_cast<char>(cmd));
	m_concurrentFuture = QtConcurrent::run(&m_wirelessModbus, &WirelessModbus::writeRAM, SCR_REGISTER_ADDRESS, data);
	m_timeoutTimer.start();
}



//
// SLOTS
//
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

void Core::timeoutTimerEvent() {

	if (m_concurrentFuture.isFinished() == false) {
		m_concurrentFuture.cancel();
	}
}
