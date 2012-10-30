import QtQuick 1.1
import QtDesktop 0.1
import QmlFeatures 1.0

Item {
    width: 800
    height: 600
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
                    labelPos: Qt.AlignBottom
                    labelMargin: 5
                    Label {
                        text: "Vorname"
                        color: "#585858"
                        font {
                            family: "Arial"
                            pixelSize: 12
                            bold:true
                        }
                    }

                    TextField {
                        id: forename
                        textColor: "#2B2B2B"
                        width: 250
                        font {
                            family: "Arial"
                            pixelSize: 20
                        }

                        KeyNavigation.tab: surname
                    }

                }
                LabelLayout {
                    labelPos: Qt.AlignBottom
                    labelMargin: 5
                    Label {
                        text: "Nachname"
                        color: "#585858"
                        font {
                            family: "Arial"
                            pixelSize: 12
                            bold:true
                        }
                    }

                    TextField {
                        id: surname
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
                    labelPos: Qt.AlignBottom
                    labelMargin: 5
                    Label {
                        text: "Geboren am"
                        color: "#585858"
                        font {
                            family: "Arial"
                            pixelSize: 12
                            bold:true
                        }
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
                    labelPos: Qt.AlignBottom
                    labelMargin: 0
                    Label {
                        text: "Geschlecht"
                        color: "#585858"
                        font {
                            family: "Arial"
                            pixelSize: 12
                            bold:true
                        }
                    }

                    Flow {
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

}
