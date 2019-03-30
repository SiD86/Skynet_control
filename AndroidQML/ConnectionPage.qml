import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true

	signal goToStartPage
	signal goToControlPage

	function startConnection() {

		busyIndicator.visible = true
		errorImage.visible = false
		buttonBack.visible = false
		labelText.text = qsTr("Подключение к устройству...")
		labelText.color = "#FFFFFF"

		if (!CppCore.connectToServer()) {
			busyIndicator.visible = false
			errorImage.visible = true
			buttonBack.visible = true
			labelText.text = qsTr("Ошибка при подключении к устройству")
			labelText.color = "#FF0000"
		} else {
			goToControlPage()
		}
	}

	BusyIndicator {
		id: busyIndicator
		x: 290
		y: 210
		width: 100
		height: 100
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
	}

	Image {
		id: errorImage
		x: 290
		y: 210
		width: 100
		height: 100
		visible: false
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		sourceSize.width: width
		sourceSize.height: height
		fillMode: Image.PreserveAspectFit
		source: "qrc:/images/error.svg"
	}

	Label {
		id: labelText
		height: 30
		text: "Подключение к устройству..."
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		anchors.left: parent.left
		anchors.leftMargin: 5
		anchors.right: parent.right
		anchors.rightMargin: 5
		anchors.top: busyIndicator.bottom
		anchors.topMargin: 20
		font.pointSize: 14
	}

	Button {
		id: buttonBack
		x: 123
		width: 255
		height: 48
		text: qsTr("НАЗАД")
		anchors.top: labelText.bottom
		anchors.topMargin: 20
		anchors.horizontalCenter: parent.horizontalCenter
		visible: false
		onClicked: {
			goToStartPage()
		}
	}
}

/*##^## Designer {
	D{i:3;anchors_height:329;anchors_width:337;anchors_x:193;anchors_y:5}D{i:4;anchors_width:255;anchors_x:123;anchors_y:549}
}
 ##^##*/

