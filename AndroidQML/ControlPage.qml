import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

	id: root
	width: 500
	height: 888
	clip: true

	Item {
		id: joystickItem
		y: 628
		width: 300
		height: 300
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20

		ImageButton {
			width: 90
			height: 90
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			imageSrc: "qrc:/images/arrowUp.svg"
			onButtonPressed: {
				CppCore.sendDirectMoveCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {
			width: 90
			height: 90
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			imageSrc: "qrc:/images/arrowLeft.svg"
			onButtonPressed: {
				CppCore.sendRotateLeftCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {
			width: 90
			height: 90
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			imageSrc: "qrc:/images/arrowRight.svg"
			onButtonPressed: {
				CppCore.sendRotateRightCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {
			width: 90
			height: 90
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			imageSrc: "qrc:/images/arrowDown.svg"
			onButtonPressed: {
				CppCore.sendReverseMoveCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {

			property bool isDownSequenceSelected: false

			width: 90
			height: 90
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			imageSrc: "qrc:/images/GetUp.svg"
			onButtonClicked: {
				if (isDownSequenceSelected) {

					if (CppCore.sendGetUpCommand()) {
						isDownSequenceSelected = !isDownSequenceSelected
						imageSrc: "qrc:/images/GetDown.svg"
					}
				} else {

					if (CppCore.sendGetDownCommand()) {
						isDownSequenceSelected = !isDownSequenceSelected
						imageSrc: "qrc:/images/GetUp.svg"
					}
				}
			}
		}
	}
}

/*##^## Designer {
	D{i:26;anchors_width:226;anchors_x:5;anchors_y:5}
}
 ##^##*/

