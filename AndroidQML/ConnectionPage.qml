import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true

	signal showControlPage

	function connectToDevice() {

		labelText.text = "Подключение к устройству..."
		labelText.color = "#FFFFFF"
		connectButton.visible = false
		progressBar.visible = true

		if (!CppCore.connectToServer()) {
			labelText.text = "Не удалось подключиться к устройству"
			labelText.color = "#FF0000"
			connectButton.visible = true
			progressBar.visible = false
			return
		}

		connectButton.visible = true
		showControlPage()
	}

	Image {
		id: logoImage
		clip: true
		width: root.width
		height: root.width * (sourceSize.height / sourceSize.width)

		sourceSize.width: 525
		sourceSize.height: 370
		fillMode: Image.PreserveAspectFit
		source: "qrc:/images/logo.png"
	}

	Label {
		id: labelText
		height: 30
		text: ""
		anchors.top: logoImage.bottom
		anchors.topMargin: 50
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		font.pointSize: 14
	}

	Button {
		id: connectButton
		text: qsTr("ПОДКЛЮЧИТЬСЯ")
		anchors.top: labelText.bottom
		anchors.topMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		onClicked: {
			connectToDevice()
		}
	}

	ProgressBar {
		id: progressBar
		visible: false
		anchors.top: labelText.bottom
		anchors.topMargin: 10
		indeterminate: true
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
	}
}

/*##^## Designer {
	D{i:2;anchors_y:407}
}
 ##^##*/

