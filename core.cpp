#include "core.h"
#include <QGuiApplication>
#include <QDebug>
#include <QEventLoop>
#include <QtConcurrentRun>


Core::Core(QObject *parent) : QObject(parent) {

	m_statusUpdateTimer.setInterval(1000);
	connect(&m_statusUpdateTimer, &QTimer::timeout, this, &Core::statusUpdateTimer);

	m_wirelessModbus = new WirelessModbus;
	m_wirelessModbus->moveToThread(&m_thread);
	m_thread.start();

	connect(this, &Core::connectToServerSignal, m_wirelessModbus, &WirelessModbus::connectToServer);
	connect(this, &Core::disconnectFromServerSignal, m_wirelessModbus, &WirelessModbus::disconnectFromServer);
	connect(this, &Core::writeDataToRamSignal, m_wirelessModbus, &WirelessModbus::writeRAM);
	connect(this, &Core::readDataFromRamSignal, m_wirelessModbus, &WirelessModbus::readRAM);
}

bool Core::connectToServer() {

	emit connectToServerSignal();
	this->waitOperationCompleted();

	if (m_wirelessModbus->operationResult() == false) {
		m_statusUpdateTimer.stop();
		return false;
	}

	m_statusUpdateTimer.start();
	return true;
}

void Core::disconnectFromServer() {

	m_statusUpdateTimer.stop();

	emit disconnectFromServerSignal();
	this->waitOperationCompleted();
}

void Core::sendGetUpCommand()            { writeToSCR(SCR_CMD_SELECT_SEQUENCE_UP, 1);                     }
void Core::sendGetDownCommand()          { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DOWN, 1);                   }
void Core::sendDirectMoveCommand()       { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DIRECT_MOVEMENT, 1);        }
void Core::sendReverseMoveCommand()      { writeToSCR(SCR_CMD_SELECT_SEQUENCE_REVERSE_MOVEMENT, 1);       }
void Core::sendRotateLeftCommand()       { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_LEFT, 1);            }
void Core::sendRotateRightCommand()      { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_RIGHT, 1);           }
void Core::sendDirectMoveShortCommand()  { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DIRECT_MOVEMENT_SHORT, 1);  }
void Core::sendReverseMoveShortCommand() { writeToSCR(SCR_CMD_SELECT_SEQUENCE_REVERSE_MOVEMENT_SHORT, 1); }
void Core::sendRotateLeftShortCommand()  { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_LEFT_SHORT, 1);      }
void Core::sendRotateRightShortCommand() { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ROTATE_RIGHT_SHORT, 1);     }
void Core::sendAttackLeftCommand()       { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ATTACK_LEFT, 1);            }
void Core::sendAttackRightCommand()      { writeToSCR(SCR_CMD_SELECT_SEQUENCE_ATTACK_RIGHT, 1);           }
void Core::sendDanceCommand()            { writeToSCR(SCR_CMD_SELECT_SEQUENCE_DANCE, 1);                  }
void Core::sendUpdateHeightCommand()     { writeToSCR(SCR_CMD_SELECT_SEQUENCE_UPDATE_HEIGHT, 1);          }
void Core::sendStopMoveCommand()         { writeToSCR(SCR_CMD_SELECT_SEQUENCE_NONE, 5);                   }

void Core::sendSetHeightCommand(QVariant height) {

	if (m_concurrentFuture.isFinished() == false) return;


	uint32_t height32 = static_cast<uint32_t>(height.toInt());

	QByteArray data;
	data.push_back(static_cast<char>(SCR_CMD_SET_HEXAPOD_HEIGHT));
	data.push_back(static_cast<char>((height32 >> 24) & 0xFF));
	data.push_back(static_cast<char>((height32 >> 16) & 0xFF));
	data.push_back(static_cast<char>((height32 >>  8) & 0xFF));
	data.push_back(static_cast<char>((height32 >>  0) & 0xFF));
	m_wirelessModbus->writeRAM(SCR_REGISTER_ADDRESS, data);
}


void Core::writeToSCR(int cmd, int retryCount) {

	QByteArray data;
	data.push_back(static_cast<char>(cmd));

	for (int i = 0; i < retryCount; ++i) {

		emit writeDataToRamSignal(SCR_REGISTER_ADDRESS, data);
		this->waitOperationCompleted();

		if (m_wirelessModbus->operationResult()) {
			break;
		}
	}
}

void Core::waitOperationCompleted() {

	while (m_wirelessModbus->isOperationInProgress() == false);
	while (m_wirelessModbus->isOperationInProgress() == true) {
		QGuiApplication::processEvents(QEventLoop::ExcludeUserInputEvents);
	}
}



//
// SLOTS
//
void Core::statusUpdateTimer() {

	QByteArray buffer;
	emit readDataFromRamSignal(ERROR_STATUS_ADDRESS, &buffer, 4);
	waitOperationCompleted();

	if (m_wirelessModbus->operationResult() == false) {
		return;
	}

	// Make error status
	if (buffer.size() == 4) {
		uint32_t errorStatus = static_cast<uint32_t>((buffer[3] << 24) | (buffer[2] << 16) | (buffer[1] << 8) | (buffer[0] << 0));
		emit systemStatusUpdatedSignal(errorStatus);
	}

	qDebug() << "status recv";
}
