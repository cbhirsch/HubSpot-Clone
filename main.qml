import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import Themes as App

Window {
    width: Screen.width
    height: Screen.height
    color: App.Theme.primary
    visible: true
    title: qsTr("Demo")

    Rectangle {
        id: sideBar
        anchors.top: parent.top
        anchors.left: parent.left
        color: App.Theme.primary
        height: parent.height
        width: isExpanded ? 150 : 50

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
                        color: App.Theme.lightNeutral
                        visible: sideBar.isExpanded
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            Rectangle {
                id: displayLine
                width: sideBar.width - 30
                height: 1
                color: App.Theme.accent
                anchors.left: parent.left
                anchors.top: crmDisplay.bottom
                anchors.leftMargin: 12
                anchors.topMargin: 10
            }
            

            Repeater {
                model: [
                    { icon: "qrc:/icons/contact_page_32dp_F0F5F9.png", text: "Contacts" },
                    { icon: "qrc:/icons/store_32dp_F0F5F9.png", text: "Companies" },
                    { icon: "qrc:/icons/confirmation_number_32dp_F0F5F9.png", text: "tickets" },
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
                                return App.Theme.secondary
                            } else if (itemMouseArea.containsMouse && sideBar.isExpanded) {
                                return App.Theme.secondary
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
                            text: modelData.text
                            color: App.Theme.lightNeutral
                            visible: sideBar.isExpanded
                            anchors.verticalCenter: parent.verticalCenter
                        }
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
        color: App.Theme.primary
    }

    Rectangle {
        id: appArea
        anchors.left: sideBar.right
        anchors.top: topBar.bottom
        height: parent.height - topBar.height + 10
        width: parent.width - sideBar.width + 10
        color: App.Theme.lightNeutral
        radius: 10 // Added rounded corners
    }
}