import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	id: root
	width: 1255
	height: 680

	signal showStartScreen

	Item {
		x: 310
		y: 5
		width: 670
		height: 670

		SwipeView {
			clip: true
			anchors.fill: parent

			Item {
				Widget_HardwareInfo {
				}
			}
			Item {
				Screen_Debug {
					id: debug
					objectName: "debug"
				}
			}
		}
	}

	Widget_OrientationInfo {
		x: 5
		y: 95
		width: 300
		height: 580
	}
	Widget_CommunicationInfo {
		x: 5
		y: 5
		width: 300
		height: 55
	}
	Widget_MainCoreStatus {
		x: 985
		y: 5
	}
	Widget_FlyCoreStatus {
		x: 985
		y: 210
	}
	Widget_FlyCoreMode {
		x: 985
		y: 415
	}

	CTRL_Button {
		x: 5
		y: 65
		width: 300
		height: 25
		text: "Отключить коммуникацию и выйти"
		onClicked: {
			wirelessController.stopConnection()
			showStartScreen()
		}
	}
}
