import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 80
	height: 80

	signal buttonClicked
	signal buttonPressed
	signal buttonReleased

	property string image: ""

	MouseArea {
		z: 1
		anchors.fill: parent
		hoverEnabled: true

		onClicked: {
			root.buttonClicked()
		}
		onPressedChanged: {

			if (pressed) {
				frameRectangle.border.color = "#00FFFF"
				root.buttonPressed()
			} else {
				frameRectangle.border.color = "#AAAAAA"
				root.buttonReleased()
			}
		}
	}

	Rectangle {
		id: frameRectangle
		anchors.fill: parent
		color: "#00000000"
		border.color: "#AAAAAA"
	}

	Image {
		anchors.fill: parent
		anchors.rightMargin: 3
		anchors.leftMargin: 3
		anchors.bottomMargin: 3
		anchors.topMargin: 3
		source: image
	}
}
