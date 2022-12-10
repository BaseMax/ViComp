import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls" as Controls

Rectangle {
    width: parent.width
    height: 127
    Layout.fillWidth: true
    radius: appStyle.radius
    border.width: 1
    border.color: appStyle.borderActivated

    property string icon : ""
    property string title : ""
    property double price : 0.0
    property double price2 : 0.0
    property double balance : 0.0

    RowLayout {
        width: parent.width
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        Item { width: 10;}

        ColumnLayout {
            width: parent.width
            Layout.fillWidth: true
            Item { height: 20;}
            Text {
                font.family: fontSystem.getContentFontBold.name
                font.bold: true
                font.pixelSize: 32
                color: appStyle.foregroundActivated
                text: price
            }
            Text {
                font.family: fontSystem.getContentFontBold.name
                font.bold: false
                color: appStyle.foregroundHovered
                font.pixelSize: 18
                text: qsTr("$"+price2)
            }
        }

        Item { Layout.fillWidth: true; }

        ColumnLayout {
            width: parent.width
            Layout.fillWidth: true
            Item { height: 25; }
            Rectangle {
                width: 128
                height: 48
                color: "#f6f8fa"
                radius: width

                ColumnLayout {
                    anchors.fill: parent
                    RowLayout {
                        width: parent.width
                        Layout.fillWidth: true
                        spacing: 5;
                        Item { width: 5;}
                        Rectangle {
                            width: 38
                            height: 38
                            color: appStyle.backgroundActivated
                            radius: width
                            Image {
                                anchors.centerIn: parent
                                id: imageView
                                sourceSize.width: 28
                                sourceSize.height: 28
                                fillMode: Image.PreserveAspectCrop
                                source: icon
                            }
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.family: fontSystem.getContentFontBold.name
                            font.bold: true
                            color: appStyle.foregroundActivated
                            font.pixelSize: 18
                            text: qsTr(title)
                        }
                        Item { width: 5;}
                        Text {
                            font.family: fontSystem.getAwesomeLight.name
                            font.bold: false
                            color: appStyle.foregroundHovered
                            font.pixelSize: 14
                            text: "\uf105"
                        }
                    }
                }
            }
            RowLayout {
                spacing: 5;
                Item { width: 10; }
                Text {
                    font.family: fontSystem.getContentFont.name
                    font.pixelSize: appStyle.t1
                    color: appStyle.foregroundHovered
                    text: qsTr("Balance:")
                }
                Text {
                    font.family: fontSystem.getContentFont.name
                    font.pixelSize: 12
                    font.bold: true
                    color: appStyle.secondry
                    text: balance
                }
            }

        }

        Item { width: 10;}
    }

}
