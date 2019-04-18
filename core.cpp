#include "core.h"
#include <QApplication>
#include <QDebug>
#include <QtConcurrent>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QFileDialog>
#include <QFile>

const QString reposityroBaseUrl = "https://raw.githubusercontent.com/NeoProg2013/SkynetConfigurations/master/";
const QString versionFileName = "VERSION";


Core::Core(QObject *parent) : QObject(parent) {

}

Core::~Core() {

}

bool Core::findDevice() {

	auto future = QtConcurrent::run(&m_modbus, &Modbus::findDevice);
	while (future.isFinished() == false) {
		QApplication::processEvents();
	}

	return future.result();
}

bool Core::requestConfigurationListFromServer() {

	emit showLogMessage("Download file with available versions");

	// Download file with version list
	QNetworkRequest request(QUrl(reposityroBaseUrl + versionFileName));
	QNetworkReply* reply = m_accessManager.get(request);
	while (!reply->isFinished()) {
		QApplication::processEvents();
	}

	// Check errors
	if (reply->error() != QNetworkReply::NetworkError::NoError) {
		emit showLogMessage("Operation failed");
		return false;
	}

	// Read data
	QString rawFileData = QString::fromUtf8(reply->readAll());
	delete reply;

	emit showLogMessage("Get configuration list");

	// Parse versions
	QList<QString> versionList;
	while (true) {

		int index = rawFileData.indexOf("\r\n");
		if (index == -1) {
			break;
		}

		QString version = rawFileData.mid(0, index);
		rawFileData.remove(0, index + 2);

		emit configurationFound(version);
		QApplication::processEvents();
	}

	// Last version number
	emit configurationFound(rawFileData);

	emit showLogMessage("Operation completed");
	return true;
}

bool Core::requestConfigurationFileFromServer(QString version) {

	QString pathToSaveFile = QFileDialog::getSaveFileName();
	if (pathToSaveFile.size() == 0) {
		return true;
	}

	// Download configuration file
	emit showLogMessage("Download configuration from server");
	QNetworkRequest request(QUrl(reposityroBaseUrl + version));
	QNetworkReply* reply = m_accessManager.get(request);
	while (!reply->isFinished()) {
		QApplication::processEvents();
	}

	// Check errors
	if (reply->error() != QNetworkReply::NetworkError::NoError) {
		emit showLogMessage("Operation failed");
		return false;
	}

	// Create file
	emit showLogMessage("Create destination file");
	QFile saveFile(pathToSaveFile);
	if (saveFile.open(QFile::ReadWrite) == false) {
		emit showLogMessage("Operation failed");
		return false;
	}

	// Write data to file
	saveFile.write(reply->readAll());
	delete reply;
	saveFile.close();

	emit showLogMessage("Operation completed");
	return true;
}

bool Core::loadConfigurationToDevice() {

	QString pathToFile = QFileDialog::getOpenFileName();
	if (pathToFile.size() == 0) {
		return true;
	}

	// Open file
	emit showLogMessage("Read data from file");
	QFile saveFile(pathToFile);
	if (saveFile.open(QFile::ReadWrite) == false) {
		emit showLogMessage("Operation failed");
		return false;
	}

	// Read data
	QString rawFileData = QString::fromUtf8(saveFile.readAll());
	saveFile.close();

	// Get memory dump
	emit showLogMessage("Getting memory dump");
	QByteArray memoryDump;
	this->getMemoryDumpFromRawData(rawFileData, memoryDump);

	// Search device
	emit showLogMessage("Start search device");
	if (m_modbus.findDevice() == false) {
		emit showLogMessage("Operation failed");
		return false;
	}

	// Write data to device
	emit showLogMessage("Start write data to device");
	for (int i = 0; i < memoryDump.size(); i += 16) {

		// Make data block
		QByteArray dataBlock = memoryDump.mid(i, 16);

		// Make address for log message
		QString address = QString::number(i, 16).toUpper();
		while (address.size() != 4) {
			address.insert(0, '0');
		}

		// Send modbus request for write data
		emit showLogMessage("Write data to address " + address);
		if (m_modbus.writeEEPROM(static_cast<uint16_t>(i), dataBlock) == false) {
			emit showLogMessage("Operation failed");
			return false;
		}
	}

	emit showLogMessage("Operation completed");
	return true;
}




void Core::getMemoryDumpFromRawData(QString& rawData, QByteArray& memoryDump) {

	// Remove spaces and \r \n symbols
	while (true) {

		int index = rawData.indexOf(QRegExp("\\ |\\\n|\\\r"));
		if (index == -1) {
			break;
		}
		rawData.remove(index, 1);
	}

	// Parse data
	while (true) {

		// Search and remove address
		int index = rawData.indexOf(QRegExp("....\\:"));
		if (index == -1) {
			break;
		}
		rawData.remove(index, 5);

		// Read data line
		for (int i = 0; i < 16; ++i) {

			QString numberStr = rawData.mid(0, 2);
			memoryDump.push_back(static_cast<char>(numberStr.toInt(nullptr, 16)));

			rawData.remove(0, 2);
		}
	}
}
