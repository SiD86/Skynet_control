import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

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

	GridLayout {
		id: gridLayout
		anchors.top: parent.top
		anchors.topMargin: 10
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
		rows: 4
		columns: 2

		Image {
			clip: true
			Layout.columnSpan: 2
			Layout.fillHeight: false
			Layout.fillWidth: true
			fillMode: Image.PreserveAspectFit
			source: "qrc:/images/logo.png"
		}

		MetroButton {
			image: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {
				startConnectToServer()
			}
		}

		MetroButton {
			image: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {
				startConnectToServer()
			}
		}

		MetroButton {
			image: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {
				startConnectToServer()
			}
		}

		MetroButton {
			image: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {
				startConnectToServer()
			}
		}
	}
}

/*##^## Designer {
	D{i:3;anchors_height:374;anchors_width:480;anchors_x:10;anchors_y:360}D{i:4;anchors_width:582;anchors_x:58;anchors_y:5}
D{i:2;anchors_height:374;anchors_width:480;anchors_x:10;anchors_y:360}
}
 ##^##*/

