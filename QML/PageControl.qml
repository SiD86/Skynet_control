import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {
    width: 1300
    height: 650
    contentWidth: 122

    header: Label {
        id: header
        text: qsTr("Режим управления")
        font.pointSize: Qt.application.font.pointSize * 2
        padding: 10

        Rectangle {
            height: 1
            color: "#555555"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }

    WidgetSystemStatus {
        x: 10
        y: 10
    }
    WidgetModulesStatus {
        x: 750
        y: 10
    }

    Frame {
        x: 220
        y: 10
        width: 520
        height: 520

        Image {
            clip: true
            width: 500
            height: 500
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/images/hexapod.png"

            Image {
                id: scanImage
                height: sourceSize.height
                y: -scanImage.height
                anchors.left: parent.left
                anchors.right: parent.right
                source: "qrc:/images/scanner.png"
            }

            Timer {
                id: scanningTimer
                interval: 1000
                repeat: false
                running: false
                onTriggered: {
                    scanningAnimation.running = true
                }
            }

            SmoothedAnimation {
                id: scanningAnimation
                running: true
                target: scanImage
                properties: "y"
                from: -scanImage.height
                to: 500
                duration: 2000
                onStarted: {
                    scanImage.y = -scanImage.height
                }
                onFinished: {
                    scanningTimer.running = true
                }
            }
        }
    }

    WidgetMultimediaState {
        x: 865
        y: 10
    }
}
