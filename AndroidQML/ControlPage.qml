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
		y: 646
		width: (root.width < 260) ? root.width : 260
		height: 170
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20

		ImageButton {
			width: 80
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
			width: 80
			height: width
			anchors.bottom: parent.bottom
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
			width: 80
			height: width
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			imageSrc: "qrc:/images/arrowRight.svg"
			onButtonPressed: {
				CppCore.sendRotateRightCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}

		ImageButton {
			width: 80
			height: width
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 0
			anchors.horizontalCenter: parent.horizontalCenter
			imageSrc: "qrc:/images/arrowDown.svg"
			onButtonPressed: {
				CppCore.sendReverseMoveCommand()
			}
			onButtonReleased: {
				CppCore.sendStopMoveCommand()
			}
		}
	}

	Item {
		height: 80
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.top: parent.top
		anchors.topMargin: 290

		ImageButton {
			id: updateHeightButton
			width: height
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			imageSrc: "qrc:/images/Update.svg"
			onButtonClicked: {
				CppCore.sendUpdateHeightCommand(heightSpinBox.value)
			}
		}

		SpinBox {
			id: heightSpinBox
			font.pointSize: 13
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.right: updateHeightButton.left
			anchors.rightMargin: 5
			anchors.left: parent.left

			editable: false
			stepSize: 5
			from: 85
			value: 85
			to: 185
		}
	}

	Item {
		id: upDownControls
		x: 320
		width: 170
		height: 80
		anchors.top: parent.top
		anchors.topMargin: 200
		anchors.right: parent.right
		anchors.rightMargin: 10

		ImageButton {
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.left: parent.left
			anchors.right: parent.horizontalCenter
			anchors.rightMargin: 5
			imageSrc: "qrc:/images/GetDown.svg"
			onButtonClicked: {
				CppCore.sendGetDownCommand()
			}
		}

		ImageButton {
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.left: parent.horizontalCenter
			anchors.leftMargin: 5
			anchors.right: parent.right
			imageSrc: "qrc:/images/GetUp.svg"
			onButtonClicked: {
				CppCore.sendGetUpCommand()
			}
		}
	}

	Item {
		height: 80
		anchors.right: parent.right
		anchors.rightMargin: 190
		anchors.top: parent.top
		anchors.topMargin: 200
		anchors.left: parent.left
		anchors.leftMargin: 10

		Label {
			width: 45
			height: 22
			anchors.left: parent.left
			anchors.top: parent.top
			font.pointSize: 12
			text: qsTr("BATT:")
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
		}

		Label {
			width: 45
			height: 22
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			font.pointSize: 12
			text: qsTr("WIFI:")
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
		}

		Label {
			width: 45
			height: 22
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			font.pointSize: 12
			text: qsTr("SENS:")
			horizontalAlignment: Text.AlignRight
			verticalAlignment: Text.AlignVCenter
		}

		ProgressBar {
			width: 165
			height: 22
			anchors.top: parent.top
			anchors.right: parent.right
			anchors.rightMargin: 55
			anchors.left: parent.left
			anchors.leftMargin: 50
			value: 4.2
			to: 8.4
		}

		ProgressBar {
			width: 165
			height: 22
			anchors.verticalCenter: parent.verticalCenter
			anchors.right: parent.right
			anchors.rightMargin: 55
			anchors.left: parent.left
			anchors.leftMargin: 50
			value: 2.75
			to: 5.5
		}

		ProgressBar {
			width: 165
			height: 22
			anchors.bottom: parent.bottom
			anchors.right: parent.right
			anchors.rightMargin: 55
			anchors.left: parent.left
			anchors.leftMargin: 50
			value: 2.75
			to: 5.5
		}

		Label {
			width: 50
			height: 22
			anchors.top: parent.top
			anchors.right: parent.right
			font.pointSize: 12
			text: qsTr("8.4 V")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			width: 50
			height: 22
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			font.pointSize: 12
			text: qsTr("5.0 V")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			width: 50
			height: 22
			anchors.right: parent.right
			anchors.bottom: parent.bottom
			font.pointSize: 12
			text: qsTr("5.0 V")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}
	}

	GridLayout {
		height: 175
		columnSpacing: 4
		rowSpacing: 4
		anchors.right: parent.horizontalCenter
		anchors.rightMargin: 2
		anchors.top: parent.top
		anchors.topMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
		rows: 4
		columns: 2

		StatusLabel {
			text: "Reserved"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000080
		}

		StatusLabel {
			text: "Memory\nerror"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000040
		}

		StatusLabel {
			text: "I2C bus\nerror"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000020
		}

		StatusLabel {
			text: "Configuration\nerror"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000010
		}

		StatusLabel {
			text: "Math\nerror"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000008
		}

		StatusLabel {
			text: "Internal\nerror"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000004
		}

		StatusLabel {
			text: "Sync\nerror"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000002
		}

		StatusLabel {
			text: "Emergency\nmode"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00000001
		}
	}

	GridLayout {
		height: 175
		rowSpacing: 4
		columnSpacing: 4
		anchors.left: parent.horizontalCenter
		anchors.leftMargin: 2
		anchors.top: parent.top
		anchors.topMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		rows: 4
		columns: 2

		StatusLabel {
			text: "Reserved"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00800000
		}

		StatusLabel {
			text: "OLED GL"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00400000
		}

		StatusLabel {
			text: "Monitoring"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00200000
		}

		StatusLabel {
			text: "Wireless"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00100000
		}

		StatusLabel {
			text: "Movement\nengine"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00080000
		}

		StatusLabel {
			text: "Limbs\ndriver"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00040000
		}

		StatusLabel {
			text: "Servo\ndriver"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00020000
		}

		StatusLabel {
			text: "VEEPROM"
			Layout.minimumHeight: 40
			Layout.maximumHeight: 40
			Layout.preferredWidth: 118
			Layout.fillWidth: true
			isActive: systemStatus & 0x00010000
		}
	}
}
