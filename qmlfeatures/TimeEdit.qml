import QtQuick 1.1
import QtDesktop 0.1
import "common/utils.js" as QmlFeatureUtils
FocusScope {
    id: timeEdit
    width: timeField.width
    height: timeField.height
    focus: false
    property date time
    property alias font: timeField.font
    property string timeFormat: "hh:mm"
    property alias inputMask: timeField.inputMask
    property alias textColor: timeField.textColor
    property alias fieldWidth: timeField.width
    property alias fieldHeight: timeField.height
    property alias text: timeField.text
    property Item  _timePicker
    property bool validTime

    onFocusChanged: {
        if (timeEdit.activeFocus)
            timeField.forceActiveFocus();
    }

    onTimeChanged: {
        if (QmlUtil.isValidDateTime(time)) {
            validTime = true
            timeField.text = Qt.formatTime(time, timeFormat)
        } else {
            validTime = false
        }

    }

    function fnOpenTimePicker(myFocus) {
        if (!myFocus) {
            fnCloseTimePicker(QmlUtil.parseTime(timeField.text, timeFormat), false)
        } else if (!Qt.isQtObject(_timePicker)) {
//            var theDate = QmlUtil.parseTime(timeField.text, timeFormat)

//            if (!QmlFeatureUtils.fnIsValidDate(date)) {
//                theDate = new Date()
//            }

//            var container = QmlFeatureUtils.fnGetItemRoot(timeField)
//            _timePicker = datePicker.createObject(container,
//                                                    {dateField: timeField,
//                                                        pickedDate: theDate, opacity: 0})
//            _timePicker.opacity = 1

        }
    }

    function fnCloseTimePicker(pickedTime, clear) {

//        if (Qt.isQtObject(_timePicker)) {
//            _timePicker.opacity = 0
//            _timePicker.destroy(500)
//        }

        if (clear) timeField.text = ""

        time = pickedTime

    }

    TextField {
        id:timeField
        width: 100
        Keys.onEscapePressed: fnCloseTimePicker(time, true)
        Keys.onReturnPressed: fnCloseTimePicker(QmlUtil.parseTime(text, timeFormat), false)
        Keys.onTabPressed: {
            fnCloseTimePicker(QmlUtil.parseTime(text, timeFormat), false)
            event.accepted = false
        }

        onActiveFocusChanged: {
            fnOpenTimePicker(parent.focus)
        }
    }


}
