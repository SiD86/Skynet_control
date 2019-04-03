#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include <QDebug>
#include "wirelessmodbus.h"
#include "core.h"
#include "configurationsmanager.h"


int main(int argc, char *argv[]) {

	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);
	WirelessModbus wirelessModbus;
	Core core(&wirelessModbus);
	ConfigurationsManager configurationsManager(&wirelessModbus);

	QQmlApplicationEngine engine;
	engine.rootContext()->setContextProperty("CppCore", &core);
	engine.rootContext()->setContextProperty("CppConfigurationsManager", &configurationsManager);
	engine.load(QUrl(QStringLiteral("qrc:/AndroidQML/main.qml")));
	if (engine.rootObjects().isEmpty()) {
		return -1;
	}

	return app.exec();
}
