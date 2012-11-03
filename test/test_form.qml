import QtQuick 1.1
import QtDesktop 0.1

import QmlFeatures 1.0

Item {
    width: 800
    height: 600
    property int formLabelPos: Qt.AlignTop


    FocusScope {
        Column {
            anchors.fill: parent
            spacing: 10
            Text {
                text: qsTr("Allgemeine Informationen zur Person")
                color: "#D4D0C8"
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
                    errorMessage: defaultErrorMessage

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
                        onActiveFocusChanged: {
                            var f = activeFocus || focus
                            if (f && parent.error) {
                                parent.fnShowErrorMessage("Einen Vornamen eingeben!")
                            }

                            if (!f && input_forename.text.length == 0) {
                                parent.error = true
                                parent.fnHideErrorMessage()
                            } else if (!f && input_forename.text.length > 0) {
                                parent.error = false
                                parent.fnHideErrorMessage()
                            }


                        }
                    }

                }

                LabelLayout {
                    labelPos: formLabelPos
                    labelMargin: 5

                    errorRectangle: defaultErrorRec
                    errorMessage: defaultErrorMessage

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

                        onActiveFocusChanged: {

                            // show only error on foucs
                            if (activeFocus && parent.error) {
                                parent.fnShowErrorMessage("Einen Nachnamen eingeben!")
                            }
                            // if focus is out
                            if (!activeFocus && input_surname.text.length == 0) {
                                parent.error = true
                                parent.fnHideErrorMessage()
                            } else if (!activeFocus && input_surname.text.length > 0) {
                                parent.error = false
                                parent.fnHideErrorMessage()
                            }
                        }


                    }

                }
            }

            Row {
                spacing: 40
                LabelLayout {
                    labelPos: formLabelPos
                    labelMargin: 5

                    errorRectangle: defaultErrorRec
                    errorMessage: topErrorMessage

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

                        onActiveFocusChanged: {
                            var valid = parseInt(text.charAt(0)) >= 0
                            var validStr = qsTr("Ein Datum eingeben!")
                            if (valid && !validDate) {
                                valid = false
                                validStr = qsTr("Ein gültiges Datum eingeben. \n(Bsp: 12.10.2012)")
                            }

                            if (activeFocus && parent.error) {
                                parent.fnShowErrorMessage("Ein Datum eingeben!")
                            }



                            if (!activeFocus && input_birth.text.length == 0) {
                                parent.error = true
                                parent.fnHideErrorMessage()
                            } else if (!activeFocus && valid) {
                                parent.error = false
                                parent.fnHideErrorMessage()
                            }
                        }
                    }

                }

                LabelLayout {
                    labelPos: formLabelPos
                    labelMargin: 0

                    errorRectangle: sexErrorRec
                    errorMessage: topErrorMessage

                    property bool wholeFocus

                    function fnCheckError() {
                        if (!input_female.checked && !input_male.checked) {
                            error = true
                        } else {
                            error = false
                        }
                    }

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
                            onContainsMouseChanged: {
                                if (containsMouse && parent.parent.error) {
                                    parent.parent.fnShowErrorMessage("Welches Geschlecht hat die Person?")
                                } else {
                                    parent.parent.fnHideErrorMessage()
                                }
                            }

                            onCheckedChanged: {
                                if (checked)
                                    input_male.checked = false
                                parent.parent.fnCheckError();
                            }
                            onClicked: {
                                focus = true
                            }

                            onActiveFocusChanged: {

                            }

                            KeyNavigation.tab: input_male

                        }
                        CheckBox {
                            id:input_male
                            text: "M"
                            width: 50
                            height: input_birth.height-1
                            onContainsMouseChanged: {
                                if (containsMouse && parent.parent.error) {
                                    parent.parent.fnShowErrorMessage("Welches Geschlecht hat die Person?")
                                } else {
                                    parent.parent.fnHideErrorMessage()
                                }
                            }
                            onCheckedChanged: {
                                if (checked)
                                    input_female.checked = false
                                parent.parent.fnCheckError();
                            }

                            onActiveFocusChanged: {
                                parent.parent.wholeFocus = activeFocus

                            }


                            onClicked: {
                                focus = true
                            }

                        }
                    }


                }
            }

            LabelLayout {
                labelPos: Qt.AlignTop


                Label {
                    text: "Time"
                }

                TimeEdit {

                }


            }

        }
    }

    Component {
        id: sexErrorRec
        Rectangle {
            border.color: "#FF7777"
            color: "#FF7777"
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
            border.color: "#cc0000"
            color: "transparent"
            border.width: 2

            Behavior on opacity {
                NumberAnimation {duration: 500}
            }
        }
    }

    Component {
        id: defaultErrorMessage
        ToolTip {
            width: text.width+20
            height: text.height+15
            property alias message: text.text
            Text {
                id:text
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
            }

            Behavior on opacity {
                NumberAnimation { duration:500}
            }
        }
    }

    Component {
        id: topErrorMessage
        ToolTip {
            width: text.width+20
            height: text.height+15
            anchor: Qt.AlignTop
            property alias message: text.text
            Text {
                id:text
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                color: "white"
            }

            Behavior on opacity {
                NumberAnimation { duration:500}
            }
        }
    }

}
