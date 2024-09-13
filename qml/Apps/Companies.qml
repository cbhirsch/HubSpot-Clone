import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import Themes 1.0 as Color

Rectangle {
    id: root
    color: Color.Theme.background
    
    property int hoveredRow: -1

    ScrollView {
        id: mainScrollView
        anchors.fill: parent
        anchors.margins: 20
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        ColumnLayout {
            width: mainScrollView.width - mainScrollView.ScrollBar.vertical.width - 20 // Subtract scrollbar width and add right margin
            spacing: 20

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
            Rectangle {
                id: tableContainer
                Layout.fillWidth: true
                Layout.preferredHeight: contentHeight
                color: "transparent"
                clip: true

                property int contentHeight: horizontalHeader.height + tableView.contentHeight

                HorizontalHeaderView {
                    id: horizontalHeader
                    syncView: tableView
                    width: parent.width
                    height: 40 // Set a fixed height for the header
                    anchors.top: parent.top
                    model: ["Company name", "Create Date", "Phone number", "Last activity", "City", "Country", "Industry", "Employee count", "Revenue"]
                    
                    delegate: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 40
                        border.width: 1
                        border.color: Color.Theme.tableBorder
                        color: Color.Theme.lightNeutral

                        Text {
                            anchors.fill: parent
                            text: modelData
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: Color.Theme.darkNeutral
                            font.bold: true
                        }
                    }
                }

                Item {
                    anchors.top: horizontalHeader.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    clip: true

                    TableView {
                        id: tableView
                        width: parent.width
                        height: contentHeight
                        model: companiesModel
                        clip: true

                        // Disable vertical scrolling
                        boundsMovement: Flickable.StopAtBounds
                        boundsBehavior: Flickable.StopAtBounds

                        // Enable horizontal scrolling
                        ScrollBar.horizontal: ScrollBar {
                            policy: ScrollBar.AlwaysOn
                        }

                        // Propagate wheel events
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.NoButton
                            onWheel: (wheel) => {
                                wheel.accepted = false;
                            }
                        }

                        property int editingRow: -1
                        property int editingColumn: -1

                        delegate: Rectangle {
                            implicitWidth: 250
                            implicitHeight: 40
                            border.width: 1
                            border.color: Color.Theme.tableBorder
                            color: row === root.hoveredRow ? Color.Theme.lightNeutral : Color.Theme.background

                            Loader {
                                id: contentLoader
                                anchors.fill: parent
                                anchors.leftMargin: 5
                                anchors.rightMargin: 5

                                sourceComponent: (row === tableView.editingRow && column === tableView.editingColumn) ? editComponent : displayComponent

                                Component {
                                    id: displayComponent
                                    Text {
                                        text: display
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        elide: Text.ElideRight
                                        color: Color.Theme.darkNeutral
                                    }
                                }

                                Component {
                                    id: editComponent
                                    TextInput {
                                        text: display
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        color: Color.Theme.darkNeutral
                                        selectByMouse: true

                                        onEditingFinished: {
                                            if (text !== display) {
                                                companiesModel.setData(tableView.model.index(row, column), text, Qt.EditRole)
                                            }
                                            tableView.editingRow = -1
                                            tableView.editingColumn = -1
                                        }

                                        Component.onCompleted: forceActiveFocus()
                                    }
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.IBeamCursor
                                onEntered: root.hoveredRow = row
                                onExited: root.hoveredRow = -1
                                onDoubleClicked: {
                                    tableView.editingRow = row
                                    tableView.editingColumn = column
                                }
                            }
                        }

                        columnWidthProvider: function (column) {
                            return horizontalHeader.delegate.implicitWidth
                        }
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
}