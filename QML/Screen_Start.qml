import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle {
	id: root
	width: 1255
	height: 680
	clip: true
	color: "#000000"

	signal showDroneInfoScreen
	signal showConfigurationScreen

	// IDLE
	// CONNECTING
	// FAIL
	property string currentState: "IDLE"
	onCurrentStateChanged: {
		labelWait.visible = true

		if (currentState == "IDLE") {
			labelWait.text = "Ожидание команды..."
			labelWait.color = "#FFFFFF"
			progressBar.visible = false
			buttonConnect.visible = true
			buttonConfigurationMode.visible = true
		}
		if (currentState == "CONNECTING") {
			labelWait.text = "Установка соединения..."
			labelWait.color = "#FFFF00"
			progressBar.visible = true
			buttonConnect.visible = false
			buttonConfigurationMode.visible = false
		}
		if (currentState == "FAIL") {
			labelWait.text = "Ошибка соединения"
			labelWait.color = "#FF0000"
			progressBar.visible = false
			buttonConnect.visible = true
			buttonConfigurationMode.visible = true
		}
	}

	Label {
		x: 383
		y: 78
		width: 490
		height: 100
		color: "#B8FBFA"
		text: "NEO4X SKY"
		font.pointSize: 70
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
	}

	Label {
		id: labelWait
		x: 383
		y: 295
		width: 490
		height: 20
		color: "#ffffff"
		text: "Ожидание команды..."
		lineHeight: 0.8
		visible: false
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignLeft
	}

	ProgressBar {
		id: progressBar
		x: 383
		y: 320
		width: 490
		height: 6
		visible: false
		indeterminate: true
	}

	CTRL_Button {
		id: buttonConnect
		x: 383
		y: 320
		width: 490
		height: 40
		text: "Установить соединение"
		onClicked: {
			currentState = "CONNECTING"
			if (wirelessController.runConnection() == true) {
				showDroneInfoScreen()
				currentState = "IDLE"
			} else {
				currentState = "FAIL"
			}
		}
	}

	CTRL_Button {
		id: buttonConfigurationMode
		x: 383
		y: 365
		width: 490
		height: 40
		text: "Войти в режим конфигурации"
		onClicked: {
			currentState = "CONNECTING"
			if (configCore.runConnection() == true) {
				showConfigurationScreen()
				currentState = "IDLE"
			} else {
				currentState = "FAIL"
			}
		}
	}

	Label {
		x: 5
		y: 662
		color: "#ffffff"
		text: "Версия: " + mainCore.getVersion()
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignLeft
		MouseArea {
			anchors.fill: parent
			onClicked: {
				showDroneInfoScreen()
			}
		}
	}
}
