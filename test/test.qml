import QtQuick 1.1
import QmlFeatures 1.0

Rectangle {

    width: 800
    height: 600
    Component.onCompleted:
        console.log(QmlUtil.parseDate("01.10.2012", "dd.MM.yyyy"))
    Rectangle {
        x:10;y:10
        width:calendarNav.width+10
        height:calendarNav.height+10
        border.color:"black"
        CalendarNavigation {
            id: calendarNav
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.verticalCenter:parent.verticalCenter
            onSelectedDateChanged: console.log(selectedDate)
        }
    }


}
