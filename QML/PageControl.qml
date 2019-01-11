import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 1215
    height: 590
    opacity: 0.8
    font.pointSize: 10

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

    Connections {
        target: CppCore
        onSystemStatusUpdated: {
            widgetSystemStatus.systemStatus = systemStatus
            widgetHexapod.systemStatus = systemStatus
            widgetHexapod.systemStatusUpdated()
        }
    }

    WidgetSystemStatus {
        id: widgetSystemStatus
        x: 10
        y: 10
    }

    WidgetMultimediaState {
        x: 828
        y: 10
    }

    WidgetHexapod {
        id: widgetHexapod
        x: 215
        y: 120
    }

    WidgetGaits {
        id: widgetGaits
        x: 215
        y: 10
    }
}
