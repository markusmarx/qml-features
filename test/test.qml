import QtQuick 1.1
import QmlFeatures 1.0

Rectangle {

    width: 800
    height: 600
    FocusScope {
    Column {
        DatePicker {

            onPickedDateChanged:
                console.log(pickedDate)
        }
        DateEdit {

        }

        DateEdit {

        }

    }
    }

}
