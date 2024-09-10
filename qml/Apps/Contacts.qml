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
            text: qsTr("Contacts")
            font.pixelSize: 24
            color: Color.Theme.darkNeutral
            Layout.alignment: Qt.AlignTop
        }

        // Filters Section
        RowLayout {
            spacing: 10
            Text { text: qsTr("id") }
            Text { text: qsTr("name") }
            Text { text: qsTr("email") }
            Text { text: qsTr("phone") }
            Text { text: qsTr("company_name") }
            Text { text: qsTr("lead_status") }
            Text { text: qsTr("LIFECYCLE_STAGE") }
        }

        // Table Section
        HorizontalHeaderView {
            id: horizontalHeader
            syncView: tableView
            Layout.fillWidth: true
            model: [ "id", "Name", "email", "phone", "company_name", "lead_status", "LIFECYCLE_STAGE"]
        }

        TableView {
            id: tableView
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: contactsModel
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
                    case 1: return 200; // Name
                    case 2: return 200; // email
                    case 3: return 100; // phone
                    case 3: return 100; // company_name
                    case 4: return 100; // lead_status
                    case 5: return 150; // LIFECYCLE_STAGE
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