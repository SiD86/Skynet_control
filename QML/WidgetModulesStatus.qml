import QtQuick 2.12
import QtQuick.Controls 2.5

GroupBox {
	width: 110
	height: 520
	title: "Модули"
	clip: true

	property int systemStatus: 0

	Column {
		x: 0
		width: 85
		spacing: 5
		anchors.bottom: parent.bottom
		anchors.top: parent.top

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
}
