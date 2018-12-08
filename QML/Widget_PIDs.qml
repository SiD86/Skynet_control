import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	id: root
	width: 300
	height: 470
	clip: true

	signal pidChanged(var axis, var p, var i, var d)

	SwipeView {
		id: swipeView
		orientation: Qt.Vertical
		anchors.fill: parent
		anchors.leftMargin: 45
		clip: true
		interactive: false
		currentIndex: tabBar.currentIndex

		Item {
			CTRL_PID {
				title: "ПИД регулятор для оси Х"
				onPidChanged: {
					mainCore.PX = p
					mainCore.IX = i
					mainCore.DX = d
				}
			}
		}

		Item {
			CTRL_PID {
				title: "ПИД регулятор для оси Y"
				onPidChanged: {
					mainCore.PY = p
					mainCore.IY = i
					mainCore.DY = d
				}
			}
		}

		Item {
			CTRL_PID {
				title: "ПИД регулятор для оси Z"
				onPidChanged: {
					mainCore.PZ = p
					mainCore.IZ = i
					mainCore.DZ = d
				}
			}
		}
	}

	TabBar {
		id: tabBar
		x: -215
		y: 215
		width: 470
		height: 40
		rotation: 90
		TabButton {
			text: "ПИД по оси Х"
		}
		TabButton {
			text: "ПИД по оси Y"
		}
		TabButton {
			text: "ПИД по оси Z"
		}
	}
}
