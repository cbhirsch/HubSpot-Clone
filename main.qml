import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 2.15
import "." as App

Window {
    width: Screen.width
    height: Screen.height
    visible: true
    title: qsTr("Demo")

    property int btnWidth: (width - 120) / 2
    property int btnHeight: (height - 120) / 2
    Rectangle {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        color: App.Theme.primary
        width: parent.width
        height: 50;

    }
    Rectangle {
        id: sideBar
        anchors.top: topBar.bottom
        anchors.left: parent.left
        color: App.Theme.primary
        height: parent.height - topBar.height
        width: 50
        state: "collapsed"

        states: [
            State {
                name: "collapsed"
                PropertyChanges { target: sideBar; width: 50 }
            },
            State {
                name: "expanded"
                PropertyChanges { target: sideBar; width: sideBarContent.implicitWidth + 30 } // Add some padding
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

            Repeater {
                model: [
                    { icon: "qrc:/icons/contact_page_32dp_F0F5F9.png", text: "Contacts" },
                    { icon: "qrc:/icons/contact_page_32dp_F0F5F9.png", text: "Messages" },
                    { icon: "qrc:/icons/contact_page_32dp_F0F5F9.png", text: "Settings" },
                    { icon: "qrc:/icons/contact_page_32dp_F0F5F9.png", text: "Profile" }
                ]
                delegate: RowLayout {
                    spacing: 10
                    Layout.fillWidth: true
                    Image {
                        id: icon
                        source: modelData.icon
                        sourceSize.width: 20
                        sourceSize.height: 20
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 15
                    }
                    Text {
                        text: modelData.text
                        color: App.Theme.lightNeutral
                        visible: sideBar.width > 50 // Changed to gradually show text
                        opacity: (sideBar.width - 50) / (sideBarContent.implicitWidth - 20) // Fade in text
                        Layout.alignment: Qt.AlignVCenter
                        Layout.fillWidth: true
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
    Rectangle {
        id: appArea
        anchors.left: sideBar.right
        anchors.top: topBar.bottom
        height: parent.height-topBar.height
        width: parent.width
        }

}
