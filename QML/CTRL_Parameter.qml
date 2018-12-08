import QtQuick 2.9
import QtQuick.Controls 2.3

Rectangle {
	id: root
	width: 85
	height: 55
	color: "#000000"
	enabled: false
	smooth: false
	clip: true
	border.color: root.get_color()

	property string title: "TITLE"
	property real value: 0
	property string postfix: ""

	property real warning_value: 0xFFFFFFFF
	property real critical_value: 0xFFFFFFFF

	Label {
		id: id_title
		y: 5
		height: 15
		color: root.get_color()
		text: title
		anchors.right: parent.right
		anchors.rightMargin: 5
		anchors.left: parent.left
		anchors.leftMargin: 5
		smooth: false
		antialiasing: false
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
	}

	Label {
		id: id_value
		y: 25
		height: 25
		color: root.get_color()
		text: value + postfix
		anchors.right: parent.right
		anchors.rightMargin: 5
		anchors.left: parent.left
		anchors.leftMargin: 5
		smooth: false
		antialiasing: false
		font.pointSize: 12
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
	}

	function get_color() {

		// Direct
		if (critical_value > warning_value) {
			if (value > critical_value)
				return "#CD0000"
			if (value > warning_value)
				return "#CDCD00"
			return "#00CD00"
		} else {
			// Reverse
			if (value < critical_value)
				return "#CD0000"
			if (value < warning_value)
				return "#CDCD00"
			return "#00CD00"
		}
	}
}
