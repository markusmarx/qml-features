import QtQuick 1.1
import QmlFeatures 1.0

Item {
    width: calNav.width + image.width
    height: calNav.height + image.height

    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.topMargin: image.height-4
        border.color: "black"
        border.width: 1
        width:calNav.width+10
        height:calNav.height+10
        CalendarNavigation {
            id:calNav
            anchors.fill: parent
        }
    }

    Image {
        id:image
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        source: "tooltip.svg"

    }


}
