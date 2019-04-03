import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true
	visible: false

	Label {
		id: label
		x: 40
		y: 428
		text: qsTr("ТУТ ПОКА НЕЧЕГО ПОКАЗЫВАТЬ")
		font.pointSize: 20
	}
}
