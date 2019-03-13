import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 1000
	height: 600
	clip: true

	WidgetHexapod {
		x: 210
		y: 5
	}
	WidgetModulesStatus {
		x: 823
		y: 5
	}
	WidgetSystemStatus {
		x: 5
		y: 5
	}
}
