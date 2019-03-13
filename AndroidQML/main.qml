import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	width: 500
	height: 888
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
					swipeView.currentIndex = 2
				} else {
					swipeView.currentIndex = 0
					startPage.showErrorMessage(
								qsTr("Ошибка при подключении к устройству"))
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
}
