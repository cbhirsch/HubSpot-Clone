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
            text: qsTr("Companies")
            font.pixelSize: 24
            color: Color.Theme.darkNeutral
            Layout.alignment: Qt.AlignTop
        }

        // Filters Section
        RowLayout {
            spacing: 10
            // Add filter components here
            Text { text: qsTr("Create Date") }
            Text { text: qsTr("Last Activity") }
            Text { text: qsTr("Active Tickets") }
        }

        // Table Section
        TableView {
            id: companiesTable
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: companiesModel  // Bind to your model

            // Define the columns
            delegate: Item {
                width: companiesTable.width
                height: 50
                RowLayout {
                    Text { text: model.name }  // Example column
                    Text { text: model.create_date }  // Example column
                    Text { text: model.last_activity }  // Example column
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