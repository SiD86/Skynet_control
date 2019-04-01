import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	width: 500
	height: 888
	color: "#000000"

	onClosing: {

		if (swipeView.currentIndex == 2) {
			close.accepted = true
		} else {
			close.accepted = false
			swipeView.currentIndex = 2
			CppCore.disconnectFromServer()
		}
	}

	SwipeView {
		id: swipeView
		anchors.fill: parent
		currentIndex: 2
		clip: true

		//interactive: false
		SettingsPage {
			id: settingsPage
			enabled: swipeView.currentIndex == 0
		}

		InfoPage {
			id: infoPage
			enabled: swipeView.currentIndex == 1
		}

		StartPage {
			id: startPage
			enabled: swipeView.currentIndex == 2

			onStartConnectToServer: {
				swipeView.currentIndex = 3
				connectionPage.startConnection()
			}
			onShowInfoPage: {
				swipeView.currentIndex = 1
			}
			onShowSettingsPage: {
				swipeView.currentIndex = 0
			}
		}

		ConnectionPage {
			id: connectionPage
			enabled: swipeView.currentIndex == 3

			onGoToControlPage: {
				swipeView.currentIndex = 4
			}
		}

		ControlPage {
			id: controlPage
			enabled: swipeView.currentIndex == 4
		}
	}
}
