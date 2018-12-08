import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	width: 300
	height: 55
	clip: true

	property int txCount: 0
	property int rxCount: 0
	property int skipCount: 0
	property int errorCount: 0
	property int quality: 0

	Connections {
		target: wirelessController
		onUpdateCounters: {
			txCount = tx
			rxCount = rx
			skipCount = skip
			errorCount = error

			quality = (errorCount + skipCount) / (rxCount + skipCount + errorCount) * 100.0
			quality = 100 - quality
		}
	}

	Label {
		x: 0
		y: 0
		width: 145
		height: 25
		color: "#FFFFFF"
		text: "Отправлено \\ принято:"
		font.pointSize: 10
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignRight
	}

	Label {
		x: 150
		y: 0
		width: 80
		height: 25
		color: "#FFFFFF"
		text: txCount + " \\ " + rxCount
		font.pointSize: 10
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
	}

	CTRL_Button {
		x: 235
		y: 0
		width: 65
		height: 25
		text: "Стоп"
		onClicked: {
			wirelessController.stop()
		}
	}

	Label {
		x: 0
		y: 30
		width: 145
		height: 25
		color: "#ffffff"
		text: "Ошибок \\ пропущено:"
		font.pointSize: 10
		horizontalAlignment: Text.AlignRight
		verticalAlignment: Text.AlignVCenter
	}

	Label {
		x: 150
		y: 30
		width: 80
		height: 25
		color: "#ffffff"
		text: errorCount + " \\ " + skipCount
		font.pointSize: 10
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}

	Label {
		x: 235
		y: 30
		width: 65
		height: 25
		color: "#ffffff"
		text: quality + "%"
		font.pointSize: 10
		verticalAlignment: Text.AlignVCenter
		horizontalAlignment: Text.AlignHCenter
	}
}
