import QtQuick 2.9
import QtQuick.Controls 2.3

Button {
	id: root
	width: 65
	height: 25
	text: "Текст"

	contentItem: Text {
		text: root.text
		color: root.down ? "#999999" : "#FFFFFF"
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
	background: Rectangle {
		anchors.fill: root
		color: "#000000"
		border.color: root.down ? "#999999" : "#CDCDCD"
	}
}
