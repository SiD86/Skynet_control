import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 80
	height: 80

	signal bottonClicked

	MouseArea {
		z: 1
		anchors.fill: parent

		onClicked: {
			root.bottonClicked
		}
		onPressed: {
			frameRectangle.border.color = "#00FFFF"
		}
		onReleased: {
			frameRectangle.border.color = "#AAAAAA"
		}
	}

	Rectangle {
		id: frameRectangle
		anchors.fill: parent
		color: "#00000000"
		border.color: "#AAAAAA"
	}

	Image {
		id: image
		anchors.fill: parent
		anchors.rightMargin: -3
		anchors.leftMargin: -3
		anchors.bottomMargin: -3
		anchors.topMargin: -3

		//source: "qrc:/qtquickplugin/images/template_image.png"
	}
}
