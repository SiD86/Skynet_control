#ifndef LOGCONTROLLER_H
#define LOGCONTROLLER_H

#include <QFile>
#include "TXRX_PROTOCOL.h"

class LogController : public QObject
{
	Q_OBJECT
protected:
    QFile m_file;
    TXRX::state_data_t* m_sp;
    TXRX::control_data_t* m_cp;
    QString m_buffer; // Buffer for save harddrive

public:
	LogController(TXRX::state_data_t* sp, TXRX::control_data_t* cp, QObject* parent);
    ~LogController();
	void writeParameters();
};

#endif // LOGCONTROLLER_H
