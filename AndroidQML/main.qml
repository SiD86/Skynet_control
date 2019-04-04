import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	width: 500
	height: 888
	color: "#000000"

	property bool isApplicationBusy: false

	onClosing: {

		if (isApplicationBusy == true) {
			close.accepted = false
			return
		}

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

			isApplicationBusy = true
			showPage(waitOperationPage)

			if (CppCore.connectToServer()) {
				isApplicationBusy = false
				showPage(controlPage)
			} else {
				isApplicationBusy = false
				waitOperationPage.showOperationError()
			}
		}
		onShowInfoPage: {
			isApplicationBusy = false
			showPage(infoPage)
		}
		onShowSettingsPage: {
			isApplicationBusy = false
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
			isApplicationBusy = true
			showPage(waitOperationPage)
		}
		onHideWaitOperationPage: {
			isApplicationBusy = false
			showPage(settingsPage)
		}
		onShowOperationError: {
			isApplicationBusy = false
			waitOperationPage.showOperationError()
		}
		onOperationProgressUpdated: {
			waitOperationPage.setProgressBarConfig(min, max, value)
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
