import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {

	signal startConnectToServer

	function showErrorMessage(message) {
		errorMessageLabel.text = message
		errorMessageLabel.visible = true
	}
	function hideErrorMessage() {
		errorMessageLabel.visible = false
	}

	id: root
	width: 500
	height: 888
	clip: true

	Label {
		id: errorMessageLabel
		y: 340
		height: 20
		visible: false
		color: "#ff0000"
		text: qsTr("")
		font.pointSize: 14
		horizontalAlignment: Text.AlignHCenter
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		verticalAlignment: Text.AlignVCenter
	}

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
			imageSrc: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {

				//startConnectToServer()
			}
		}

		MetroButton {
			imageSrc: "qrc:/images/settings.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {

				//startConnectToServer()
			}
		}

		MetroButton {
			imageSrc: "qrc:/images/info.svg"
			Layout.fillHeight: true
			Layout.fillWidth: true
			onButtonClicked: {

				//startConnectToServer()
			}
		}
	}
}
