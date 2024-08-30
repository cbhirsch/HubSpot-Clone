import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import "." as App

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
        width: 50
        state: "collapsed"

        states: [
            State {
                name: "collapsed"
                PropertyChanges { target: sideBar; width: 50 }
            },
            State {
                name: "expanded"
                PropertyChanges { target: sideBar; width: 150 } // Add some padding
            }
        ]

        transitions: Transition {
            NumberAnimation { 
                properties: "width"
                duration: 200
            }
        }

        MouseArea {
            id: sideBarHoverArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: sideBar.state = "expanded"
            onExited: sideBar.state = "collapsed"
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
                        visible: sideBar.state === "expanded"
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
                    width: sideBar.width - 10
                    height: 40
                    color: "transparent"
                    
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
                            visible: sideBar.state === "expanded"
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    states: [
                        State {
                            name: "hovered"
                            PropertyChanges { target: sideBarItem; color: App.Theme.secondary }
                        },
                        State {
                            name: "unhovered"
                            PropertyChanges { target: sideBarItem; color: App.Theme.primary }
                        },
                        State {
                            name: "selected"
                            PropertyChanges { target: sideBarItem; color: App.Theme.secondary }
                        }
                    ]

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
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