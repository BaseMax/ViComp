// Copyright (C) 2022 The Genyleap.
// Copyright (C) 2022 Kambiz Asadzadeh
// SPDX-License-Identifier: LGPL-3.0-only

import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import QtQuick.Dialogs

import "Controls" as Controls
import "Cards" as Card

import Qt.Compressor 1.0

ApplicationWindow {
    id: appRoot
    width: 512
    height: 880
    visible: true
    title: qsTr("ViComp")
    color: "#ffffff"

    AppStyle { id: appStyle; }

    FontSystem { id: fontSystem; }

    Compressor { id: compressor; }

    FileDialog {
        id: fileDialog
        nameFilters: ["Media files (*.mp4)", "Video (*.mov *.mkv)"]
        flags: FileDialog.DontUseNativeDialog
        fileMode: FileDialog.OpenFile
        onAccepted: {
            player.source = selectedFile
            inText.value = selectedFile
            compressor.setInput(selectedFile)
        }
    }

    FolderDialog {
        id: outputfileDialog
        onAccepted: {
            outText.value = currentFolder
            compressor.setOutput(currentFolder + "/converted.mp4")
        }
    }

    contentData: Page {
        anchors.fill: parent
        anchors.margins: 20
        background: Rectangle { color: "transparent" }
        ColumnLayout {
            width: parent.width
            Layout.fillWidth: true
            spacing: 10
            Item { height: 10; }
            RowLayout {
                width: parent.width
                Layout.fillWidth: true
                Item { Layout.fillWidth: true; }
                Text {
                    font.family: fontSystem.getContentFont.name
                    font.pixelSize: appStyle.h1
                    text: qsTr("ViComp")
                    font.styleName: "Bold"
                }
                Item { Layout.fillWidth: true; }
            }
            RowLayout {
                width: parent.width
                Layout.fillWidth: true
                Item { }
                Text {
                    font.family: fontSystem.getContentFont.name
                    font.pixelSize: appStyle.h4
                    text: qsTr("Compression Options")
                    font.styleName: "Bold"
                }
                Item { Layout.fillWidth: true; }
            }

            ColumnLayout {
                width: parent.width
                Layout.fillWidth: true
                Rectangle {
                    width: parent.width
                    Layout.fillWidth: true
                    height: 360
                    color: "#ebecf0"
                    border.width: 1
                    border.color: "#ebecf0"
                    radius: 15

                    Rectangle {
                        color: "#333"
                        anchors.fill: parent
                        radius: 15
                        MediaPlayer {
                            id: player
                            videoOutput: videoOutput
                            audioOutput: audioOutput
                        }
                        VideoOutput {
                            id: videoOutput
                            anchors.fill: parent
                            fillMode: VideoOutput.PreserveAspectCrop
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    player.play()
                                }
                            }
                        }
                        AudioOutput {
                            id: audioOutput
                        }
                    }
                }
                ColumnLayout {
                    width: parent.width
                    Layout.fillWidth: true
                    spacing: 10

                    Item { height: 10; }

                        RowLayout {
                            width: parent.width
                            Layout.fillWidth: true
                            Item {}
                            Column {
                                width: parent.width
                                Layout.fillWidth: true
                                Controls.VerticalSpacer {}
                                Text {
                                    text: qsTr("Original File")
                                    color: appStyle.foregroundHovered
                                    Layout.fillWidth: true
                                }
                                Controls.InputBox {
                                    id: inText
                                    width: parent.width
                                    Layout.fillWidth: true
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            fileDialog.open();
                                        }
                                    }
                                }
                                Controls.VerticalSpacer {}
                            }
                            Item { width: 10; }
                        }
                        RowLayout {
                            width: parent.width
                            Layout.fillWidth: true
                            Item {}
                            Column {
                                width: parent.width
                                Layout.fillWidth: true
                                Controls.VerticalSpacer {}
                                Text {
                                    text: qsTr("Extract Location")
                                    color: appStyle.foregroundHovered
                                    Layout.fillWidth: true
                                }
                                Controls.InputBox {
                                    id: outText
                                    width: parent.width
                                    Layout.fillWidth: true
                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: {
                                            outputfileDialog.open();
                                            outputfileDialog.title = "Save Converted";
                                        }
                                    }
                                }
                                Controls.VerticalSpacer {}
                            }
                            Item { width: 10; }
                        }

                    Rectangle {
                        width: parent.width
                        Layout.fillWidth: true
                        height: 112
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        color: "white"
                        border.width: 1
                        border.color: "#ebecf0"
                        radius: 15
                        ColumnLayout {
                            width: parent.width
                            Layout.fillWidth: true
                            Item { height: 20; }
                            RowLayout {
                                width: parent.width
                                Layout.fillWidth: true
                                Item { width: 20; }
                                Text {
                                    font.family: fontSystem.getContentFont.name
                                    font.pixelSize: appStyle.h5
                                    font.bold: true
                                    text: qsTr("Compression Level")
                                }
                                Item { Layout.fillWidth: true; }
                                Text {
                                    font.family: fontSystem.getContentFont.name
                                    font.pixelSize: appStyle.h3
                                    text: qsTr(Math.round(slider.value*(10/24) * 10)+"%")
                                    font.bold: false
                                }
                                Item { width: 20; }
                            }

                            RowLayout {
                                width: parent.width
                                Layout.fillWidth: true
                                Item { width: 20; }
                                Controls.Slider {
                                    id: slider
                                    from: 0
                                    to: 24
                                    value: 8
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                }
                                Item { width: 20; }
                            }
                        }
                    }

                    Item { Layout.fillHeight: true; }

                    Controls.Button {
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        implicitWidth: 200
                        text: "Compress File"
                        Layout.fillWidth: false
                        onClicked: {
                            compressor.compress(slider.value)
                        }
                    }

                    Controls.BusyIndicator {
                        id: busyIndicator
                        running: compressor.busy
                    }
                }
            }
        }
    }

    footer: RowLayout {
        width: parent.width
        Layout.fillWidth: true
        height: 48
        Item { Layout.fillWidth: true; }
        Text {
            id: copyright
            font.family: fontSystem.getContentFont.name
            font.pixelSize: appStyle.t1
            text: qsTr("Made by Iranian with love for freedom world.")
            color: appStyle.primary
        }
        Item { Layout.fillWidth: true; }
        Item { width: 10; }
    }
}
