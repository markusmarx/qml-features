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

    property Item  ___datePicker

    onFocusChanged: {
        if (dateEdit.activeFocus)
            dateField.forceActiveFocus();
    }

    function fnOpenCalendar(myFocus) {
        if (!dateField.focus) {
            fnCloseCalendar(date, true)
        } else {
            var theDate = QmlUtil.parseDate(dateField.text, "dd.MM.yyyy")

            if (!QmlFeatureUtils.fnIsValidDate(date)) {
                theDate = new Date()
            }

            var container = QmlFeatureUtils.fnGetItemRoot(dateField)

            ___datePicker = datePicker.createObject(container,
                                                    {dateField: dateField,
                                                        pickedDate: theDate})
            dateField.cursorPosition = 0

        }
    }

    function fnCloseCalendar(pickedDate, clear) {
        if (Qt.isQtObject(___datePicker)) {
            ___datePicker.opacity = 0
            ___datePicker.destroy(500)
        }

        if (clear) dateField.text = ""
        if (QmlFeatureUtils.fnIsValidDate(pickedDate)) {
            dateField.text = Qt.formatDate(pickedDate, "dd.MM.yyyy")
            date = pickedDate
        }

    }

    TextField {
        id:dateField

        Keys.onEscapePressed: fnCloseCalendar(date, true)
        Keys.onReturnPressed: fnCloseCalendar(QmlUtil.parseDate(text, "dd.MM.yyyy"), false)

        onActiveFocusChanged: {
            fnOpenCalendar(focus)
        }
    }


    Component {
        id: datePicker
        DatePicker {
            Component.onCompleted: {
                opacity = 1
                var pos = dateField.mapToItem(parent, dateField.x, dateField.y)
                x = pos.x
                y = pos.y + dateField.height + 1
            }

            onDayPicked: {
                fnCloseCalendar(pickedDate, false)
            }

            Behavior on opacity {
                NumberAnimation { duration: 200}
            }

            CursorArea {
                anchors.fill: parent
                cursor: CursorArea.ArrowCursor
            }
        }

    }

}
