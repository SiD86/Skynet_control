import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true
	visible: false

	onVisibleChanged: {
		listView.visible = false
		messageList.clear()
		busyIndicator.visible = true
		errorImage.visible = false
		labelText.text = qsTr("Операция выполняется...")
		labelText.color = "#FFFFFF"
	}

	function showOperationError() {
		busyIndicator.visible = false
		errorImage.visible = true
		labelText.text = qsTr("Ошибка при выполнении операции")
		labelText.color = "#FF0000"
	}

	Connections {
		target: CppConfigurationsManager
		onShowLogMessage: {
			listView.visible = true
			messageList.append({
								   "messageText": message
							   })
		}
	}

	BusyIndicator {
		id: busyIndicator
		x: 290
		y: 210
		width: 100
		height: 100
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
	}

	Image {
		id: errorImage
		x: 290
		y: 210
		width: 100
		height: 100
		visible: false
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		sourceSize.width: width
		sourceSize.height: height
		fillMode: Image.PreserveAspectFit
		source: "qrc:/images/error.svg"
	}

	Label {
		id: labelText
		height: 30
		text: ""
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
		anchors.left: parent.left
		anchors.leftMargin: 5
		anchors.right: parent.right
		anchors.rightMargin: 5
		anchors.top: busyIndicator.bottom
		anchors.topMargin: 20
		font.pointSize: 14
	}

	ListView {
		id: listView
		anchors.top: labelText.bottom
		anchors.topMargin: 30
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
		delegate: Item {
			x: 5
			width: parent.width
			height: 15

			Text {
				anchors.fill: parent
				text: messageText
				font.pointSize: 10
				color: "#FFFFFF"
				verticalAlignment: Qt.AlignVCenter
				horizontalAlignment: Qt.AlignLeft
			}
		}
		model: ListModel {
			id: messageList
		}
	}
}

/*##^## Designer {
	D{i:3;anchors_height:329;anchors_width:337;anchors_x:193;anchors_y:5}D{i:4;anchors_width:255;anchors_x:123;anchors_y:549}
D{i:5;anchors_height:334;anchors_width:490;anchors_x:5;anchors_y:549}
}
 ##^##*/

