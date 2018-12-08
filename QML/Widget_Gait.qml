import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	width: 265
	height: 200
	clip: true

	Label {
		width: 265
		height: 20
		text: "Главное ядро"
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		color: "#FFFFFF"

		Frame {
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			width: 90
			height: 1
		}

		Frame {
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			width: 90
			height: 1
		}
	}

	CTRL_StatusLabel {
		x: 90
		y: 25
		width: 85
		height: 115
		text: "Состояние\nядра"
		deactiveColor: "#00CD00"
		isActive: mainCore.mainCoreStatus & 0x01
	}

	CTRL_StatusLabel {
		x: 180
		y: 145
		width: 85
		height: 55
		text: "Конфигурация"
		deactiveColor: "#00CD00"
		isActive: mainCore.mainCoreStatus & 0x02
	}

	CTRL_StatusLabel {
		x: 180
		y: 85
		width: 85
		height: 55
		text: "Соединение"
		deactiveColor: "#00CD00"
		isActive: mainCore.mainCoreStatus & 0x04
	}

	CTRL_StatusLabel {
		x: 180
		y: 25
		width: 85
		height: 55
		text: "НЕТ"
		//deactive_color: "#00CD00"
		activeColor: "#555555"
		isActive: mainCore.mainCoreStatus & 0x08
	}

	CTRL_StatusLabel {
		x: 90
		y: 145
		width: 85
		height: 55
		text: "Основное\nпитание"
		deactiveColor: "#00CD00"
		isActive: mainCore.mainCoreStatus & 0x10
	}

	CTRL_StatusLabel {
		x: 0
		y: 85
		width: 85
		height: 55
		text: "Питание\nпередатчика"
		deactiveColor: "#00CD00"
		isActive: mainCore.mainCoreStatus & 0x20
	}

	CTRL_StatusLabel {
		x: 0
		y: 145
		width: 85
		height: 55
		text: "Питание\nсенсоров"
		deactiveColor: "#00CD00"
		isActive: mainCore.mainCoreStatus & 0x40
	}

	CTRL_StatusLabel {
		x: 0
		y: 25
		width: 85
		height: 55
		text: "Питание\nкамеры"
		deactiveColor: "#00CD00"
		isActive: mainCore.mainCoreStatus & 0x80
	}
}
