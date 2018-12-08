#include <QApplication>
#include <QSerialPortInfo>
#include <QDebug>
#include <QMessageBox>
#include <QMetaObject>
#include <QFileDialog>
#include <QTime>
#include <QDate>
#include "configurationcore.h"
#include "TXRX_PROTOCOL.h"
#define PACKET_SIZE							(sizeof(TXRX::configuration_data_t))
#define PACKET_SIZE_WITHOUT_CRC				(sizeof(TXRX::configuration_data_t) - sizeof(TXRX::configuration_data_t::CRC))
#define PACKET_DATA_SIZE					(sizeof(TXRX::configuration_data_t::data))


//
// PUBLIC
//
ConfigurationCore::ConfigurationCore(QObject *parent) : QObject(parent) {

}

void ConfigurationCore::initialize(QQuickItem* rootObject) {
	m_serialPort.setPortName("COM0");
	m_serialPort.setBaudRate(QSerialPort::Baud115200);
	m_serialPort.setDataBits(QSerialPort::Data8);
	m_serialPort.setParity(QSerialPort::NoParity);
	m_serialPort.setStopBits(QSerialPort::OneStop);
	m_serialPort.setReadBufferSize(1024);

	m_configWidget = rootObject->findChild<QQuickItem*>("configuration");
}


//
// PROTECTED
//
bool ConfigurationCore::sendFrame(TXRX::configuration_data_t* request) {
	m_serialPort.write((char*)request, PACKET_SIZE);
	return m_serialPort.waitForBytesWritten(1000);
}

bool ConfigurationCore::waitFrame(TXRX::configuration_data_t* response) {

	// Wait 1s
	for (int i = 0; i < 20; ++i) {

		if (m_serialPort.waitForReadyRead(100) == true) {

			if (m_serialPort.bytesAvailable() >= PACKET_SIZE) {
				m_serialPort.read((char*)response, PACKET_SIZE);
				return true;
			}
		}
		QApplication::processEvents();
	}
	return false;
}

bool ConfigurationCore::checkFrame(TXRX::configuration_data_t* response, int command) {

	// Check CRC
	quint32 CRC = calcCRC((quint8*)response);
	if (response->CRC != CRC) {
		return false;
	}

	// Check command code
	if (response->command != command) {
		return false;
	}

	return true;
}

bool ConfigurationCore::sendCommand(TXRX::configuration_data_t* request, TXRX::configuration_data_t* response, bool isDisplaySteps) {

	do {

		this->displayOperation("Открытие порта...", "#FFFFFF", true, isDisplaySteps);
		if (m_serialPort.open(QSerialPort::ReadWrite) == false) {
			break;
		}

		this->displayOperation("Посылка запроса...", "#FFFFFF", true, isDisplaySteps);
		if (sendFrame(request) == false) {
			break;
		}

		this->displayOperation("Ожидание ответа...", "#FFFFFF", true, isDisplaySteps);
		if (waitFrame(response) == false) {
			break;
		}

		this->displayOperation("Проверка ответа...", "#FFFFFF", true, isDisplaySteps);
		if (checkFrame(response, request->command) == false) {
			break;
		}

		this->displayOperation("Закрытие порта...", "#FFFFFF", true, isDisplaySteps);
		m_serialPort.close();
		return true;
	}
	while (false);

	this->displayOperation("Ошибка операции", "#FF0000", true, isDisplaySteps);
	this->displayOperation("Закрытие порта...", "#FFFFFF", true, isDisplaySteps);
	m_serialPort.close();
	return false;
}

quint32 ConfigurationCore::calcCRC(quint8* data) {

	uint32_t CRC = 0;
	for (uint32_t i = 0; i < PACKET_SIZE_WITHOUT_CRC; ++i) {
		CRC += data[i];
	}
	return CRC;
}

void ConfigurationCore::displayOperation(QString text, QString color, bool isUsePortName, bool isDisplayOperation) {

	if (isDisplayOperation == true) {

		if (isUsePortName == true)
			emit setMessageText(m_serialPort.portName() + ": " + text, color);
		else
			emit setMessageText(text, color);
	}
}


//
// SLOTS
//
bool ConfigurationCore::runConnection() {

	auto portList = QSerialPortInfo::availablePorts();
	for (int i = 0; i < portList.size(); ++i) {

		m_serialPort.setPortName(portList[i].portName());

		// Make command
		TXRX::configuration_data_t request = {0};
		TXRX::configuration_data_t response = {0};

		request.command = TXRX::CMD_CONFIG_READ_INFORMATION;
		request.CRC = calcCRC((quint8*)&request);

		// Send command
		if (sendCommand(&request, &response, false) == false) {
			continue;
		}

		// Parse ID in format: XX:XX:XX:XX
		QString hexNumber[4];
		for (int j = 0; j < 4; ++j) {
			hexNumber[j] = QString::number(response.data[j], 16).toUpper();
			if (hexNumber[j].size() != 2)
				hexNumber[j].insert(0, "0");
		}
		m_deviceID = hexNumber[0] + ":" + hexNumber[1] + ":" +
					 hexNumber[2] + ":" + hexNumber[3];

		// Parse FW version
		m_firmwareVersion = QString::number(response.data[4]) + "." +
							QString::number(response.data[5]) + "." +
							QString::number(response.data[6]);

		emit updateQML();
		return true;
	}
	return false;
}

void ConfigurationCore::stopConnection() {
	m_serialPort.close();
}

void ConfigurationCore::readMemoryDump() {

	this->displayOperation("Загрузка конфигурации", "#FFFF00", true, true);

	// Make command
	TXRX::configuration_data_t request = {0};
	TXRX::configuration_data_t response = {0};

	request.command = TXRX::CMD_CONFIG_READ_MEMORY;
	request.CRC = calcCRC((quint8*)&request);

	// Send command
	if (sendCommand(&request, &response, true) == false) {
		return;
	}

	// Display memory dump
	this->displayOperation("Отображение образа", "#FFFFFF", true, true);
	for (int i = 0; i < sizeof(response.data); ++i) {
		QString value = QString::number(response.data[i], 16).toUpper();
		if (value.size() == 1)
			value.insert(0, '0');

		QMetaObject::invokeMethod(m_configWidget, "setCellValue",
								  Q_ARG(QVariant, i), Q_ARG(QVariant, value));
	}

	this->displayOperation("Операция завершена", "#00FF00", true, true);
}

void ConfigurationCore::writeMemoryDump() {

	this->displayOperation("Сохранение конфигурации", "#FFFF00", true, true);

	// Make command
	TXRX::configuration_data_t request = {0};
	TXRX::configuration_data_t response = {0};

	request.command = TXRX::CMD_CONFIG_WRITE_MEMORY;

	// Read memory dump
	this->displayOperation("Формирование образа", "#FFFFFF", true, true);
	for (int i = 0; i < 256; ++i) {
		QVariant value;
		QMetaObject::invokeMethod(m_configWidget, "getCellValue",
								  Q_RETURN_ARG(QVariant, value), Q_ARG(QVariant, i));
		request.data[i] = value.toString().toInt(nullptr, 16);
	}

	request.CRC = calcCRC((quint8*)&request);

	// Send command
	if (sendCommand(&request, &response, true) == false) {
		return;
	}

	this->displayOperation("Операция завершена", "#00FF00", true, true);
}

void ConfigurationCore::saveDumpToFile() {

	this->displayOperation("Запись в файл", "#FFFF00", false, true);

	// Get path to file
	QString path = QFileDialog::getSaveFileName(nullptr, "", "MemoryDump", "*.mdump");
	if (path.size() == 0) {
		return;
	}

	do {

		// Open file
		this->displayOperation("Создание файла...", "#FFFFFF", false, true);
		QFile file(path);
		if (file.open(QFile::WriteOnly) == false) {
			break;
		}

		// Write dump to file
		this->displayOperation("Сохранение образа...", "#FFFFFF", false, true);
		file.write(QString("# File: " + path + "\n").toUtf8());
		file.write(QString("# Date: " + QDate::currentDate().toString("dd.MM.yyyy") + "\n").toUtf8());
		file.write(QString("# Time: " + QTime::currentTime().toString("hh:mm:ss") + "\n").toUtf8());
		file.write("\nIMAGE:\n");

		for (int i = 0; i < 256; ++i) {

			QVariant value;
			QMetaObject::invokeMethod(m_configWidget, "getCellValue", Q_RETURN_ARG(QVariant, value), Q_ARG(QVariant, i));

			file.write(value.toString().toUtf8());
			if ((i + 1) % 16 == 0)
				file.write("\n");
			else
				file.write(" ");

			QApplication::processEvents();
		}

		// Set operation complete text
		this->displayOperation("Операция завершена", "#00FF00", false, true);
		return;
	}
	while (false);

	// Set error text
	this->displayOperation("Ошибка операции", "#FF0000", false, true);
}

void ConfigurationCore::loadDumpFromFile() {

	// Set operation
	this->displayOperation("Загрузка из файла", "#FFFF00", true, true);

	do {
		// Get path to file
		this->displayOperation("Запрос пути файла...", "#FFFFFF", false, true);
		QString path = QFileDialog::getOpenFileName(nullptr, "", "", "*.mdump");
		if (path.size() == 0) {
			emit setMessageText("Операция отменена", "#00FFFF");
			return;
		}

		// Open file
		this->displayOperation("Открытие файла...", "#FFFFFF", false, true);
		QFile file(path);
		if (file.open(QFile::ReadOnly) == false) {
			break;
		}

		// Find IMAGE: tag
		this->displayOperation("Поиск тега IMAGE...", "#FFFFFF", false, true);
		bool isFinded = false;
		while (file.atEnd() == false) {

			QString str(file.readLine());
			if (str == "IMAGE:\n") {
				isFinded = true;
				break;
			}


		}
		if (isFinded == false) {
			break;
		}

		// Read memory image
		this->displayOperation("Чтение образа...", "#FFFFFF", false, true);
		int address = 0;
		while (file.atEnd() == false) {

			QString str(file.readLine());

			while (str.size() != 0) {

				int index = str.indexOf(QRegExp("[0-9]|[A-F]"));
				if (index == -1) {
					break;
				}

				str = str.remove(0, index);
				QString value = str.mid(0, 2);
				str = str.remove(0, 2);

				QMetaObject::invokeMethod(m_configWidget, "setCellValue",
										  Q_ARG(QVariant, address), Q_ARG(QVariant, value));

				++address;
			}
			QApplication::processEvents();
		}

		// Set operation complete text
		this->displayOperation("Операция завершена", "#00FF00", false, true);
		return;
	}
	while (false);

	// Set error text
	this->displayOperation("Ошибка операции", "#FF0000", false, true);
}

void ConfigurationCore::softwareResetController() {

	// Make command
	TXRX::configuration_data_t request = {0};
	TXRX::configuration_data_t response = {0};

	request.command = TXRX::CMD_CONFIG_RESET;
	memset(request.data, 0x00, sizeof(request.data));
	request.CRC = calcCRC((quint8*)&request);

	// Send command
	if (sendCommand(&request, &response, true) == false) {
		return;
	}

	this->displayOperation("Операция завершена", "#00FF00", true, true);
}

