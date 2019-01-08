import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 1300
    height: 650
    font.pointSize: 10

    header: Label {
        text: qsTr("Подключение к устройству")
        font.pointSize: Qt.application.font.pointSize * 2
        padding: 10
    }

    ColumnLayout {
        id: connectingElementsGroup
        x: 112
        y: 436
        width: 335
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false
        opacity: 0.0
        onOpacityChanged: {
            visible = (opacity != 0.0)
        }

        BusyIndicator {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        Label {
            text: qsTr("Устанавливаю соединение...")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        id: connectElementsGroup
        x: 342
        y: 209
        width: 335
        height: 200
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: true
        opacity: 1.0
        onOpacityChanged: {
            visible = (opacity != 0.0)
        }

        GroupBox {
            id: groupBox
            Layout.minimumHeight: 145
            Layout.maximumHeight: 145
            Layout.fillHeight: true
            Layout.fillWidth: true
            title: qsTr("Тип подключения")

            RadioButton {
                id: wireConnectionTypeButton
                y: 0
                text: qsTr("Использовать проводное соединение")
                anchors.left: parent.left
                anchors.right: parent.right
            }

            RadioButton {
                id: wirelessConnectionTypeButton
                y: 52
                text: qsTr("Использовать беспроводное соединение")
                checked: true
                anchors.left: parent.left
                anchors.right: parent.right
            }
        }

        Button {
            id: connectButton
            width: 335
            height: 48
            text: qsTr("Установить соединение")
            font.capitalization: Font.AllUppercase
            Layout.fillHeight: true
            Layout.fillWidth: true

            onClicked: {
                errorMessageLabel.text = qsTr("")
                connectingInProgressAnimation.running = true
                timer.running = true
            }
        }
    }

    Timer {
        id: timer
        interval: 5000
        repeat: false
        onTriggered: {
            errorMessageLabel.text = qsTr("Ошибка при подключении к устройству")
            connectingErrorAnimation.running = true
        }
    }

    SequentialAnimation {
        id: connectingInProgressAnimation

        NumberAnimation {
            target: connectElementsGroup
            properties: "opacity"
            from: 1.0
            to: 0.0
            duration: 500
        }
        NumberAnimation {
            target: connectingElementsGroup
            properties: "opacity"
            from: 0.0
            to: 1.0
            duration: 500
        }
    }

    SequentialAnimation {
        id: connectingErrorAnimation

        NumberAnimation {
            target: connectingElementsGroup
            properties: "opacity"
            from: 1.0
            to: 0.0
            duration: 500
        }
        NumberAnimation {
            target: connectElementsGroup
            properties: "opacity"
            from: 0.0
            to: 1.0
            duration: 500
        }
    }

    Label {
        id: errorMessageLabel
        x: 332
        y: 150
        width: 335
        height: 30
        color: "#ff0000"
        text: qsTr("")
        anchors.horizontalCenter: connectElementsGroup.horizontalCenter
        anchors.bottom: connectElementsGroup.top
        anchors.bottomMargin: 50
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
