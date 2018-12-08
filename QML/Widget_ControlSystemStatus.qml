import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	width: 355
	height: 440
	clip: true

	Label {
		x: 0
		y: 0
		width: 355
		height: 20
		text: "Статус системы управления"
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
		x: 270
		y: 145
		width: 85
		height: 55
		text: "Reserved7"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 270
		y: 205
		width: 85
		height: 55
		text: "Reserved5"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 270
		y: 265
		width: 85
		height: 55
		text: "Подсистема\nмонитогинга"
		deactiveColor: "#00CD00"
		isActive: mainCore.flyCoreStatus & 0x1000
	}

	CTRL_StatusLabel {
		x: 270
		y: 325
		width: 85
		height: 55
		text: "Драйвер\nпередвижения"
		deactiveColor: "#00CD00"
		isActive: mainCore.flyCoreStatus & 0x0800
	}

	CTRL_StatusLabel {
		x: 270
		y: 385
		width: 85
		height: 55
		text: "Драйвер\nсервоприводов"
		deactiveColor: "#00CD00"
		isActive: mainCore.flyCoreStatus & 0x0200
	}

	CTRL_StatusLabel {
		x: 270
		y: 25
		width: 85
		height: 55
		text: "Reserved11"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 270
		y: 85
		width: 85
		height: 55
		text: "Reserved9"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 0
		y: 265
		width: 85
		height: 55
		text: "Ошибка\nсинхронизации"
		activeColor: "#CD0000"
		isActive: mainCore.flyCoreStatus & 0x0010
	}

	CTRL_StatusLabel {
		x: 0
		y: 325
		width: 85
		height: 55
		text: "Ошибка\nконфигурации"
		activeColor: "#CD0000"
		isActive: mainCore.flyCoreStatus & 0x0004
	}

	CTRL_StatusLabel {
		x: 0
		y: 385
		width: 85
		height: 55
		text: "Аварийный\nрежим"
		activeColor: "#CD0000"
		isActive: mainCore.flyCoreStatus & 0x0001
	}

	CTRL_StatusLabel {
		x: 0
		y: 205
		width: 85
		height: 55
		text: "Низкое\nнапряжение\n(переферия)"
		isActive: mainCore.flyCoreStatus & 0x0080
	}

	CTRL_StatusLabel {
		x: 0
		y: 85
		width: 85
		height: 55
		text: "Нет сигнала\nс датчика\nкасания"
		isActive: mainCore.flyCoreStatus & 0x4000
	}

	CTRL_StatusLabel {
		x: 0
		y: 145
		width: 85
		height: 55
		text: "Перегрев\nсиловой\nплаты"
		isActive: mainCore.flyCoreStatus & 0x0040
	}

	CTRL_StatusLabel {
		x: 0
		y: 25
		width: 85
		height: 55
		text: "Нет сигнала\nс гироскопа"
		isActive: mainCore.flyCoreStatus & 0x4000
	}

	CTRL_StatusLabel {
		x: 180
		y: 205
		width: 85
		height: 55
		text: "Reserved4"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 180
		y: 265
		width: 85
		height: 55
		text: "Reserved1"
		isActive: mainCore.flyCoreStatus & 0x2000
	}

	CTRL_StatusLabel {
		x: 180
		y: 325
		width: 85
		height: 55
		text: "Драйвер\nконечностей"
		isActive: mainCore.flyCoreStatus & 0x0400
		deactiveColor: "#00CD00"
	}

	CTRL_StatusLabel {
		x: 180
		y: 385
		width: 85
		height: 55
		text: "Виртуальный\nEEPROM"
		isActive: mainCore.flyCoreStatus & 0x0100
		deactiveColor: "#00CD00"
	}

	CTRL_StatusLabel {
		x: 180
		y: 145
		width: 85
		height: 55
		text: "Reserved6"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 180
		y: 85
		width: 85
		height: 55
		text: "Reserved8"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 180
		y: 25
		width: 85
		height: 55
		text: "Reserved10"
		isActive: mainCore.flyCoreStatus & 0x8000
	}

	CTRL_StatusLabel {
		x: 90
		y: 25
		width: 85
		height: 55
		text: "Нет сигнала\nс датчика\nдистанции"
		isActive: mainCore.flyCoreStatus & 0x4000
	}

	CTRL_StatusLabel {
		x: 90
		y: 145
		width: 85
		height: 55
		text: "Низкое\nнапряжение\nАКБ"
		isActive: mainCore.flyCoreStatus & 0x0080
	}

	CTRL_StatusLabel {
		x: 90
		y: 265
		width: 85
		height: 55
		text: "Выход\nпараметра\nза диапазон"
		activeColor: "#CD0000"
		isActive: mainCore.flyCoreStatus & 0x0020
	}

	CTRL_StatusLabel {
		x: 90
		y: 325
		width: 85
		height: 55
		text: "Ошибка\nпамяти"
		activeColor: "#CD0000"
		isActive: mainCore.flyCoreStatus & 0x0008
	}

	CTRL_StatusLabel {
		x: 90
		y: 385
		width: 85
		height: 55
		text: "Внутренняя\nошибка"
		activeColor: "#CD0000"
		isActive: mainCore.flyCoreStatus & 0x0002
	}

	CTRL_StatusLabel {
		x: 90
		y: 205
		width: 85
		height: 55
		text: "Низкое\nнапряжение\n(WIFI)"
		isActive: mainCore.flyCoreStatus & 0x0080
	}

	CTRL_StatusLabel {
		x: 90
		y: 85
		width: 85
		height: 55
		text: "Нет сигнала\nс датчика\nтемпературы"
		isActive: mainCore.flyCoreStatus & 0x0080
	}
}
