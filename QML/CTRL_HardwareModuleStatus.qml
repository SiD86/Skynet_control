import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    id: root
    clip: true
    width: 100
    height: 100

    property string source: ""
    property int status: 1

    function get_mask() {
        if (status == 1)
            return green_mask
        else if (status == 2)
            return yellow_mask
        return red_mask
    }

    Blend {
        anchors.fill: root
        mode: "addition"
        source: image_source
        foregroundSource: get_mask()
    }

    Image {
        id: image_source
        smooth: false
        visible: false
        source: root.source
    }

    // Masks
    Image {
        id: red_mask
        smooth: false
        visible: false
        source: "qrc:/images/red.png"
    }
    Image {
        id: yellow_mask
        smooth: false
        visible: false
        source: "qrc:/images/yellow.png"
    }
    Image {
        id: green_mask
        smooth: false
        visible: false
        source: "qrc:/images/green.png"
    }
}
