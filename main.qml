import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import QtQuick.Shapes 1.15
import Themes 1.0 as Color  
import Apps 1.0 as App

Window {
    width: Screen.width
    height: Screen.height
    color: Color.Theme.primary
    visible: true
    title: qsTr("HubSpot Clone")

    Rectangle {
        id: sideBar
        anchors.top: parent.top
        anchors.left: parent.left
        color: Color.Theme.primary
        height: parent.height
        width: isExpanded ? 150 : 50
        clip: true

        property bool isExpanded: false
        property string selectedItem: ""
        property bool isSidebarHovered: false
        property bool isAnyItemHovered: false
        

        Behavior on width {
            NumberAnimation { duration: 200 }
        }

        

        Timer {
            id: hoverTimer
            interval: 50 // Short delay to prevent rapid toggling
            onTriggered: {
                sideBar.isExpanded = sideBar.isSidebarHovered || sideBar.isAnyItemHovered
            }
        }

         MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                sideBar.isSidebarHovered = true
                hoverTimer.restart()
            }
            onExited: {
                sideBar.isSidebarHovered = false
                hoverTimer.restart()
            }
        }


        ColumnLayout {
            id: sideBarContent
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            spacing: 10

            Rectangle {
                id: logo
                width: sideBar.width
                height: 50
                color: "transparent"
                Row {
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10 

                    Image {
                        source: "qrc:/icons/Hubspot_logo.png"
                        width: 24
                        height: 24
                    }
                }
            }
        
            Rectangle {
                id: crmDisplay
                width: sideBar.width - 10
                height: 40
                color: "transparent"

                Row {
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10 //

                    Image {
                        source: "qrc:/icons/grid_view_32dp_F0F5F9.png"
                        width: 24
                        height: 24
                    }

                    Text {
                        text: "CRM"
                        color: Color.Theme.lightNeutral
                        visible: sideBar.isExpanded
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Rectangle {
                id: displayLine
                width: sideBar.width - 25
                height: 1
                color: Color.Theme.accent
                // Remove anchors and use Layout properties
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop // Align to the left and top
                Layout.topMargin: 10 // Keep the margin if needed
                Layout.leftMargin: 10 // Keep the margin if needed
            }
            

            Repeater {
                model: [
                    { icon: "qrc:/icons/contact_page_32dp_F0F5F9.png", text: "Contacts" },
                    { icon: "qrc:/icons/store_32dp_F0F5F9.png", text: "Companies" },
                    { icon: "qrc:/icons/confirmation_number_32dp_F0F5F9.png", text: "Tickets" },
                    { icon: "qrc:/icons/monitoring_32dp_F0F5F9.png", text: "Reports" }
                ]
                delegate: Rectangle {
                    id: sideBarItem
                    Layout.fillWidth: true
                    height: 40
                    color: "transparent"

                    Rectangle {
                        anchors.fill: parent
                        color: {
                            if (modelData.text === sideBar.selectedItem) {
                                return Color.Theme.secondary
                            } else if (itemMouseArea.containsMouse && sideBar.isExpanded) {
                                return Color.Theme.secondary
                            } else {
                                return "transparent"
                            }
                        }
                    }
                    
                    Row {
                        spacing: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10 // Added left padding

                        Image {
                            source: modelData.icon
                            width: 24
                            height: 24
                        }

                        Text {
                            id: iconText
                            text: modelData.text
                            color: Color.Theme.lightNeutral
                            visible: sideBar.isExpanded
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Item {
                            Layout.fillWidth: true
                        }
                    }

                    Image {
                        id: chevronIcon
                        source: "qrc:/icons/chevron_right_32dp_F0F5F9.png"
                        width: 24
                        height: 24
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        visible: itemMouseArea.containsMouse && sideBar.isExpanded
                    }

                    MouseArea {
                        id: itemMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            sideBar.isAnyItemHovered = true
                            hoverTimer.restart()
                        }
                        onExited: {
                            sideBar.isAnyItemHovered = false
                            hoverTimer.restart()
                        }
                        onClicked: {
                            sideBar.selectedItem = modelData.text
                            appArea.loadPage(modelData.text)
                            print(modelData.text + " clicked")
                        }
                    }

                }
            }
        }
    }

    Rectangle {
        id: topBar
        anchors.left: sideBar.right
        anchors.top: parent.top
        height: 30
        width: parent.width
        color: Color.Theme.primary
    }

    Shape {
        id: innerFillet
        anchors.left: sideBar.right
        anchors.top: topBar.bottom
        width: 20
        height: 20

        ShapePath {
            fillColor: Color.Theme.primary
            strokeColor: Color.Theme.primary
            strokeWidth: 1

            PathMove { x: 0; y: 20 }
            PathArc { x: 20; y: 0; radiusX: 20; radiusY: 20 }
            PathLine { x: 0; y: 0 }
            PathLine { x: 0; y: 20 }
        }
    }

    Rectangle {
        id: appArea
        z:-1
        anchors.left: Window.right
        x: 50
        anchors.top: topBar.bottom
        height: parent.height - 40
        width: parent.width - 40
        color: Color.Theme.background
        StackLayout {
            id: pageStack
            anchors.fill: parent
            currentIndex: 0
            App.Contacts {}
            App.Companies {}
            App.Tickets {}
            App.Reports {}
        }

        function loadPage(page) {
            switch (page) {
                case "Contacts":
                    pageStack.currentIndex = 0
                    break
                case "Companies":
                    pageStack.currentIndex = 1
                    break
                case "Tickets":
                    pageStack.currentIndex = 2
                    break
                case "Reports":
                    pageStack.currentIndex = 3
                    break
                default:
                    console.log("Unknown page:", page)
                    pageStack.currentIndex = 0 // Or set to a default page
            }
        }
    }
}