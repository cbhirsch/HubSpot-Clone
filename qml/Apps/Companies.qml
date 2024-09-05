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
            text: qsTr("Companies")
            font.pixelSize: 24
            color: Color.Theme.darkNeutral
            Layout.alignment: Qt.AlignTop
        }

        // Filters Section
        RowLayout {
            spacing: 10
            Text { text: qsTr("Create Date") }
            Text { text: qsTr("Last Activity") }
            Text { text: qsTr("Active Tickets") }
        }

        // Table Section
        HorizontalHeaderView {
            id: horizontalHeader
            syncView: tableView
            Layout.fillWidth: true
            model: ["ID", "Name", "Create Date", "Last Activity", "Active Tickets", "Industry", "Employee Count", "Revenue"]
        }

        TableView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: companiesModel
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
                    case 0: return 80;  // ID
                    case 1: return 200; // Name
                    case 2: return 100; // Create Date
                    case 3: return 100; // Last Activity
                    case 4: return 100; // Active Tickets
                    case 5: return 150; // Industry
                    case 6: return 120; // Employee Count
                    case 7: return 150; // Revenue
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