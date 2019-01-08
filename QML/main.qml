import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    visible: true
    width: 1300
    height: 650
    title: qsTr("SKYNET")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 1

        PageConnection {
        }

        PageControl {
        }
    }
}
