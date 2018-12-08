import QtQuick 2.9
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ProgressBar {
	id: root
	width: 140
	height: 20
	antialiasing: true
	clip: true
	smooth: false

	maximumValue: 100
	minimumValue: 0
	value: 100

	property string postfix: "%"

	property int text_rotation: 0
	property int level_warning: 0xFFFFFF
	property int level_critical: 0xFFFFFF

	property int segment_count: orientation == 1 ? width / 7 : height / 7

	style: ProgressBarStyle {
		background: Row {
			spacing: 2
			Repeater {
				id: serments
				model: segment_count
				Rectangle {
					width: 5
					height: orientation == 0 ? root.width : root.height
					border.width: 0
					color: "#222222"
				}
			}
		}

		progress: Row {
			spacing: 2
			Repeater {
				model: root.value / (100 / segment_count)
				Rectangle {
					width: 5
					height: orientation == 0 ? root.width : root.height
					border.width: 0
					color: get_progress_color()
				}
			}
		}

		function get_progress_color() {
			if (root.value >= level_critical)
				return "#CD0000"
			else if (root.value >= level_warning)
				return "#CDCD00"
			return "#00CD00"
		}
	}

	Label {
		id: progress_text
		anchors.fill: parent
		text: root.value + postfix
		rotation: text_rotation
		color: "#FFFFFF"
		font.bold: true
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
	}
}
