import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
	visible: true
	width: 545
	height: 530
	color: "#000000"

	Connections {
		target: CppCore
		onConfigurationFound: {
			configurationList.append({
										 "name": configurationName
									 })
		}
		onShowLogMessage: {
			actionsList.append({
								   "message": message
							   })
		}
	}

	Pane {
		anchors.rightMargin: 5
		anchors.leftMargin: 5
		anchors.bottomMargin: 5
		anchors.topMargin: 5
		anchors.fill: parent

		Label {
			x: 260
			y: 5
			width: 250
			height: 20
			text: qsTr("Ход выполнения операций")
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			x: 5
			y: 5
			width: 250
			height: 20
			text: qsTr("Список доступных конфигураций")
			horizontalAlignment: Text.AlignHCenter
		}

		Frame {
			x: 5
			y: 30
			width: 250
			height: 300

			ListView {
				id: configurationListView
				clip: true
				anchors.fill: parent
				delegate: Rectangle {
					clip: true
					width: parent.width
					height: 40
					color: (index == configurationListView.currentIndex) ? "#888888" : "#000000"

					MouseArea {
						anchors.fill: parent
						onClicked: {
							configurationListView.currentIndex = index
						}
					}
					Label {
						x: 15
						width: parent.width - 15
						height: parent.height
						text: name
						color: "#FFFFFF"
						verticalAlignment: Qt.AlignVCenter
						horizontalAlignment: Qt.AlignLeft
					}
				}
				model: ListModel {
					id: configurationList
				}
			}
		}

		Button {
			x: 5
			y: 335
			width: 250
			height: 50
			text: qsTr("Обновить список конфигураций")
			font.pointSize: 10
			onClicked: {
				configurationList.clear()
				actionsList.clear()
				CppCore.requestConfigurationListFromServer()
			}
		}

		Button {
			x: 5
			y: 390
			width: 250
			height: 50
			enabled: configurationList.count != 0
			text: qsTr("Скачать конфигурацию")
			font.pointSize: 10
			onClicked: {
				actionsList.clear()
				var name = configurationList.get(
							configurationListView.currentIndex).name
				CppCore.requestConfigurationFileFromServer(name)
			}
		}

		Button {
			x: 5
			y: 445
			width: 250
			height: 50
			text: qsTr("Загрузить в устройство")
			font.pointSize: 10
			onClicked: {
				actionsList.clear()
				CppCore.loadConfigurationToDevice()
			}
		}

		Frame {
			x: 260
			y: 30
			width: 250
			height: 465
			ListView {
				id: logView
				delegate: Rectangle {
					width: parent.width
					height: 20
					color: "#000000"
					clip: true

					Label {
						x: 15
						width: parent.width - 15
						height: parent.height
						color: "#ffffff"
						text: message
						font.pointSize: 8
						horizontalAlignment: Qt.AlignLeft
						verticalAlignment: Qt.AlignVCenter
					}
				}
				anchors.fill: parent
				clip: true
				model: ListModel {
					id: actionsList
				}
			}
		}
	}
}

/*##^## Designer {
	D{i:1;anchors_height:200;anchors_width:200;anchors_x:"-7";anchors_y:34}D{i:5;anchors_height:300;anchors_width:250;anchors_x:"-228";anchors_y:"-277"}
D{i:14;anchors_height:300;anchors_width:250;anchors_x:"-228";anchors_y:"-277"}
}
 ##^##*/

