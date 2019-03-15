import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Item {

	signal buttonClicked
	signal buttonPressed
	signal buttonReleased

	property string imageSrc: ""
	property string imageColor: "#FFFFFF"
	property string backgroundColor: "#00000000"

	id: root
	width: 80
	height: 80

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
		color: backgroundColor
		border.color: "#AAAAAA"
		border.width: 2
	}

	Image {
		id: buttonImage
		visible: false
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		width: (root.width > root.height) ? (root.height * 0.75) : (root.width * 0.75)
		height: (root.width > root.height) ? (root.height * 0.75) : (root.width * 0.75)
		sourceSize.width: width
		sourceSize.height: height
		source: imageSrc
	}

	ColorOverlay {
		anchors.fill: buttonImage
		smooth: true
		antialiasing: true
		source: buttonImage
		color: imageColor
	}
}
