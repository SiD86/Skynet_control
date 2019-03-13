import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true

	Item {
		y: 220
		width: 255
		height: 255
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20
		anchors.horizontalCenter: parent.horizontalCenter

		ImageButton {
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			image: "qrc:/images/arrowUp.png"
			onButtonPressed: {
				CppCore.sendDirectMoveCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			image: "qrc:/images/arrowLeft.png"
			onButtonPressed: {
				CppCore.sendRotateLeftCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			image: "qrc:/images/arrowRight.png"
			onButtonPressed: {
				CppCore.sendRotateRightCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			image: "qrc:/images/arrowDown.png"
			onButtonPressed: {
				CppCore.sendReverseMoveCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}
	}

	Item {
		x: 192
		width: 255
		height: 80
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.top: parent.top
		anchors.topMargin: 20

		ImageButton {
			width: 125
			height: 80
			anchors.left: parent.left
			anchors.top: parent.top
			image: "qrc:/images/up.png"
			onButtonClicked: {
				CppCore.sendGetUpCommand()
			}
		}

		ImageButton {
			width: 125
			height: 80
			anchors.top: parent.top
			anchors.right: parent.right
			image: "qrc:/images/down.png"
			onButtonClicked: {
				CppCore.sendGetDownCommand()
			}
		}
	}
}
