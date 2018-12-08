import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Item {
	id: root
	width: 670
	height: 475

	function setCellValue(address, value) {
		memoryDump.set(address, {
						   value: value
					   })
	}

	function getCellValue(address) {
		return memoryDump.get(address).value
	}

	ListModel {
		id: memoryDump
		Component.onCompleted: {
			var i = 0
			for (i = 0; i <= 0x00FF; ++i) {
				memoryDump.append({
									  value: "00",
									  isEditMode: false
								  })
			}
		}
	}

	ColumnLayout {
		id: leftRow
		width: 38
		spacing: 0
		anchors.left: parent.left
		anchors.bottom: parent.bottom
		anchors.top: parent.top
		anchors.topMargin: 25
		Repeater {
			model: 0x0F + 1
			Label {
				Layout.fillHeight: true
				Layout.fillWidth: true
				text: "0x" + index.toString(16).toUpperCase() + "0"
				color: "#00FF00"
				font.bold: true
				font.pixelSize: 12
				verticalAlignment: Qt.AlignVCenter
				horizontalAlignment: Qt.AlignHCenter
			}
		}
	}

	RowLayout {
		id: topRow
		x: 33
		height: 20
		anchors.top: parent.top
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.leftMargin: 48
		Repeater {
			model: 0x0F + 1
			Label {
				Layout.fillHeight: true
				Layout.fillWidth: true
				text: "0x0" + index.toString(16).toUpperCase()
				color: "#00FF00"
				font.bold: true
				font.pixelSize: 12
				verticalAlignment: Qt.AlignVCenter
				horizontalAlignment: Qt.AlignHCenter
			}
		}
	}

	GridView {
		id: gridView
		anchors.top: topRow.bottom
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.left: leftRow.right
		anchors.topMargin: 5
		anchors.leftMargin: 5
		smooth: false
		clip: true
		interactive: false
		cellWidth: gridView.width / 16.0
		cellHeight: gridView.height / 16.0
		model: memoryDump

		delegate: Item {
			width: gridView.cellWidth
			height: gridView.cellHeight

			TextField {
				id: cellEdit
				anchors.fill: parent
				text: value
				color: (gridView.currentIndex == index) ? "#00CCCC" : "#CCCCCC"
				font.bold: gridView.currentIndex == index
				font.pixelSize: 12
				verticalAlignment: Qt.AlignVCenter
				horizontalAlignment: Qt.AlignHCenter
				inputMask: "hh"
				inputMethodHints: Qt.ImhUppercaseOnly
				background: Rectangle {
					color: "#000000"
					border.color: (gridView.currentIndex == index) ? "#00FFFF" : "#333333"
					border.width: (gridView.currentIndex == index) ? 2 : 1
				}
				onTextEdited: {
					memoryDump.set(gridView.currentIndex, {
									   value: cellEdit.text
								   })
				}

				onFocusChanged: {
					if (focus == true)
						gridView.currentIndex = index
				}
			}
		}
	}
}
