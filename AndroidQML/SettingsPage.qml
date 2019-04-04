import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	width: 500
	height: 888
	clip: true
	visible: false

	signal showWaitOperationPage
	signal hideWaitOperationPage
	signal showOperationError
	signal operationProgressUpdated(var min, var max, var value)

	Connections {
		target: CppConfigurationsManager
		onConfigurationFound: {
			listModel.append({
								 "name": fileName
							 })
		}
	}

	ListView {
		id: configurationList
		clip: true
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 140
		anchors.top: parent.top
		anchors.topMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.left: parent.left
		anchors.leftMargin: 10
		model: ListModel {
			id: listModel
		}
		delegate: Rectangle {
			width: parent.width
			height: 40
			color: (configurationList.currentIndex == index) ? "#555555" : "#000000"
			Text {
				anchors.fill: parent
				anchors.leftMargin: 20
				text: name
				color: "#FFFFFF"
				font.pointSize: 12
				verticalAlignment: Qt.AlignVCenter
			}
			MouseArea {
				anchors.fill: parent
				onClicked: {
					configurationList.currentIndex = index
				}
			}
		}
	}

	Button {
		id: updateConfigurationListButton
		y: 753
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 70
		height: 60
		text: "ОБНОВИТЬ СПИСОК КОНФИГУРАЦИЙ"
		onClicked: {

			showWaitOperationPage()
			listModel.clear()

			if (CppConfigurationsManager.loadConfigurationList()) {
				hideWaitOperationPage()
			} else {
				showOperationError()
			}
		}
	}

	Button {
		id: loadConfigurationButton
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.right: parent.right
		anchors.rightMargin: 10
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		enabled: listModel.count != 0
		height: 60
		text: "ЗАГРУЗИТЬ КОНФИГУРАЦИЮ"
		onClicked: {

			showWaitOperationPage()

			var name = listModel.get(configurationList.currentIndex).name
			if (CppConfigurationsManager.loadConfiguration(name)) {
				hideWaitOperationPage()
			} else {
				showOperationError()
			}
		}
	}
}

/*##^## Designer {
	D{i:3;anchors_height:738;anchors_width:490;anchors_x:5;anchors_y:5}D{i:2;anchors_width:100;anchors_x:5}
D{i:11;anchors_width:480;anchors_x:10}
}
 ##^##*/

