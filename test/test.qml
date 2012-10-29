import QtQuick 1.1
import QtDesktop 0.1
import QmlFeatures 1.0

Rectangle {
    width: 800
    height: 600
    FocusScope {
        Row {
            spacing: 10
//            DatePicker {
//                onPickedDateChanged:
//                    console.log(pickedDate)
//            }
            LabelItem {
                Label {
                    text: "Date 1"
                    anchors.leftMargin: 5
                    font.bold: true
                    color: "grey"
                }

                DateEdit {
                    id:d1
                    font.pixelSize: 20
                    font.family: "Arial"
                    KeyNavigation.tab: d3
                }
            }

            LabelItem {
                labelPos: 1
                Label {
                    text: "Date 1"
                }

                DateEdit {
                    id:d3
                    KeyNavigation.tab: d1
                }

            }
/*
            LabelItem {
                layout: 1
                Label {
                    text: "Date 3"
                }

            DateEdit {
                id:d2
                KeyNavigation.tab: d1
            }
            }*/

        }
    }

}
