import QtQuick 2.12
import QtQuick.Controls 2.5

GroupBox {
	width: 1000
	height: 520
	title: "Текущий статус системы"
	clip: true

	property int systemStatus: 0

	Grid {
		x: 409
		y: 0
		spacing: 5
		columns: 2
		Label {
			width: 120
			height: 20
			text: qsTr("Напряжение АКБ:")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
		}
		Label {
			width: 50
			height: 20
			text: qsTr("3.5 V")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}
		Label {
			width: 120
			height: 20
			text: qsTr("Напряжение WIFI:")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
		}
		Label {
			width: 50
			height: 20
			text: qsTr("3.5 V")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}
		Label {
			width: 120
			height: 20
			text: qsTr("Напряжение переферии:")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
		}
		Label {
			width: 50
			height: 20
			text: qsTr("3.5 V")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}
	}

	Grid {
		x: 409
		y: 151
		spacing: 5
		columns: 2

		MyControlStatusLabel {
			text: "Мультимедиа"
			deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00800000
		}
		MyControlStatusLabel {
			text: "Reserved"
			//deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00400000
		}
		MyControlStatusLabel {
			text: "Система\nмониторинга"
			deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00200000
		}
		MyControlStatusLabel {
			text: "Беспроводная\nкоммуникация"
			deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00100000
		}
		MyControlStatusLabel {
			text: "Драйвер\nпередвижения"
			deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00080000
		}
		MyControlStatusLabel {
			text: "Драйвер\nконечностей"
			deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00040000
		}
		MyControlStatusLabel {
			text: "Драйвер\nсервоприводов"
			deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00020000
		}
		MyControlStatusLabel {
			text: "Виртуальный\nEEPROM"
			deactiveColor: "#00CD00"
			isActive: systemStatus & 0x00010000
		}
	}

	Column {
		x: 0
		y: 3
		width: 85
		spacing: 5
		anchors.bottom: parent.bottom
		anchors.top: parent.top

		MyControlStatusLabel {
			text: "Reserved7"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x8000
		}
		MyControlStatusLabel {
			text: "Reserved6"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x4000
		}
		MyControlStatusLabel {
			text: "Reserved5"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x2000
		}
		MyControlStatusLabel {
			text: "Reserved4"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x1000
		}
		MyControlStatusLabel {
			text: "Reserved3"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0800
		}
		MyControlStatusLabel {
			text: "Reserved2"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0400
		}
		MyControlStatusLabel {
			text: "Reserved1"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0200
		}
		MyControlStatusLabel {
			text: "Reserved0"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0100
		}
	}

	Column {
		x: 90
		y: 8
		width: 85
		spacing: 5
		anchors.bottom: parent.bottom
		anchors.top: parent.top

		MyControlStatusLabel {
			text: "Reserved7"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0080
		}
		MyControlStatusLabel {
			text: "Аппаратная\nошибка"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0040
		}
		MyControlStatusLabel {
			text: "Выход\nпараметра\nза диапазон"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0020
		}
		MyControlStatusLabel {
			text: "Ошибка\nсинхронизации"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0010
		}
		MyControlStatusLabel {
			text: "Ошибка\nпамяти"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0008
		}
		MyControlStatusLabel {
			text: "Ошибка\nконфигурации"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0004
		}
		MyControlStatusLabel {
			text: "Внутренняя\nошибка"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0002
		}
		MyControlStatusLabel {
			text: "Аварийный\nрежим"
			deactiveColor: "#888888"
			isActive: systemStatus & 0x0001
		}
	}
}
