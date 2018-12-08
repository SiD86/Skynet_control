#include <QApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickItem>
#include "core.h"
#include "wirelesscontroller.h"


static Core g_mainCore;
WirelessController g_wirelessController;


int main(int argc, char *argv[]) {

	QApplication app(argc, argv);

	QQuickView viewer;
	viewer.engine()->rootContext()->setContextProperty("mainCore", &g_mainCore);
	viewer.engine()->rootContext()->setContextProperty("wirelessController", &g_wirelessController);
	viewer.setSource(QUrl("qrc:/QML/MainWindow.qml"));
	viewer.setResizeMode(QQuickView::SizeRootObjectToView);

	g_mainCore.initialize(viewer.rootObject());
	//g_wirelessController.initialize(...); Initialized in g_mainCore.initialize()

	viewer.show();

	return app.exec();
}
