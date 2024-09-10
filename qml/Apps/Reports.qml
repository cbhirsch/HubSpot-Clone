import QtQuick 2.15
import QtQuick.Layouts 2.15
import QtQuick.Controls 2.15
import Themes 1.0 as Color

Rectangle {
    color: Color.Theme.lightNeutral  // Changed background color to lightNeutral
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        // Title Section
        Text {
            text: qsTr("Reports")
            font.pixelSize: 24
            color: Color.Theme.darkNeutral
            Layout.alignment: Qt.AlignTop
        }

        // Filters Section
        RowLayout {
            spacing: 10
            // Add filter components here
            Text { text: qsTr("id") }
            Text { text: qsTr("Ticket Owner") }
            Text { text: qsTr("Create Date") }
            Text { text: qsTr("Last Activity Date") }
            Text { text: qsTr("Priority") }
        }

        // Table Section
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: Color.Theme.secondary
            radius: 10

            Text {
                anchors.centerIn: parent
                text: qsTr("Ticket Table content goes here")
                font.pixelSize: 18
                color: Color.Theme.darkNeutral
            }
        }

        // Table Navigation Section
        RowLayout {
            spacing: 10
            // Add navigation components here
            Button { text: qsTr("Previous") }
            Button { text: qsTr("Next") }
        }
    }
}