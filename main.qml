import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem

MainView {
    id:mainView

    objectName: "mainView"

    applicationName: "com.ubuntu.developer.derjasper.dicer"

    automaticOrientation: true

    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)

    anchorToKeyboard: true

    Page {
        id:page

        title: i18n.tr("Dicer")

        Component.onCompleted: mainView.generate()

        Column {
            id:col

            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Column {
                id: viewCol
                width: parent.width
                height: parent.height - bottomArea.height - units.gu(1)

                GridView { // TODO zentrieren
                    id: gridView
                    anchors.fill: parent
                    anchors.centerIn: parent
                    flickableDirection: Flickable.VerticalFlick
                    clip: true

                    model: randomNumbers

                    delegate: UbuntuShape {
                        width:gridView.cellWidth-units.gu(2)
                        height:gridView.cellHeight-units.gu(2)
                        anchors.margins: units.gu(1)

                        color: "lightgrey"

                        Label {
                            id:label
                            anchors.centerIn: parent
                            text: value+""
                            fontSize: "x-large"
                        }
                    }
                }

            }

            Column {
                id:bottomArea
                width:parent.width
                spacing:units.gu(1)

                Row {
                    id:r1
                    width: parent.width
                    spacing: units.gu(1)

                    TextField {

                        width: parent.width/2 - units.gu(0.5)

                        id: numberFrom
                        objectName: "numberFrom"
                        placeholderText: i18n.tr("from")
                        inputMethodHints: Qt.ImhDigitsOnly
                        text: "1"
                        validator: IntValidator {

                        }
                        StateSaver.properties: "text"
                    }

                    TextField {
                        width: parent.width/2 - units.gu(0.5)

                        id: numberTo
                        objectName: "numberTo"
                        placeholderText: i18n.tr("to")
                        inputMethodHints: Qt.ImhDigitsOnly
                        text:"6"
                        validator: IntValidator {

                        }
                        StateSaver.properties: "text"
                    }
                }

                Row {
                    id: r2
                    width: parent.width
                    spacing: units.gu(1)

                    TextField {
                        width: units.gu(10) - units.gu(0.5)

                        id: count
                        objectName: "count"
                        placeholderText: i18n.tr("count")
                        inputMethodHints: Qt.ImhDigitsOnly
                        text:"100"
                        validator: IntValidator {

                        }
                        StateSaver.properties: "text"
                    }

                    Button {
                        id:button
                        objectName: "button"
                        width: parent.width - units.gu(10) - units.gu(0.5)

                        text: i18n.tr("Generate")

                        color: UbuntuColors.orange

                        onClicked: mainView.generate()

                    }

                }
            }
        }

        // this element is needed to determine the maximum width of an element
        UbuntuShape {
            id: testShape
            visible:false
            width:testLabel.width+units.gu(7)
            height:testLabel.height+units.gu(5)

            Label {
                id: testLabel
                anchors.centerIn: parent
                fontSize: "x-large"
            }
        }
    }

    ListModel {
        id: randomNumbers

        function generate() {
            randomNumbers.clear();
            for (var i=0;i<parseInt(count.text);i++) {
                randomNumbers.append({
                    value: Math.floor(Math.random()*(parseInt(numberTo.text)-parseInt(numberFrom.text)+1)) + parseInt(numberFrom.text)
                });
            }
        }
    }

    function determineMaximumItemDimensions(text) {
        testLabel.text = text;
        testShape.visible = true;
        var width = testShape.width;
        var height = testShape.height;
        testShape.visible=false;
        return {width:width,height:height};
    }

    function generate() {
        randomNumbers.generate();
        var dim = mainView.determineMaximumItemDimensions(numberTo.text);
        gridView.cellWidth = dim.width+units.gu(2);
        gridView.cellHeight = dim.height+units.gu(2);
    }

}

