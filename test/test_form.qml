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
                        textColor: "#2B2B2B"
                        width: 250
                        font {
                            family: "Arial"
                            pixelSize: 20
                        }
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
                        textColor: "#2B2B2B"
                        width: 250
                        font {
                            family: "Arial"
                            pixelSize: 20
                        }
                    }

                }
            }

            Row {
                spacing: 10
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
                    }

                }

                LabelLayout {
                    labelPos: Qt.AlignBottom
                    labelMargin: 5
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
                            text: "M"
                            width: 50
                            height: input_birth.height-1
                            onCheckedChanged: focus = true

                        }
                        CheckBox {
                            text: "W"
                            width: 50
                            height: input_birth.height-1
                            onCheckedChanged: focus = true
                        }
                    }

                }
            }

            ToolTip {

            }

        }



    }

}
