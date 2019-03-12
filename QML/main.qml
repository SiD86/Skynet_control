import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	width: 640
	height: 480
	color: "#000000"

	SwipeView {
		id: swipeView
		anchors.fill: parent
		currentIndex: 0

		StartPage {
			id: startPage
			onStartConnectToServer: {
				swipeView.currentIndex = 1
				if (CppCore.connectToServer()) {
					swipeView.currentIndex = 3
				} else {
					swipeView.currentIndex = 0
					startPage.showErrorMessage(
								qsTr("Ошибка при подключении к устройству..."))
				}
			}
		}

		ConnectionPage {
			id: connectionPage
		}

		ControlPage {
			id: controlPage
		}
	}


	/*footer: TabBar {
		id: tabBar
		currentIndex: swipeView.currentIndex

		TabButton {
			text: qsTr("Page 1")
		}
		TabButton {
			text: qsTr("Page 2")
		}
	}*/
}
