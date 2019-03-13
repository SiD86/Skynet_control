import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true

	signal startConnectToServer

	function showErrorMessage(message) {
		errorMessageLabel.text = message
		errorMessageLabel.visible = true
	}
	function hideErrorMessage() {
		errorMessageLabel.visible = false
	}

	Label {
		id: errorMessageLabel
		y: 340
		height: 20
		visible: false
		color: "#ff0000"
		text: qsTr("")
		font.pointSize: 14
		horizontalAlignment: Text.AlignHCenter
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		verticalAlignment: Text.AlignVCenter
	}

	Image {
		id: logoImage
		height: 355
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		fillMode: Image.PreserveAspectFit
		source: "qrc:/images/logo.png"
	}

	Image {
		id: powerImage
		width: 256
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 30
		anchors.left: parent.left
		anchors.leftMargin: 50
		anchors.right: parent.right
		anchors.rightMargin: 50
		anchors.top: logoImage.bottom
		anchors.topMargin: 10
		fillMode: Image.PreserveAspectFit
		source: "qrc:/images/power_released.png"

		MouseArea {
			anchors.bottomMargin: 50
			anchors.rightMargin: 50
			anchors.leftMargin: 50
			anchors.fill: parent
			onPressed: {
				powerImage.source = "qrc:/images/power_pressed.png"
			}
			onReleased: {
				powerImage.source = "qrc:/images/power_released.png"
			}
			onClicked: {
				root.startConnectToServer()
			}
		}
	}
}

/*##^## Designer {
	D{i:4;anchors_width:582;anchors_x:58;anchors_y:5}D{i:3;anchors_height:256;anchors_x:186}
}
 ##^##*/

