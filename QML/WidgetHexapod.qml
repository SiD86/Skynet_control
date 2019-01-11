import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12

Frame {
    id: frame
    width: 608
    height: 410
    clip: true

    property int systemStatus: 0

    function systemStatusUpdated() {
        scanningAnimation.start()
    }

    Blend {
        width: 386
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        source: hexapodImageSource
        foregroundSource: scannerImage
        mode: "addition"
    }
    Grid {
        x: 409
        y: 0
        spacing: 5
        columns: 2

        Label {
            width: 120
            height: 20
            text: qsTr("Ячейка АКБ #1:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
        Label {
            width: 50
            height: 20
            text: qsTr("3.5 V")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            width: 120
            height: 20
            text: qsTr("Ячейка АКБ #2:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
        Label {
            width: 50
            height: 20
            text: qsTr("3.5 V")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            width: 120
            height: 20
            text: qsTr("Напряжение WIFI:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
        Label {
            width: 50
            height: 20
            text: qsTr("3.5 V")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            width: 120
            height: 20
            text: qsTr("Напряжение CAM:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
        Label {
            width: 50
            height: 20
            text: qsTr("3.5 V")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Label {
            width: 120
            height: 20
            text: qsTr("Температура БП:")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
        }
        Label {
            width: 50
            height: 20
            text: qsTr("35 °C")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Grid {
        x: 409
        y: 151
        spacing: 5
        columns: 2

        MyControlStatusLabel {
            text: "Мультимедиа"
            deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00800000
        }
        MyControlStatusLabel {
            text: "Reserved"
            //deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00400000
        }
        MyControlStatusLabel {
            text: "Система\nмониторинга"
            deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00200000
        }
        MyControlStatusLabel {
            text: "Беспроводная\nкоммуникация"
            deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00100000
        }
        MyControlStatusLabel {
            text: "Драйвер\nпередвижения"
            deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00080000
        }
        MyControlStatusLabel {
            text: "Драйвер\nконечностей"
            deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00040000
        }
        MyControlStatusLabel {
            text: "Драйвер\nсервоприводов"
            deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00020000
        }
        MyControlStatusLabel {
            text: "Виртуальный\nEEPROM"
            deactiveColor: "#00CD00"
            isActive: systemStatus & 0x00010000
        }
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
