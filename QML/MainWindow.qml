import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle {
	id: root
	width: 1255
	height: 655
	color: "#000000"

	Widget_ControlSystemStatus {
		x: 895
		y: 5
	}

	Widget_MovementSystemStatus {
		x: 895
		y: 450
	}

	Image {
		id: image
		x: 326
		y: 64
		width: 500
		height: 500
		fillMode: Image.Stretch
		source: "qrc:/images/hexapod.png"
	}
}
