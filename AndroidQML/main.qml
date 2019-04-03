import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	width: 500
	height: 888
	color: "#000000"

	onClosing: {

		if (waitOperationPage.visible) {
			close.accepted = false
			CppCore.disconnectFromServer()
			CppConfigurationsManager.abortOperations()
		} else {
			if (startPage.visible) {
				close.accepted = true
				return
			} else {
				close.accepted = false
				CppCore.disconnectFromServer()
				CppConfigurationsManager.abortOperations()
			}
		}
		showPage(startPage)
	}

	function showPage(page) {
		startPage.visible = false
		controlPage.visible = false
		settingsPage.visible = false
		infoPage.visible = false
		waitOperationPage.visible = false
		page.visible = true
	}

	StartPage {
		id: startPage

		onStartConnectToServer: {
			showPage(waitOperationPage)
			if (CppCore.connectToServer()) {
				showPage(controlPage)
			} else {
				waitOperationPage.showOperationError()
			}
		}
		onShowInfoPage: {
			showPage(infoPage)
		}
		onShowSettingsPage: {
			showPage(settingsPage)
		}
	}

	ControlPage {
		id: controlPage
		anchors.fill: parent
	}

	SettingsPage {
		id: settingsPage
		anchors.fill: parent

		onShowWaitOperationPage: {
			showPage(waitOperationPage)
		}
		onHideWaitOperationPage: {
			showPage(settingsPage)
		}
		onShowOperationError: {
			waitOperationPage.showOperationError()
		}
	}

	InfoPage {
		id: infoPage
		anchors.fill: parent
	}

	WaitOperationPage {
		id: waitOperationPage
		anchors.fill: parent
		visible: false
	}
}
