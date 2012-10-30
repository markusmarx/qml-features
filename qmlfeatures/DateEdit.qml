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
    property Item  ___datePicker

    onFocusChanged: {
        if (dateEdit.activeFocus)
            dateField.forceActiveFocus();
    }

    function fnOpenCalendar(myFocus) {
        if (!myFocus) {
            fnCloseCalendar(date, false)
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

//            if (!dateField.activeFocus) {
//                dateField.forceActiveFocus()
//                dateField.cursorPosition = 0

//            }


        }
    }

    function fnCloseCalendar(pickedDate, clear) {
        if (Qt.isQtObject(___datePicker)) {
            ___datePicker.opacity = 0
            ___datePicker.destroy(500)
        }

        if (clear) dateField.text = ""
        if (QmlFeatureUtils.fnIsValidDate(pickedDate)) {
            dateField.text = Qt.formatDate(pickedDate, dateFormat)
            date = pickedDate
        }

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
            if (!parent.focus)
                fnOpenCalendar(parent.focus)
        }
    }
    CursorArea {
        anchors.fill: parent

        cursor: Qt.ArrowCursor
    }
    Image {
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
            width:calNav.width+10
            height:calNav.height+40

            property Item dateField
            signal dayPicked(date date)
            property alias pickedDate: calNav.selectedDate

            Component.onCompleted: {
                opacity = 1
                var pos = dateField.mapToItem(parent, dateField.x+dateField.width-10, dateField.y)
                x = pos.x - width/2
                y = pos.y + dateField.height - 5
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
