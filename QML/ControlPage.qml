import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
	id: root
	clip: true

	Item {
		y: 220
		width: 255
		height: 255
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 5
		anchors.left: parent.left
		anchors.leftMargin: 5

		ImageButton {
			x: 90
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: parent.top
			anchors.topMargin: 0
		}

		ImageButton {
			y: 80
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.leftMargin: 0
		}

		ImageButton {
			x: 0
			y: 87
			width: 80
			anchors.right: parent.right
			anchors.rightMargin: 0
			anchors.verticalCenterOffset: 0
			anchors.verticalCenter: parent.verticalCenter
		}

		ImageButton {
			x: 80
			y: 165
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 0
			anchors.horizontalCenter: parent.horizontalCenter
		}
	}

	Item {
		x: 5
		y: 220
		width: 255
		height: 255
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 5
		anchors.right: parent.right
		anchors.rightMargin: 5
		ImageButton {
			x: 90
			anchors.top: parent.top
			anchors.topMargin: 0
			anchors.horizontalCenter: parent.horizontalCenter
		}

		ImageButton {
			y: 80
			anchors.verticalCenter: parent.verticalCenter
			anchors.left: parent.left
			anchors.leftMargin: 0
		}

		ImageButton {
			x: 0
			y: 87
			width: 80
			anchors.verticalCenter: parent.verticalCenter
			anchors.verticalCenterOffset: 0
			anchors.rightMargin: 0
			anchors.right: parent.right
		}

		ImageButton {
			x: 80
			y: 165
			anchors.bottomMargin: 0
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
		}
	}
}
