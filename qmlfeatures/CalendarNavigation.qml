import QtQuick 1.1
import QtDesktop 0.1
import "common/utils.js" as QmlFeatureUtils
Item {
    id: calendarNavigation
    property variant selectedDate: new Date()
    property color selectColor: "#ccedff"
    property color selectBorderColor: "#008df2"
    signal dayClicked(date clickedDate)

    QtObject {
        id: d
        property int currentViewType:0
        property Item currentView
        property Item nextView
        property variant currentDate
        property ParallelAnimation anim

        property ListModel dayNames: ListModel {}

        property ListModel monthNames: ListModel {}

        property int dayWidth: 25
        property int dayHeight: 20

        property int monthWidth: 45
        property int monthHeight: 40
        property int monthViewWidth
        property int monthViewHeight

        property int headerHeight: 20

    }



    width: 220
    height: 175
    clip:true


    function fnViewZoomOut() {
        if (d.currentViewType > 1 || (d.anim && d.anim.running))
            return;

        d.nextView = fnCreateView(d.currentViewType+1, d.currentDate, {opacity:0})
        var selId = d.nextView.selectionIndex

        var currentViewScale = d.currentView.myScale;
        var nextViewScale = d.nextView.myScale;

        fnSetScale(currentViewScale, nextViewScale, selId)

        d.currentViewType++;
        fnUpdateHeader()

        d.anim = anim_viewzoomout_comp.createObject(d.currentView)
        d.anim.startX = d.currentView.width/2 - currentViewScale.origin.x
        d.anim.startY = d.currentView.height/2 - currentViewScale.origin.y

        d.anim.start()

    }

    function fnViewZoomIn(newMonthIdx) {
        if (d.currentViewType == 0 || (d.anim && d.anim.running))
            return;
        var newDate;
        switch (d.currentViewType-1) {
        case 0:
            newDate = new Date(d.currentDate.getFullYear(), newMonthIdx, d.currentDate.getDate())
            break;
        case 1:
            newDate = new Date(d.currentView.model.get(newMonthIdx).name, d.currentDate.getMonth(), d.currentDate.getDate())
            break;
        }

        d.nextView = fnCreateView(d.currentViewType-1 ,newDate, {z:0,opacity:0})
        d.currentView.z = 1

        var selId = newMonthIdx
        d.currentView.selectionIndex = newMonthIdx

        var currentViewScale = d.currentView.myScale;
        var nextViewScale = d.nextView.myScale;

        fnSetScale(currentViewScale, nextViewScale, selId)
        d.currentViewType--;
        fnUpdateHeader()
        d.anim = anim_viewzoomin_comp.createObject(d.currentView)
        d.anim.endX =
                d.currentView.width/2 - (currentViewScale.origin.x)+d.currentView.x
        d.anim.endY =
                d.currentView.height/2 - (currentViewScale.origin.y)+d.currentView.y

        d.anim.start()


    }

    function fnSetScale(currentViewScale, nextViewScale, selId) {
        var selIdY = (Math.floor(selId / 4) * (d.monthHeight +12)) + d.monthHeight/2
        var selIdX = (selId % 4) * (d.monthWidth + 12) + d.monthWidth/2

        currentViewScale.origin.x = selIdX
        currentViewScale.origin.y = selIdY

        nextViewScale.origin.x = currentViewScale.origin.x
        nextViewScale.origin.y = currentViewScale.origin.y

    }

    /**
      *
      */
    function fnShowPreviousView() {
        if (d.anim && d.anim.running) return
        switch(d.currentViewType) {
        case 0:
            d.currentDate = new Date(d.currentDate.getFullYear(), d.currentDate.getMonth()-1, d.currentDate.getDate())
            break;
        case 1:
            d.currentDate = new Date(d.currentDate.getFullYear()-1, d.currentDate.getMonth(), d.currentDate.getDate())
            break;
        case 2:
            d.currentDate = new Date(d.currentDate.getFullYear()-10, d.currentDate.getMonth(), d.currentDate.getDate())
            break;
        }
        d.nextView = fnCreateView(d.currentViewType
                                  ,d.currentDate
                                  , {opacity: 1})

        fnUpdateHeader()
        var anim = anim_horizontal_comp.createObject(d.currentView)
        anim.nextX = d.nextView.x
        d.nextView.x = -calendarNavigation.width
        anim.currentX = calendarNavigation.width
        anim.start();
        d.anim = anim
    }

    function fnShowNextView() {
        if (d.anim && d.anim.running) return
        switch(d.currentViewType) {
        case 0:
            d.currentDate = new Date(d.currentDate.getFullYear(), d.currentDate.getMonth()+1, d.currentDate.getDate())
            break;
        case 1:
            d.currentDate = new Date(d.currentDate.getFullYear()+1, d.currentDate.getMonth(), d.currentDate.getDate())
            break;
        case 2:
            d.currentDate = new Date(d.currentDate.getFullYear()+10, d.currentDate.getMonth(), d.currentDate.getDate())
            break;
        }
        fnUpdateHeader()
        d.nextView = fnCreateView(d.currentViewType
                                  ,d.currentDate
                                  , {opacity: 1})

        fnUpdateHeader()

        var anim = anim_horizontal_comp.createObject(d.currentView)

        anim.nextX = d.nextView.x
        anim.currentX = -calendarNavigation.width
        d.nextView.x = calendarNavigation.width
        anim.start();
        d.anim = anim

    }


    function fnCreateView(type, date, options) {
        var view
        d.currentDate = date
        switch (type) {
        case 0:
            view = dayViewComponent.createObject(calendarNavigation, options);
            view.model = fnLoadModel(date, view)
            // console.debug("create day view")
            break;
        case 1:
            view = monthViewComponent.createObject(calendarNavigation, options)
            view.selectionIndex = date.getMonth()
            view.model = d.monthNames
            // console.debug("create month view")
            break;
        case 2:
            view = monthViewComponent.createObject(calendarNavigation, options)
            var startYear = date.getFullYear() - date.getFullYear()%10;
            if (date.getFullYear()%10 == 0) startYear -= 10
            var model = dynamicmodel.createObject(view)
            view.selectionIndex = d.currentDate.getFullYear()-startYear
            date.setFullYear(startYear)
            for (var i = 0; i < 12; i++) {
                model.append({name:Qt.formatDate(date, "yyyy"), inRange: i>0 && i<11});
                date.setFullYear(date.getFullYear()+1)
            }

            view.model = model
        }



        return view
    }

    /**
      * release current view.
      */
    function fnAnimationComplete(anim) {

        d.currentView.destroy();
        d.currentView = d.nextView;
        if (anim)
            anim.destroy()
    }

    function fnUpdateHeader() {
        switch (d.currentViewType) {
        case 0: txt_header.text = Qt.formatDate(d.currentDate, "MMMM yyyy"); break;
        case 1: txt_header.text = Qt.formatDate(d.currentDate, "yyyy"); break;
        case 2: txt_header.text = d.nextView.model.get(1).name + " - " + d.nextView.model.get(10).name
        }
    }

    function fnLoadModel(da, view) {

        var daym = dynamicmodel.createObject(view);

        var year = da.getFullYear();
        var month = da.getMonth();
        da.setDate(-1)
        da.setDate(da.getDate() - da.getDay()+1);
        //// console.log("load daymodel for " + p.currentDate);

        for (var i = 0; i < 42; i++) {
            if (fnEqualsDate(da, d.currentDate))
                view.selectionIndex = i
            daym.append({date: da, inRange: da.getMonth() == month})
            da.setDate(da.getDate()+1);

        }

        return daym
    }

    function fnEqualsDate(d1, d2) {
        return d1.getDate() == d2.getDate() && d1.getMonth() == d2.getMonth()
                && d1.getFullYear() == d2.getFullYear();
    }


    Component.onCompleted: {

        // generate models
        if (!QmlFeatureUtils.fnIsValidDate(selectedDate)) {
            selectedDate = new Date()
        }

        var dd = new Date(2012, 9,1)
        for (var i = 0; i < 7; i++) {
            d.dayNames.append({name: Qt.formatDate(dd, "ddd")})
            dd.setDate(dd.getDate()+1)
        }

        dd = new Date(2012,0,1)
        for (var i = 0; i < 12; i++) {
            d.monthNames.append({name: Qt.formatDate(dd, "MMM"), inRange:true})
            dd.setMonth(dd.getMonth()+1)
        }

        var startView = fnCreateView(d.currentViewType, selectedDate, {})

        var textElement = Qt.createQmlObject('import QtQuick 1.0; Text { text: "Wed"}',
                                                 parent, "calcTextWidth");

            // Use textElement.width for the width of the text
        // console.log(textElement.width)
        d.dayWidth = textElement.width
        d.dayHeight = textElement.height+5
        width = (d.dayWidth+5) * 7+1
        height = (d.dayHeight+5) *7 + d.headerHeight

        d.monthViewWidth = (d.monthWidth+11)*3+d.monthWidth+1
        d.monthViewHeight = (d.monthHeight+11)*2+d.monthHeight

        width = Math.max(width, d.monthViewWidth)

        // Dispose of temporary element
        textElement.destroy()

        fnUpdateHeader()

        d.currentView = startView

    }

    Component {
        id:dynamicmodel
        ListModel {

        }
    }


    Item {
        id: header
        y:1
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.rightMargin:5
        height: d.headerHeight
        z: 10
        Rectangle {
            anchors.fill: parent
        }

        Image {
            anchors.left: parent.left
            source: "images/left_navi.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    fnShowPreviousView();
                }
            }
        }



        Item {
            width: 130
            height:18
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                anchors.topMargin: 0
                anchors.fill:parent
                color: selectColor
                border.color:selectBorderColor
                radius:2
                opacity: header_mousearea.containsMouse? 1:0
                Behavior on opacity {
                    NumberAnimation {
                        duration:200
                    }
                }


            }

            MouseArea {
                id:header_mousearea
                anchors.fill: parent
                hoverEnabled: d.currentViewType < 2
                onClicked: {
                    fnViewZoomOut()
                }

            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 5
                Text {

                    id:txt_header
                    text: "Month"
                }

                Image {
                    visible: d.currentViewType < 2
                    source: "images/zoom_out.svg"

                }
            }


        }
        Image {
            anchors.right: parent.right
            source: "images/right_navi.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    fnShowNextView();
                }
            }
        }

    }



    Component {
        id:dayViewComponent
        Column {

            property ListModel model
            property Scale myScale: Scale {}
            property int selectionIndex

            x: calendarNavigation.width/2-width/2; y: d.headerHeight
            transform: myScale
            spacing: 5
            z:0

            Row {
                spacing: 3
                Repeater {
                    model: d.dayNames
                    delegate:
                        Rectangle {
                        width: d.dayWidth; height: d.dayHeight

                        z:0
                        property ListModel dayModel

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            text: name
                            font.bold: true

                        }
                    }
                }
            }

            Grid {
                spacing: 3
                columns: 7
                opacity: 1

                Repeater {

                    model: parent.parent.model
                    delegate: Item {
                        id:delegate
                        width: d.dayWidth; height: d.dayHeight
                        Rectangle {
                            anchors.fill: parent
                            color: selectColor
                            border.color: selectBorderColor
                            opacity: dayview_mousearea.containsMouse
                                     || selectionIndex == index? 1:0

                            Behavior on opacity {
                                NumberAnimation {
                                    duration:200
                                }
                            }
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 5
                            text: date.getDate()
                            color: inRange?"black":"lightgrey"
                        }
                        MouseArea {
                            id: dayview_mousearea
                            hoverEnabled: true
                            anchors.fill: parent

                            onClicked: {
                                selectedDate = date
                                d.currentDate = date
                                selectionIndex = index
                                dayClicked(date)
                            }
                        }

                    }
                }


            }
        }
    }

    Component {
        id: monthViewComponent

        Grid {
            property Scale myScale: Scale {}
            property ListModel model
            property int selectionIndex
            x: calendarNavigation.width/2 - d.monthViewWidth/2
            ; y: (calendarNavigation.height+d.headerHeight)/2 - height/2
            opacity: 0
            spacing: 11
            columns: 4

            transform: myScale
            z: 1

            Repeater {

                model: parent.model
                delegate: Item {
                    id:monthDelegate
                    width: d.monthWidth; height: d.monthHeight
                    Rectangle {
                        anchors.fill: parent
                        color: selectColor
                        border.color: selectBorderColor
                        opacity: month_mousearea.containsMouse
                                 || selectionIndex == index? 1:0

                        Behavior on opacity {
                            NumberAnimation {
                                duration:200
                            }
                        }
                    }


                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr(name)
                        color: inRange?"black":"lightGrey"
                    }
                    MouseArea {
                        id: month_mousearea
                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: {
                            fnViewZoomIn(index)
                        }
                    }
                }
            }


        }
    }


    Component {
        id: anim_viewzoomout_comp
        ParallelAnimation {
            id:anim_viewzoomout;
            property int startX
            property int startY

            PropertyAnimation {

                target:d.currentView.myScale
                properties: "xScale, yScale"
                easing.type: Easing.InCurve
                from: 1; to: 0.5
            }
            PropertyAnimation {
                target: d.nextView.myScale
                properties: "xScale, yScale"
                easing.type: Easing.OutCurve
                from: 4; to: 1
            }

            PropertyAnimation {
                target: d.nextView
                property: "opacity"
                easing.type: Easing.OutCurve
                to: 1
            }

            PropertyAnimation {
                target: d.nextView
                properties: "x"
                from: startX
                to: calendarNavigation.width/2 - d.monthViewWidth/2
            }

            PropertyAnimation {
                target: d.nextView
                properties: "y"
                from: startY
                to: (calendarNavigation.height+d.headerHeight)/2 - d.monthViewHeight/2
            }

            PropertyAnimation {
                target: d.currentView
                property: "opacity"
                easing.type: Easing.OutCurve
                to: 0
            }

            onCompleted: {

                fnAnimationComplete(anim_viewzoomout);
            }
        }
    }



    Component {
        id: anim_viewzoomin_comp
        ParallelAnimation {
            id:anim_viewzoomin
            property int endX
            property int endY
            PropertyAnimation {

                target: d.nextView.myScale
                properties: "xScale, yScale"
                easing.type: Easing.InCurve
                from: 0.3; to: 1
            }
            PropertyAnimation {
                target: d.currentView.myScale
                properties: "xScale, yScale"
                easing.type: Easing.OutCurve
                from: 1; to: 4
            }

            PropertyAnimation {
                target: d.currentView
                property: "opacity"
                easing.type: Easing.OutCurve
                to: 0
            }
            PropertyAnimation {
                target: d.nextView
                property: "opacity"
                easing.type: Easing.InCurve
                to: 1
            }

            PropertyAnimation {
                target: d.currentView
                properties: "x"
                to: endX
            }

            PropertyAnimation {
                target: d.currentView
                properties: "y"
                to: endY
            }
            onCompleted: {
                fnAnimationComplete(anim_viewzoomin);
            }
        }
    }


    Component {
        id: anim_horizontal_comp
        ParallelAnimation {
            property int nextX
            property int currentX

            PropertyAnimation {
                target: d.currentView
                property: "x"
                to: currentX
            }
            PropertyAnimation {
                target: d.nextView
                property: "x"
                to: nextX
            }
            onCompleted:  fnAnimationComplete()
        }
    }

}

