import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	width: 500
	height: 888
	color: "#000000"

	onClosing: {

		if (swipeView.currentIndex == 0) {
			close.accepted = true
		} else {
			close.accepted = false
			swipeView.currentIndex = 0
			CppCore.disconnectFromServer()
		}
	}

	SwipeView {
		id: swipeView
		anchors.fill: parent
		currentIndex: 0
		clip: true
		focus: true

		//interactive: false
		StartPage {
			id: startPage
			onStartConnectToServer: {
				swipeView.currentIndex = 1
				connectionPage.startConnection()
			}
		}

		ConnectionPage {
			id: connectionPage
			onGoToStartPage: {
				swipeView.currentIndex = 0
			}
			onGoToControlPage: {
				swipeView.currentIndex = 2
			}
		}

		ControlPage {
			id: controlPage
		}
	}
}
