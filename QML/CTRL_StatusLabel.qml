import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	id: root
	width: 85
	height: 55
	clip: true

	property string text: "НЕТ"
	property bool isActive: false
	property string activeColor: "#CD0000"
	property string deactiveColor: "#555555"

	Label {
		id: label
		z: 1
		smooth: true
		antialiasing: true
		anchors.fill: parent
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		color: (root.isActive == true) ? activeColor : deactiveColor
		text: root.text
		background: Canvas {
			id: canvas
			onPaint: {
				var contex = getContext("2d")
				contex.reset()

				contex.strokeStyle = "#305050"
				contex.lineWidth = 2
				contex.strokeRect(1, 1, label.width - 2, label.height - 2)

				contex.strokeStyle = label.color
				contex.lineWidth = 2
				contex.moveTo(17, 1)
				contex.lineTo(label.width - 17, 1)
				contex.stroke()
			}
		}
		onColorChanged: {
			canvas.requestPaint()
		}
	}
}
