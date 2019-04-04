#ifndef CONFIGURATIONSMANAGER_H
#define CONFIGURATIONSMANAGER_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include "wirelessmodbus.h"


class ConfigurationsManager : public QObject
{
	Q_OBJECT
public:
	explicit ConfigurationsManager(WirelessModbus* wirelessModbus, QObject *parent = nullptr);
	Q_INVOKABLE bool loadConfigurationList(void);
	Q_INVOKABLE bool loadConfiguration(QString configurationName);
	Q_INVOKABLE void abortOperations(void);

signals:
	void configurationFound(QString fileName);
	void showLogMessage(QString message);

private:
	WirelessModbus* m_wirelessModbus;
	QNetworkRequest m_networkRequest;
	QNetworkAccessManager m_accessManager;
	QNetworkReply* m_networkReply;
	QByteArray m_downloadData;
	bool m_isDownloadInProgress;
};


#endif // CONFIGURATIONSMANAGER_H
