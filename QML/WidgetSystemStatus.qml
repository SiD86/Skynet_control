import QtQuick 2.12
import QtQuick.Controls 2.5

GroupBox {
    width: 200
    height: 520
    title: "Текущий статус системы"
    clip: true

    Column {
        x: 0
        y: 3
        width: 85
        spacing: 5
        anchors.bottom: parent.bottom
        anchors.top: parent.top

        MyControlStatusLabel {
            text: "Reserved7"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved6"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved5"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved4"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved3"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved2"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved1"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved0"
            deactiveColor: "#888888"
            isActive: false
        }
    }

    Column {
        x: 90
        y: 8
        width: 85
        spacing: 5
        anchors.bottom: parent.bottom
        anchors.top: parent.top

        MyControlStatusLabel {
            text: "Reserved7"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Аппаратная\nошибка"
            deactiveColor: "#888888"
            isActive: true
        }
        MyControlStatusLabel {
            text: "Выход\nпараметра\nза диапазон"
            deactiveColor: "#888888"
            isActive: true
        }
        MyControlStatusLabel {
            text: "Ошибка\nсинхронизации"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Ошибка\nпамяти"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Ошибка\nконфигурации"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Внутренняя\nошибка"
            deactiveColor: "#888888"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Аварийный\nрежим"
            deactiveColor: "#888888"
            isActive: false
        }
    }
}
