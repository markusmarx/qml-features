import QtQuick 1.1
import QmlFeatures 1.0

Item {
    width:calNav.width+10
    height:calNav.height+40

    property Item dateField
    signal dayPicked(date date)
    property alias pickedDate: calNav.selectedDate


    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: image.height-3
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        border.color:"grey"
        border.width: 1
    }

        Image {
            id:image
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            source: "tooltip.svg"

        }

    CalendarNavigation {

        id:calNav
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.bottom:parent.bottom
        onDayClicked: {
            dayPicked(selectedDate)
        }

    }




}
