import QtQuick 2.15
import QtQuick.Layouts 2.15
import Themes 1.0 as Color

Rectangle {
    color: Color.Theme.primary
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        Text {
            text: qsTr("Contacts")
            font.pixelSize: 24
            color: Color.Theme.lightNeutral
            Layout.alignment: Qt.AlignTop
        }

        // Add your contacts list or other content here
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Color.Theme.lightNeutral
            radius: 10

            Text {
                anchors.centerIn: parent
                text: qsTr("Contacts content goes here")
                font.pixelSize: 18
                color: Color.Theme.darkNeutral
            }
        }
    }
}