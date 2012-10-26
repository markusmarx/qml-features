import QtQuick 1.1
import QtDesktop 0.1
import QmlFeatures 1.0
import "common/utils.js" as QmlFeatureUtils

Item {
    id: dateEdit
    width: dateField.width
    height: dateField.height
    property date date
    property Item  ___datePicker

    function fnOpenCalendar(myFocus) {
        if (!myFocus) {
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

        parent.forceActiveFocus()
    }

        TextField {
            id:dateField
            smooth: true
            inputMask: "99.99.9999"
            font.family: "Arial"
            font.pixelSize: 20
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
