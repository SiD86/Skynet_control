import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

Item {
	width: 300
	height: 600
	clip: true

	GridLayout {
		anchors.topMargin: 35
		anchors.bottomMargin: 20
		anchors.bottom: airHorizon.top
		anchors.right: parent.right
		anchors.left: parent.left
		anchors.top: parent.top
		columns: 4
		rows: 4

		Label {
			color: "#FFFFFF"
			text: "Крен (Х):"
			Layout.maximumWidth: 90
			Layout.minimumWidth: 90
			Layout.fillHeight: true
			Layout.fillWidth: true
			font.pointSize: 10
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
		}

		Label {
			color: "#ffffff"
			text: mainCore.currentAngleX
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			font.pointSize: 10
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			color: "#ffffff"
			text: mainCore.destAngleX
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			font.pointSize: 10
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			color: "#ffffff"
			text: mainCore.currentGyroX
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			font.pointSize: 10
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: "Тангаж (Y):"
			Layout.maximumWidth: 90
			Layout.minimumWidth: 90
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: mainCore.currentAngleY
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: mainCore.destAngleY
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: mainCore.currentGyroY
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: "Рыскание (Z):"
			Layout.minimumWidth: 90
			Layout.maximumWidth: 90
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: mainCore.currentAngleZ
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: mainCore.destAngleZ
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: mainCore.currentGyroZ
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			width: 90
			font.pointSize: 10
			color: "#ffffff"
			text: "Высота (H):"
			Layout.maximumWidth: 90
			Layout.minimumWidth: 90
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: mainCore.currentAlttitude
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}

		Label {
			font.pointSize: 10
			color: "#ffffff"
			text: "0"
			Layout.maximumWidth: 65
			Layout.fillHeight: true
			Layout.fillWidth: true
			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignHCenter
		}
	}
	Widget_AirHorizon {
		id: airHorizon
		x: 0
		y: 165
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 10
		roll: mainCore.currentAngleX
		pitch: mainCore.currentAngleY
		yaw: mainCore.currentAngleZ
	}
	Label {
		id: label
		x: 0
		y: 5
		width: 300
		height: 25
		color: "#ffffff"
		text: "Подсистема ориентации"
		Layout.minimumWidth: 90
		font.pointSize: 10
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter

		Frame {
			anchors.right: parent.right
			anchors.verticalCenter: parent.verticalCenter
			width: 70
			height: 1
		}

		Frame {
			anchors.left: parent.left
			anchors.verticalCenter: parent.verticalCenter
			width: 70
			height: 1
		}
	}
}
