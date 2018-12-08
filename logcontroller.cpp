#include <QFile>
#include <QTime>
#include <QTimer>
#include <QDate>
#include <QDebug>
#include "logcontroller.h"

LogController::LogController(TXRX::state_data_t* sp, TXRX::control_data_t* cp, QObject* parent) : QObject(parent) {

    m_sp = sp;
    m_cp = cp;

	QString file_name = QDate::currentDate().toString("D:\\NEO4X_yyMMdd_") +
                        QTime::currentTime().toString("hhmmss") + ".csv";
    m_file.setFileName(file_name);

    m_buffer += "main_core_status;";
    m_buffer += "fly_core_mode;";
    m_buffer += "fly_core_status;";
    m_buffer += "motors_power[0];";
    m_buffer += "motors_power[1];";
    m_buffer += "motors_power[2];";
    m_buffer += "motors_power[3];";
    m_buffer += "dest XYZ[0];";
    m_buffer += "dest XYZ[1];";
    m_buffer += "dest XYZ[2];";
	m_buffer += "XYZH[0];";
	m_buffer += "XYZH[1];";
	m_buffer += "XYZH[2];";
	m_buffer += "XYZH[3];";
	m_buffer += "gyro[0];";
	m_buffer += "gyro[1];";
	m_buffer += "gyro[2];";
    m_buffer += "battery_voltage;";
    m_buffer += "\n";
}

LogController::~LogController() {

	if (m_file.open(QFile::Append) == false) {
        return;
    }

    m_file.write(m_buffer.toUtf8(), m_buffer.size());
    m_file.close();
}

void LogController::writeParameters() {

    // Write parameters value to buffer (format .csv)
    m_buffer += QString::number(m_sp->main_core_status, 2) + ";";
    m_buffer += QString::number(m_sp->fly_core_mode, 2) + ";";
    m_buffer += QString::number(m_sp->fly_core_status, 2) + ";";

    m_buffer += QString::number(m_sp->motors_power[0]) + ";";
    m_buffer += QString::number(m_sp->motors_power[1]) + ";";
    m_buffer += QString::number(m_sp->motors_power[2]) + ";";
    m_buffer += QString::number(m_sp->motors_power[3]) + ";";

	m_buffer += QString::number(m_cp->XYZ[0]) + ";";
	m_buffer += QString::number(m_cp->XYZ[1]) + ";";
	m_buffer += QString::number(m_cp->XYZ[2]) + ";";

	m_buffer += QString::number(m_sp->XYZ[0] / 100.0) + ";";
	m_buffer += QString::number(m_sp->XYZ[1] / 100.0) + ";";
	m_buffer += QString::number(m_sp->XYZ[2] / 100.0) + ";";
	m_buffer += QString::number(m_sp->alttitude) + ";";

	m_buffer += QString::number(m_sp->gyro_XYZ[0]) + ";";
	m_buffer += QString::number(m_sp->gyro_XYZ[1]) + ";";
	m_buffer += QString::number(m_sp->gyro_XYZ[2]) + ";";

	m_buffer += QString::number(m_sp->main_voltage) + ";";

    m_buffer += "\n";

	if (m_buffer.size() < 10240)
        return;

    qDebug() << "Save data...";
	if (m_file.open(QFile::Append) == false) {
        return;
	}

    m_file.write(m_buffer.toUtf8(), m_buffer.size());
    m_file.close();
    m_buffer.clear();
}
