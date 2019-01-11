import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    visible: true
    width: 1215
    height: 590
    title: qsTr("SKYNET")

    SwipeView {
        anchors.fill: parent
        currentIndex: 1

        PageConnection {
        }

        PageControl {
        }
    }
}
