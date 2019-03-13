import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	clip: true

	signal startConnectToServer

	function showErrorMessage(message) {
		errorMessageLabel.text = message
		errorMessageLabel.visible = true
	}
	function hideErrorMessage() {
		errorMessageLabel.visible = false
	}

	Pane {
		id: pane
		x: 38
		y: 35
		width: 485
		height: 410
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		padding: 0

		Image {
			id: image
			height: 330
			anchors.top: parent.top
			anchors.topMargin: 0
			anchors.right: parent.right
			anchors.rightMargin: 0
			anchors.left: parent.left
			anchors.leftMargin: 0
			source: "qrc:/images/logo.png"
		}

		Button {
			id: button
			x: -50
			y: 381
			width: 285
			height: 60
			text: qsTr("ПОДКЛЮЧИТЬСЯ К УСТРОЙСТВУ")
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 0
			anchors.right: parent.right
			anchors.rightMargin: 0
			anchors.left: parent.left
			anchors.leftMargin: 0

			onClicked: {
				root.startConnectToServer()
			}
		}

		Label {
			id: errorMessageLabel
			x: -40
			y: 361
			height: 15
			visible: false
			color: "#ff0000"
			text: qsTr("")
			anchors.left: parent.left
			anchors.leftMargin: 0
			anchors.right: parent.right
			anchors.rightMargin: 0
			anchors.bottom: button.top
			anchors.bottomMargin: 0
			verticalAlignment: Text.AlignBottom
		}
	}
}




/*##^## Designer {
	D{i:0;autoSize:true;height:480;width:640}D{i:4;anchors_width:500;anchors_x:0;anchors_y:0}
D{i:2;anchors_x:160}
}
 ##^##*/
