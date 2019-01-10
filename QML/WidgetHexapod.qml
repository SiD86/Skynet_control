import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Frame {
	width: 520
	height: 520

	property int systemStatus: 0
	onSystemStatusChanged: {
		scanningAnimation.start()
	}

	Blend {
		anchors.fill: parent
		source: hexapodImage
		foregroundSource: scannerItem
		mode: "addition"
	}

	Item {
		id: scannerItem
		visible: false
		width: hexapodImage.width
		height: hexapodImage.height

		LinearGradient {
			id: scannerGradient
			y: -parent.height
			height: parent.height
			width: parent.width

			start: Qt.point(0, 0)
			end: Qt.point(0, height)

			gradient: Gradient {
				GradientStop {
					position: 0.0
					color: "blue"
				}
				GradientStop {
					position: 1.0
					color: "white"
				}
			}
		}

		SmoothedAnimation {
			id: scanningAnimation
			target: scannerGradient
			alwaysRunToEnd: true
			properties: "y"
			from: -scannerGradient.height
			to: scannerGradient.height
			duration: 2000
			onFinished: {
				scannerGradient.y = scanningAnimation.from
			}
		}
	}

	Image {
		id: hexapodImage
		visible: false
		width: sourceSize.width
		height: sourceSize.height
		source: "qrc:/images/hexapod.png"
	}
}
