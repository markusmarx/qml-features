import QtQuick 1.1
import QtDesktop 0.1

import QmlFeatures 1.0

Item {
    width: 800
    height: 600
    property int formLabelPos: Qt.AlignTop
    Component.onCompleted: {
    }


    FocusScope {
        Column {
            anchors.fill: parent
            spacing: 10
            Text {
                text: qsTr("Allgemeine Informationen zur Person")
                font {
                    family: "Arial"
                    pixelSize: 16
                }
            }
            Row {
                spacing: 10
                LabelLayout {
                    id:lbl
                    labelPos: formLabelPos
                    labelMargin: 5

                    errorRectangle: defaultErrorRec
                    error: input_forename.text.length == 0
                    SimpleFormLabel {
                        text: "Vorname"
                    }

                    TextField {
                        id: input_forename
                        textColor: "#2B2B2B"
                        width: 250
                        font {
                            family: "Arial"
                            pixelSize: 20
                        }

                        KeyNavigation.tab: input_surname
                    }

                }

                LabelLayout {
                    labelPos: formLabelPos
                    labelMargin: 5

                    errorRectangle: defaultErrorRec
                    error: input_surname.text.length == 0
                    SimpleFormLabel {
                        text: "Nachname"
                    }

                    TextField {
                        id: input_surname
                        textColor: "#2B2B2B"
                        width: 250
                        font {
                            family: "Arial"
                            pixelSize: 20
                        }
                        KeyNavigation.tab: input_birth
                    }

                }
            }

            Row {
                spacing: 40
                LabelLayout {
                    labelPos: formLabelPos
                    labelMargin: 5
                    SimpleFormLabel {
                        text: "Geboren am"
                    }

                    DateEdit {
                        id: input_birth
                        textColor: "#2B2B2B"
                        inputMask: "99.99.9999"
                        fieldWidth: 150
                        font {
                            family: "Arial"
                            pixelSize: 20
                        }
                        KeyNavigation.tab: input_female
                    }

                }

                LabelLayout {
                    labelPos: formLabelPos
                    labelMargin: 0

                    errorRectangle: sexErrorRec
                    error: !input_male.checked & !input_female.checked

                    Label {
                        text: "Geschlecht"
                        color: "#585858"
                        font {
                            family: "Arial"
                            pixelSize: 12
                            bold:true
                        }
                    }

                    Row {
                        id:input_sex
                        CheckBox {
                            id:input_female
                            text: "W"
                            width: 50
                            height: input_birth.height-1

                            onCheckedChanged: {
                                if (checked)
                                    input_male.checked = false

                            }
                            onClicked: {
                                focus = true
                            }

                            KeyNavigation.tab: input_male
                        }
                        CheckBox {
                            id:input_male
                            text: "M"
                            width: 50
                            height: input_birth.height-1
                            onCheckedChanged: {
                                if (checked)
                                    input_female.checked = false
                            }

                            onClicked: {
                                focus = true
                            }
                        }
                    }

                }
            }

        }



    }

    Component {
        id: sexErrorRec
        Rectangle {
            border.color: Qt.lighter("red")
            color: Qt.lighter("red")
            border.width: 2
            x: -5
            z: -1

            Behavior on opacity {
                NumberAnimation { duration: 500}
            }
        }
    }

    Component {
        id: defaultErrorRec
        Rectangle {
            border.color: Qt.lighter("red")
            color: "transparent"
            border.width: 2

            Behavior on opacity {
                NumberAnimation {duration: 500}
            }
        }
    }

}
