import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Themes 1.0 as Color

Rectangle {
    color: Color.Theme.lightNeutral
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20

        // Title Section
        Text {
            text: qsTr("Tickets")
            font.pixelSize: 24
            color: Color.Theme.darkNeutral
            Layout.alignment: Qt.AlignTop
        }

        // Filters Section
        RowLayout {
            spacing: 10
            Text { text: qsTr("id") }
            Text { text: qsTr("ticket_name") }
            Text { text: qsTr("pipeline") }
            Text { text: qsTr("ticket_status") }
            Text { text: qsTr("priority") }
        }

        // Table Section
        HorizontalHeaderView {
            id: horizontalHeader
            syncView: tableView
            Layout.fillWidth: true
            model: [ "id", "ticket_name", "pipeline", "ticket_status", "priority"]
        }

        TableView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: ticketsModel
            clip: true

            delegate: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                border.width: 1
                border.color: Color.Theme.accent

                Text {
                    anchors.centerIn: parent
                    text: display
                }
            }

            columnWidthProvider: function (column) {
                switch (column) {
                    case 0: return 80;  // id
                    case 1: return 200; // ticket_name
                    case 2: return 200; // pipeline
                    case 3: return 100; // ticket_status
                    case 4: return 100; // priority
                    default: return 100;
                }
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