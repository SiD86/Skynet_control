import QtQuick 2.12
import QtQuick.Controls 2.5

GroupBox {
    width: 379
    height: 520
    title: "Мультимедиа"
    clip: true

    Row {
        width: 350
        height: 55
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        spacing: 5

        MyControlStatusLabel {
            text: "Ожидание"
        }
        MyControlStatusLabel {
            text: "Обновление\nизображения"
        }
        MyControlStatusLabel {
            text: "Передача\nизображения"
        }
        MyControlStatusLabel {
            text: "Ошибка"
        }
    }

    AnimatedImage {
        id: image
        x: 0
        y: 207
        width: 355
        height: 266
        source: "qrc:/images/white_noise.gif"
        fillMode: Image.Stretch
    }

    Row {
        x: 0
        y: 60
        width: 355
        height: 55
        spacing: 5

        Button {
            id: imageUpdateButton
            width: 175
            height: 48
            text: qsTr("Обновить")
            anchors.verticalCenter: parent.verticalCenter
            font.capitalization: Font.AllUppercase
        }

        Button {
            id: imageSaveButton
            width: 175
            height: 48
            text: qsTr("Сохранить как...")
            anchors.verticalCenter: parent.verticalCenter
            font.capitalization: Font.AllUppercase
        }
    }

    Row {
        x: 0
        y: 115
        width: 355
        height: 55
        spacing: 5

        Switch {
            id: autoUpdateSwitch
            width: 175
            height: 48
            text: qsTr("Автообновление")
            anchors.verticalCenter: parent.verticalCenter
            onCheckedChanged: {
                autoUpdatePeriodSlider.enabled = checked
                autoUpdatePeriodLabel.enabled = checked
                imageUpdateButton.enabled = !checked
                imageSaveButton.enabled = !checked
            }
        }

        Slider {
            id: autoUpdatePeriodSlider
            width: 100
            height: 48
            anchors.verticalCenter: parent.verticalCenter
            enabled: false
            stepSize: 100
            from: 2000
            to: 10000
            value: 5000
        }

        Label {
            id: autoUpdatePeriodLabel
            width: 70
            height: 48
            enabled: false
            text: autoUpdatePeriodSlider.value + " ms"
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    ProgressBar {
        id: progressBar
        x: 0
        y: 182
        width: 355
        height: 20
        value: 0.5
    }
}
