import QtQuick 1.1
import QtDesktop 0.1
import QmlFeatures 1.0
import "common/utils.js" as QmlFeatureUtils

FocusScope {
    id: dateEdit
    width: dateField.width
    height: dateField.height
    focus: false
    property date date
    property alias font: dateField.font
    property string dateFormat: "dd.MM.yyyy"
    property alias inputMask: dateField.inputMask
    property alias textColor: dateField.textColor
    property alias fieldWidth: dateField.width
    property alias fieldHeight: dateField.height
    property alias text: dateField.text
    property Item  ___datePicker
    property bool validDate

    onFocusChanged: {
        if (dateEdit.activeFocus)
            dateField.forceActiveFocus();
    }

    onDateChanged: {
        if (QmlFeatureUtils.fnIsValidDate(date)) {
            dateField.text = Qt.formatDate(date, dateFormat)
            validDate = true
        } else {
            validDate = false
        }
    }

    function fnOpenCalendar(myFocus) {
        if (!myFocus) {
            fnCloseCalendar(QmlUtil.parseDate(dateField.text, dateFormat), false)
        } else if (!Qt.isQtObject(___datePicker)) {
            var theDate = QmlUtil.parseDate(dateField.text, dateFormat)

            if (!QmlFeatureUtils.fnIsValidDate(date)) {
                theDate = new Date()
            }

            var container = QmlFeatureUtils.fnGetItemRoot(dateField)
            ___datePicker = datePicker.createObject(container,
                                                    {dateField: dateField,
                                                        pickedDate: theDate, opacity: 0})
            ___datePicker.opacity = 1

        }
    }

    function fnCloseCalendar(pickedDate, clear) {

        if (Qt.isQtObject(___datePicker)) {
            ___datePicker.opacity = 0
            ___datePicker.destroy(500)
        }

        if (clear) dateField.text = ""

        date = pickedDate
    }

    TextField {
        id:dateField
        Keys.onEscapePressed: fnCloseCalendar(date, true)
        Keys.onReturnPressed: fnCloseCalendar(QmlUtil.parseDate(text, dateFormat), false)
        Keys.onTabPressed: {
            fnCloseCalendar(QmlUtil.parseDate(text, dateFormat), false)
            event.accepted = false
        }

        onActiveFocusChanged: {
            fnOpenCalendar(parent.focus)
        }
    }
    CursorArea {
        anchors.fill: parent
        cursor: Qt.ArrowCursor

    }
    Image {
        id:date_image
        source: "images/calendar.svg"
        width: 16
        height: 16
        anchors.verticalCenter: dateField.verticalCenter
        anchors.right: dateField.right
        anchors.rightMargin: 5

        MouseArea {
            anchors.fill: parent
            onClicked: {
                fnOpenCalendar(true)
                dateField.forceActiveFocus()
            }
        }

    }

    Component {
        id: datePicker

        Item {
            width:calNav.width + 5
            height:calNav.height+image.height+2

            property Item dateField
            signal dayPicked(date date)
            property alias pickedDate: calNav.selectedDate

            Component.onCompleted: {
                opacity = 1
                var pos = dateEdit.mapToItem(parent, dateField.x, dateField.y)
                x = pos.x+dateField.width-width/2 - date_image.width/2 - date_image.anchors.rightMargin+2
                y = pos.y + dateField.height
            }

            onDayPicked: {
                fnCloseCalendar(pickedDate, false)
            }

            onFocusChanged: {
                console.log(focus)
            }

            onActiveFocusChanged: {
                console.log(activeFocus)
            }


            Rectangle {
                anchors.top: parent.top
                anchors.topMargin: image.height-1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                border.color:"grey"
                border.width: 2
                radius: 3
            }

            Image {
                id:image
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenter: parent.horizontalCenter
                source: "images/tooltip.svg"

            }

            CalendarNavigation {

                id:calNav
                anchors.horizontalCenter:parent.horizontalCenter
                anchors.bottom:parent.bottom
                onDayClicked: {
                    dayPicked(selectedDate)
                }

            }



            Behavior on opacity {
                NumberAnimation { duration: 200}
            }


        }


    }

}
