import QtQuick 2.12
import QtQuick.Controls 2.5

GroupBox {
	width: 608
	height: 105
	title: "Драйвер передвижения"
	clip: true

	Row {
		id: row
		anchors.fill: parent
		spacing: 5

		MyControlStatusLabel {
			width: 93
			text: "Ожидание"
		}
		MyControlStatusLabel {
			width: 93
			text: "Движение\nвперед"
		}
		MyControlStatusLabel {
			width: 93
			text: "Движение\nназад"
		}
		MyControlStatusLabel {
			width: 93
			text: "Поворот\nналево"
		}
		MyControlStatusLabel {
			width: 93
			text: "Поворот\nнаправо"
		}
		MyControlStatusLabel {
			width: 93
			text: "Парковка"
		}
	}
}
