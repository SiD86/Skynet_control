import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	width: 355
	height: 200
	clip: true

	Label {
		x: 0
		y: 0
		width: 355
		height: 20
		text: "Статус системы передвижения"
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
		x: 0
		y: 145
		width: 85
		height: 55
		text: "Уменьшение\nклиренса"
		isActive: mainCore.flyCoreStatus & 0x0080
	}

	CTRL_StatusLabel {
		x: 0
		y: 85
		width: 85
		height: 55
		text: "Движение\nвлево"
		isActive: mainCore.flyCoreStatus & 0x4000
	}

	CTRL_StatusLabel {
		x: 180
		y: 145
		width: 85
		height: 55
		text: "Увеличение\nклиренса"
		isActive: mainCore.flyCoreStatus & 0x0040
	}

	CTRL_StatusLabel {
		x: 0
		y: 25
		width: 85
		height: 55
		text: "Поворот\nналево"
		isActive: mainCore.flyCoreStatus & 0x4000
	}

	CTRL_StatusLabel {
		x: 270
		y: 85
		width: 85
		height: 55
		text: "Спуск\nна брюхо"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 270
		y: 25
		width: 85
		height: 55
		text: "Подъем\nна ноги"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 180
		y: 85
		width: 85
		height: 55
		text: "Движение\nвправо"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 180
		y: 25
		width: 85
		height: 55
		text: "Поворот\nнаправо"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 90
		y: 25
		width: 85
		height: 55
		text: "Движение\nвперед"
		isActive: mainCore.flyCoreStatus & 0x4000
	}

	CTRL_StatusLabel {
		x: 90
		y: 145
		width: 85
		height: 55
		text: "Движение\nназад"
		isActive: mainCore.flyCoreStatus & 0x0080
	}

	CTRL_StatusLabel {
		x: 270
		y: 145
		width: 85
		height: 55
		text: "Reserved"
		isActive: mainCore.flyCoreStatus & 0x0080
	}

	CTRL_StatusLabel {
		x: 90
		y: 85
		width: 85
		height: 55
		text: "Ожидание"
		isActive: mainCore.flyCoreStatus & 0x0080
	}
}
