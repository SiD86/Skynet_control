import QtQuick 2.0
import QtQuick.Controls 2.3

Item {
	width: 265
	height: 260

	Timer {
		id: blinkTimer
		interval: 600
		repeat: true
		onTriggered: {
			defenceLabel.visible = !defenceLabel.visible
		}
	}

	Label {
		width: 265
		height: 20
		text: "Текущий режим полета"
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		color: "#FFFFFF"

		Frame {
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			width: 65
			height: 1
		}

		Frame {
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			width: 65
			height: 1
		}
	}

	CTRL_StatusLabel {
		id: defenceLabel
		x: 90
		y: 85
		width: 85
		height: 55
		activeColor: "#CDCD00"
		isActive: mainCore.flyCoreMode == 0xFF
		text: "Защита"

		onIsActiveChanged: {
			if (isActive == true) {
				blinkTimer.running = true
			} else {
				blinkTimer.running = false
				defenceLabel.visible = true
			}
		}
	}
	CTRL_StatusLabel {
		x: 90
		y: 145
		width: 85
		height: 55
		activeColor: "#CDCD00"
		isActive: mainCore.flyCoreMode == 0x01
		text: "Ожидание"
	}
	CTRL_StatusLabel {
		x: 90
		y: 205
		width: 85
		height: 55
		activeColor: "#CDCD00"
		isActive: mainCore.flyCoreMode == 0x02
		text: "Cтабилизация"
	}
	CTRL_StatusLabel {
		x: 180
		y: 145
		width: 85
		height: 55
		activeColor: "#CDCD00"
		isActive: mainCore.flyCoreMode == 0x03
		text: "Настройка\nПИД\n(гироскоп)"
	}
	CTRL_StatusLabel {
		x: 180
		y: 205
		width: 85
		height: 55
		activeColor: "#CDCD00"
		isActive: mainCore.flyCoreMode == 0x04
		text: "Настройка\nПИД\n(кватернионы)"
	}
	CTRL_StatusLabel {
		x: 0
		y: 85
		width: 85
		height: 55
		activeColor: "#CDCD00"
		text: "НЕТ"
	}
	CTRL_StatusLabel {
		x: 0
		y: 145
		width: 85
		height: 55
		activeColor: "#CDCD00"
		text: "НЕТ"
	}
	CTRL_StatusLabel {
		x: 0
		y: 25
		width: 85
		height: 55
		activeColor: "#CDCD00"
		text: "НЕТ"
	}
	CTRL_StatusLabel {
		x: 0
		y: 205
		width: 85
		height: 55
		text: "НЕТ"
		activeColor: "#CDCD00"
	}
	CTRL_StatusLabel {
		x: 180
		y: 25
		width: 85
		height: 55
		text: "НЕТ"
		activeColor: "#CDCD00"
	}
	CTRL_StatusLabel {
		x: 180
		y: 85
		width: 85
		height: 55
		text: "НЕТ"
		activeColor: "#CDCD00"
	}

	CTRL_StatusLabel {
		x: 90
		y: 25
		width: 85
		height: 55
		text: "НЕТ"
		activeColor: "#CDCD00"
	}
}
