#include <QApplication>
#include <QQuickView>
#include <QQmlEngine>
#include <QQmlContext>
#include <QQuickItem>

/*Core g_mainCore;
ConfigurationCore g_configCore;
WirelessController g_wirelessController;*/

int main(int argc, char *argv[]) {

	QApplication app(argc, argv);

	QQuickView viewer;
	//viewer.engine()->rootContext()->setContextProperty("mainCore", &g_mainCore);
	//viewer.engine()->rootContext()->setContextProperty("configCore", &g_configCore);
	//viewer.engine()->rootContext()->setContextProperty("wirelessController", &g_wirelessController);
	viewer.setSource(QUrl("qrc:/QML/MainWindow.qml"));
	viewer.setResizeMode(QQuickView::SizeRootObjectToView);

	//g_mainCore.initialize(viewer.rootObject());
	//g_configCore.initialize(viewer.rootObject());
	//g_wirelessController.initialize(...); Initialized in g_mainCore.initialize()

	viewer.show();

	return app.exec();
}
