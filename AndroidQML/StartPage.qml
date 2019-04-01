import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

	signal startConnectToServer
	signal showInfoPage
	signal showSettingsPage

	id: root
	width: 500
	height: 888
	clip: true

	GridLayout {
		id: gridLayout
		columnSpacing: 10
		rowSpacing: 10
		anchors.rightMargin: 10
		anchors.leftMargin: 10
		anchors.bottomMargin: 10
		anchors.topMargin: 10
		anchors.fill: parent
		rows: 3
		columns: 2

		Image {
			clip: true
			width: gridLayout.width
			height: gridLayout.width * (sourceSize.height / sourceSize.width)

			Layout.fillHeight: true
			Layout.fillWidth: true
			Layout.maximumWidth: width
			Layout.maximumHeight: height
			Layout.minimumWidth: width
			Layout.minimumHeight: height
			Layout.columnSpan: 2

			sourceSize.width: 525
			sourceSize.height: 370
			fillMode: Image.PreserveAspectFit
			source: "qrc:/images/logo.png"
		}

		MetroButton {
			imageSrc: "qrc:/images/control.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {
				startConnectToServer()
			}
		}

		MetroButton {
			imageSrc: "qrc:/images/settings.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {
				showSettingsPage()
			}
		}

		MetroButton {
			imageSrc: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {
				showInfoPage()
			}
		}


		/*MetroButton {
			imageSrc: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {

				//startConnectToServer()
			}
		}*/
	}
}
