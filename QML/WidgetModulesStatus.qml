import QtQuick 2.12
import QtQuick.Controls 2.5

GroupBox {
    width: 110
    height: 520
    title: "Модули"
    clip: true

    Column {
        x: 0
        width: 85
        spacing: 5
        anchors.bottom: parent.bottom
        anchors.top: parent.top

        MyControlStatusLabel {
            text: "Мультимедиа"
            deactiveColor: "#00CD00"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Reserved"
            //deactiveColor: "#00CD00"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Система\nмониторинга"
            deactiveColor: "#00CD00"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Беспроводная\nкоммуникация"
            deactiveColor: "#00CD00"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Драйвер\nпередвижения"
            deactiveColor: "#00CD00"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Драйвер\nконечностей"
            deactiveColor: "#00CD00"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Драйвер\nсервоприводов"
            deactiveColor: "#00CD00"
            isActive: false
        }
        MyControlStatusLabel {
            text: "Виртуальный\nEEPROM"
            deactiveColor: "#00CD00"
            isActive: false
        }
    }
}
