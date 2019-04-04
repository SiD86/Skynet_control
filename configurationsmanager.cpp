#include "configurationsmanager.h"
#include <QGuiApplication>
#include <QtConcurrentRun>
#include <QFile>

#define FILE_LIST_URL					"https://raw.githubusercontent.com/NeoProg2013/Skynet_configurations/master/files"
#define CONFIGURATION_FILE_BASER_URL	"https://raw.githubusercontent.com/NeoProg2013/Skynet_configurations/master/"


ConfigurationsManager::ConfigurationsManager(WirelessModbus* wirelessModbus, QObject *parent) : QObject(parent) {

	m_wirelessModbus = wirelessModbus;
	m_isDownloadInProgress = false;
	m_networkReply = nullptr;

	connect(&m_accessManager, &QNetworkAccessManager::finished, this, [this](QNetworkReply*) {
		this->m_downloadData = m_networkReply->readAll();
		m_networkReply->deleteLater();
		m_networkReply = nullptr;
		m_isDownloadInProgress = false;
	});
}

bool ConfigurationsManager::loadConfigurationList(void) {

	emit showLogMessage("Download configuration list from server...");
	QGuiApplication::processEvents();

	// Read available configuration list
	m_isDownloadInProgress = true;
	m_networkRequest.setUrl(QUrl(FILE_LIST_URL));
	m_networkReply = m_accessManager.get(m_networkRequest);
	while (m_isDownloadInProgress) {
		QGuiApplication::processEvents();
	}

	if (m_downloadData.size() == 0) {
		emit showLogMessage("FAIL");
		QGuiApplication::processEvents();
		return false;
	}

	QString fileNames = QString::fromUtf8(m_downloadData);
	if (fileNames.indexOf("404: Not Found") != -1) {
		emit showLogMessage("FAIL");
		QGuiApplication::processEvents();
		return false;
	}

	// Parse file names
	while (true) {

		int index = fileNames.indexOf('\n');
		QString fileName = fileNames.mid(0, index);
		if (fileName[fileName.size() - 1] == '\r') {
			fileName = fileName.mid(0, fileName.size() - 1);
		}
		emit configurationFound(fileName);

		if (index == -1) {
			break;
		}

		fileNames = fileNames.mid(index + 1, -1);
	}

	return true;
}

bool ConfigurationsManager::loadConfiguration(QString configurationName) {

	emit showLogMessage("Download configuration from server...");
	QGuiApplication::processEvents();

	// Load configuration file
	m_isDownloadInProgress = true;
	m_networkRequest.setUrl(QUrl(CONFIGURATION_FILE_BASER_URL + configurationName));
	m_networkReply = m_accessManager.get(m_networkRequest);
	while (m_isDownloadInProgress) {
		QGuiApplication::processEvents();
	}

	if (m_downloadData.size() == 0) {
		emit showLogMessage("FAIL");
		QGuiApplication::processEvents();
		return false;
	}


	QString memoryMap = QString::fromUtf8(m_downloadData);
	if (memoryMap.indexOf("404: Not Found") != -1) {
		emit showLogMessage("FAIL");
		QGuiApplication::processEvents();
		return false;
	}

	emit showLogMessage("Prepare configuration...");
	QGuiApplication::processEvents();

	while (true) {

		int index = memoryMap.indexOf('\n');
		if (index == -1) {

			index = memoryMap.indexOf('\r');
			if (index == -1) {
				break;
			}
			else {
				memoryMap.remove(index, 1);
			}
		}
		else {
			memoryMap.remove(index, 1);
		}
	}

	emit showLogMessage("Load configuration to device...");
	QGuiApplication::processEvents();

	while (memoryMap.size() != 0) {

		// Get memory line address
		QString hexAddress = memoryMap.mid(0, 4);
		int address = hexAddress.toInt(nullptr, 16);

		// Remove memory line address
		memoryMap = memoryMap.mid(5, -1);

		// Get data for memory line
		QByteArray memoryLine;
		for (int i = 0; i < 16; ++i) {
			memoryLine.push_back(static_cast<char>(memoryMap.mid(0, 2).toInt(nullptr, 16)));
			memoryMap = memoryMap.mid(2, -1);
		}

		emit showLogMessage(QString("Write data to address: 0x") + hexAddress + "...");
		QGuiApplication::processEvents();

		// Write data to EEPROM
		auto future = QtConcurrent::run(m_wirelessModbus, &WirelessModbus::writeEEPROM, address, memoryLine);

		// Wait operation complete
		while (future.isFinished() == false) {
			QGuiApplication::processEvents();
		}

		// Check result
		if (future.result() == false) {
			emit showLogMessage("FAIL");
			QGuiApplication::processEvents();
			return false;
		}
	}
	return true;
}

void ConfigurationsManager::abortOperations(void) {

	if (m_networkReply != nullptr) {
		m_networkReply->abort();
		m_networkReply->deleteLater();
		m_networkReply = nullptr;
	}
}
