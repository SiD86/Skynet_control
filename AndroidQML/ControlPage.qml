import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

	property real systemStatus: 0xFFFFFFFF

	id: root
	width: 500
	height: 888
	clip: true

	Connections {
		target: CppCore
		onSystemStatusUpdated: {
			systemStatus = newSystemStatus
		}
	}

	Item {
		id: joystickItem
		width: (root.width < 290) ? root.width : 290
		height: width
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20

		ImageButton {
			width: joystickItem.width / 3 - 10
			height: width
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
			width: joystickItem.width / 3 - 10
			height: width
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
			width: joystickItem.width / 3 - 10
			height: width
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
			width: joystickItem.width / 3 - 10
			height: width
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

			width: joystickItem.width / 3 - 10
			height: width
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			imageSrc: "qrc:/images/GetUp.svg"
			onButtonClicked: {
				if (isDownSequenceSelected) {

					if (CppCore.sendGetUpCommand()) {
						isDownSequenceSelected = !isDownSequenceSelected
						imageSrc = "qrc:/images/GetDown.svg"
					}
				} else {

					if (CppCore.sendGetDownCommand()) {
						isDownSequenceSelected = !isDownSequenceSelected
						imageSrc = "qrc:/images/GetUp.svg"
					}
				}
			}
		}
	}

	GridLayout {
		height: 232
		columnSpacing: 4
		rowSpacing: 4
		anchors.right: parent.horizontalCenter
		anchors.rightMargin: 5
		anchors.top: parent.top
		anchors.topMargin: 5
		anchors.left: parent.left
		anchors.leftMargin: 5
		rows: 4
		columns: 2

		StatusLabel {
			text: "Reserved"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000080
		}

		StatusLabel {
			text: "Memory\nerror"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000040
		}

		StatusLabel {
			text: "I2C bus\nerror"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000020
		}

		StatusLabel {
			text: "Configuration\nerror"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000010
		}

		StatusLabel {
			text: "Math\nerror"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000008
		}

		StatusLabel {
			text: "Internal\nerror"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000004
		}

		StatusLabel {
			text: "Sync\nerror"
			Layout.maximumHeight: 55
			Layout.minimumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000002
		}

		StatusLabel {
			text: "Emergency\nmode"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000001
		}
	}

	GridLayout {
		height: 232
		rowSpacing: 4
		columnSpacing: 4
		anchors.left: parent.horizontalCenter
		anchors.leftMargin: 5
		anchors.top: parent.top
		anchors.topMargin: 5
		anchors.right: parent.right
		anchors.rightMargin: 5
		rows: 4
		columns: 2

		StatusLabel {
			text: "Reserved"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00800000
		}

		StatusLabel {
			text: "OLED GL"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00400000
		}

		StatusLabel {
			text: "Monitoring"
			Layout.preferredWidth: 118
			Layout.fillHeight: true
			Layout.fillWidth: true
			isActive: systemStatus & 0x00200000
		}

		StatusLabel {
			text: "Wireless"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00100000
		}

		StatusLabel {
			text: "Movement\nengine"
			Layout.preferredWidth: 118
			Layout.fillHeight: true
			Layout.fillWidth: true
			isActive: systemStatus & 0x00080000
		}

		StatusLabel {
			text: "Limbs\ndriver"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00040000
		}

		StatusLabel {
			text: "Servo\ndriver"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00020000
		}

		StatusLabel {
			text: "VEEPROM"
			Layout.minimumHeight: 55
			Layout.maximumHeight: 55
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00010000
		}
	}
}

/*##^## Designer {
	D{i:7;anchors_width:490;anchors_x:5;anchors_y:5}
}
 ##^##*/

