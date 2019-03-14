import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 80
	height: 80

	signal buttonClicked

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
				frameRectangle.color = "#4D95D1"
			} else {
				frameRectangle.color = "#2582D3"
			}
		}
	}

	Rectangle {
		id: frameRectangle
		anchors.fill: parent
		color: "#2582D3"
		border.width: 0
	}

	Image {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		sourceSize.width: width
		sourceSize.height: height
		source: image
		width: (root.width > root.height) ? root.height : root.width
		height: width
	}
}
