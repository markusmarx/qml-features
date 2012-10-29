import QtQuick 1.1
import QtDesktop 0.1
import QmlFeatures 1.0

Rectangle {
    width: 800
    height: 600

    FocusScope {
        id: scope
        focus: true
        Rectangle {
            anchors.fill: parent
            Component.onCompleted: d1.forceActiveFocus()
            Column {
                spacing: 10
                Row {
                    spacing: 10
                    LabelLayout {
                        labelMargin: 5
                        Label {
                            text: "Date 1"
                            font.bold: true
                            color: "grey"
                        }

                        DateEdit {
                            id:d1

                            font.pixelSize: 20
                            font.family: "Arial"
                            inputMask: "99.99.9999"
                            KeyNavigation.tab: d3
                        }
                    }

                    LabelLayout {
                        labelPos: Qt.AlignBottom
                        labelAlign: Qt.AlignCenter
                        Label {
                            text: "Date 2"
                        }

                        DateEdit {
                            id:d3
                            KeyNavigation.tab: d4
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
                Row {
                    spacing: 10
                    LabelLayout {
                        labelPos: Qt.AlignLeft
                        Label {
                            text: "Date 1"
                            anchors.leftMargin: 5
                            font.bold: true
                            color: "grey"
                        }

                        DateEdit {
                            id:d4
                            font.pixelSize: 20
                            font.family: "Arial"
                            KeyNavigation.tab: d5
                        }
                    }

                    LabelLayout {
                        labelPos: Qt.AlignRight
                        labelAlign: Qt.AlignCenter
                        labelMargin: 5
                        Label {
                            text: "Date 2"
                        }

                        DateEdit {
                            id:d5
                            KeyNavigation.tab: d1
                        }

                    }
                }
            }

        }
    }
}
