import QtQuick 1.1
import QtDesktop 0.1

Item {
    id: labelitem
    property int layoutDirection: 0
    property int labelPos: 0

    Component.onCompleted: {

        children[0] = _labelComp.createObject(labelitem)

        if (layoutDirection == 0) {
            height = children[0].height + children[1].height
            width = Math.max(children[0].width, children[1].width)

            children[0].anchors.left = left
            children[1].anchors.left = left
            children[0].anchors.right = right
            children[0].anchors.leftMargin = 5
            children[1].anchors.right = right

            if (labelPos == 0) {
                children[1].anchors.top = children[0].bottom
            } else {
                children[0].anchors.top = children[1].bottom
            }

        } else {
            height = Math.max(children[0].width, children[1].width)
            width = children[0].width + children[1].width
            children[0].anchors.top = top
            children[1].anchors.top = top
            children[0].anchors.bottom = bottom
            children[1].anchors.bottom = bottom

            children[1].anchors.left = children[0].right
        }

    }

    Component {
        id: _labelComp
        Label {

        }
    }

}
