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

	Button {
		id: button
		width: 285
		height: 60
		text: qsTr("ПОДКЛЮЧИТЬСЯ К УСТРОЙСТВУ")
		anchors.bottom: parent.bottom
		anchors.bottomMargin: -8
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
		y: 340
		height: 15
		visible: false
		color: "#ff0000"
		text: qsTr("")
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.bottom: button.top
		anchors.bottomMargin: 5
		verticalAlignment: Text.AlignBottom
	}

	Label {
		id: label
		y: 165
		width: 300
		height: 150
		color: "#00b1fd"
		text: qsTr("SKYNET HEXAPOD CONTROL")
		anchors.left: parent.left
		anchors.leftMargin: 0
		anchors.right: parent.right
		anchors.rightMargin: 0
		wrapMode: Text.WordWrap
		anchors.verticalCenter: parent.verticalCenter
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		font.pointSize: 40
	}
}

/*##^## Designer {
	D{i:0;autoSize:true;height:480;width:640}D{i:2;anchors_x:160}D{i:3;anchors_height:20;anchors_width:285;anchors_x:160;anchors_y:340}
}
 ##^##*/

