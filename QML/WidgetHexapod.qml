import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Frame {
	id: frame
	width: 410
	height: 410
	clip: true

	function systemStatusUpdated() {
		scanningAnimation.start()
	}

	Blend {
		x: 0
		y: 0
		width: 386
		height: 386
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		source: hexapodImageSource
		foregroundSource: scannerImage
		mode: "addition"
	}

	Item {
		id: scannerImage
		visible: false
		width: hexapodImageSource.width
		height: hexapodImageSource.height

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
		id: hexapodImageSource
		visible: false
		source: "qrc:/images/hexapod.png"
	}
}




/*##^## Designer {
	D{i:1;anchors_height:500;anchors_x:0;anchors_y:0}
}
 ##^##*/
