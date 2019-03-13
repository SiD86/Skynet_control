import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true

	BusyIndicator {
		id: busyIndicator
		x: 290
		y: 210
		width: 60
		height: 60
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
	}

	Label {
		id: label
		x: 193
		text: "Подключение к устройству..."
		anchors.top: busyIndicator.bottom
		anchors.topMargin: 5
		anchors.horizontalCenter: parent.horizontalCenter
		font.pointSize: 14
	}
}
