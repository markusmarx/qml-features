import QtQuick 1.1
import QmlFeatures 1.0
Rectangle {
    id:datePicker
    property Item dateField
    signal dayPicked(date date)
    border.color:"grey"
    property alias pickedDate: calNav.selectedDate

    width:calNav.width+10
    height:calNav.height+10
    CalendarNavigation {
        id:calNav
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.verticalCenter:parent.verticalCenter
        onDayClicked: {
            dayPicked(selectedDate)
        }

    }
}
