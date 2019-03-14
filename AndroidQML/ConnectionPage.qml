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

	Image {
		id: image
		sourceSize.height: height
		sourceSize.width: width
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 554
		anchors.right: parent.right
		anchors.rightMargin: 158
		anchors.left: parent.left
		anchors.leftMargin: 5
		anchors.top: parent.top
		anchors.topMargin: 5
		source: "qrc:/images/1.svg"
		fillMode: Image.PreserveAspectFit
	}
}

/*##^## Designer {
	D{i:3;anchors_height:329;anchors_width:337;anchors_x:5;anchors_y:5}
}
 ##^##*/

