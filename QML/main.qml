import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	x: 1700
	y: 50
	width: 1255
	height: 650
	title: qsTr("SKYNET")

	SwipeView {
		anchors.fill: parent
		currentIndex: 1

		PageConnection {
		}

		PageControl {
		}
	}
}
