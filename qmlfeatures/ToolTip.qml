import QtQuick 1.1


Item {
    property int anchor: Qt.AlignBottom
    Image {
        id:arrow_image
        source: "images/redarrow.png"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        id:background
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        border.color: "#cc0000"
        border.width: 2
        color:"#FF7777"
    }

    Component.onCompleted: {
        children[2].parent = background

        if (anchor == Qt.AlignBottom) {
            background.anchors.topMargin = 8
            arrow_image.anchors.top = top
        } else if (anchor == Qt.AlignTop) {
            background.anchors.bottomMargin = 8
            arrow_image.rotation = 180
            arrow_image.anchors.bottom = bottom
        }
    }
}
