import QtQuick 1.1
import QtDesktop 0.1

Item {
    id: label_layout
    property int labelPos: Qt.AlignTop
    property int labelAlign: Qt.AlignLeft
    property int labelMargin: 0
    property int itemMargin: 0

    property bool error: false
    property Component errorRectangle

    property Item _errorRectangleItem

    onErrorChanged: {
        if (error) {
            _errorRectangleItem = errorRectangle.createObject(
                        label_layout,
                        {width: children[1].width, height: children[1].height,
                        opacity: 0})
            _errorRectangleItem.x = children[1].x + _errorRectangleItem.x
            _errorRectangleItem.y = children[1].y + _errorRectangleItem.y
            _errorRectangleItem.opacity = 1

        } else if (Qt.isQtObject(_errorRectangleItem)) {
                _errorRectangleItem.opacity = 0
                _errorRectangleItem.destroy(500);
        }

    }


    Component.onCompleted: {

        var layoutDirection =
                (labelPos == Qt.AlignTop || labelPos == Qt.AlignBottom)? 0:1

        if (layoutDirection == 0) {
            height = children[0].height + children[1].height
            width = Math.max(children[0].width, children[1].width)
            switch (labelAlign) {
            case Qt.AlignRight:
                children[0].anchors.right = right;
                children[0].anchors.rightMargin = labelMargin;
                break;
            case Qt.AlignLeft:
                children[0].anchors.left = left;
                children[0].anchors.leftMargin = labelMargin;
                break;
            case Qt.AlignCenter:
                children[0].anchors.horizontalCenter = horizontalCenter
            }

            children[1].anchors.left = left
            children[1].anchors.right = right

            if (labelPos == Qt.AlignTop) {
                children[1].anchors.top = children[0].bottom
                children[1].anchors.topMargin = itemMargin
            } else {
                children[0].anchors.top = children[1].bottom
                children[0].anchors.topMargin = itemMargin
            }

        } else {
            height = Math.max(children[0].height, children[1].height)
            width = children[0].width + children[1].width

            switch (labelAlign) {
            case Qt.AlignTop:
                children[0].anchors.top = top
                children[0].anchors.topMargin = labelMargin;
                break;
            case Qt.AlignBottom:
                children[0].anchors.bottom = bottom
                children[0].anchors.bottomMargin = labelMargin;
                break;
            case Qt.AlignCenter:
                children[0].anchors.verticalCenter = verticalCenter
            }

            children[1].anchors.top = top
            children[1].anchors.bottom = bottom

            if (labelPos == Qt.AlignLeft) {
                children[1].anchors.left = children[0].right
                children[1].anchors.leftMargin = itemMargin
            } else {
                children[0].anchors.left = children[1].right
                children[0].anchors.leftMargin = itemMargin
            }

        }

    }

    Component {
        id: _labelComp
        Label {

        }
    }

}
