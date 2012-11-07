import QtQuick 1.1
import QmlFeatures 1.0
import QtDesktop 0.1

Item {
    width: 800
    height: 600

    property int weekFlags;

    LabelLayout {
        labelPos: Qt.AlignLeft
        itemMargin: 10
        Label { text: "Wiederholung jede\nWoche am"}

        Row {

            Repeater {
                model:ListModel {
                    ListElement {name: "Mo"; flag: 1}
                    ListElement {name: "Di" ; flag: 2}
                    ListElement {name: "Mi"; flag: 4}
                    ListElement {name: "Fr"; flag: 8}
                    ListElement {name: "Sa"; flag: 16}
                    ListElement {name: "So"; flag: 32}
                }

                delegate: Column {
                    Label {text:name}
                    CheckBox {width: 20
                        onCheckedChanged: {
                            if (checked) {
                                weekFlags = weekFlags | flag
                            } else {
                                weekFlags = weekFlags ^ flag
                            }

                            console.log(weekFlags)
                        }


                    }
                }
            }

        }
    }


}
