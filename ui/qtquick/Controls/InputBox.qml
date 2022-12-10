// Copyright (C) 2022 The Genyleap.
// Copyright (C) 2022 Kambiz Asadzadeh
// SPDX-License-Identifier: LGPL-3.0-only

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

ColumnLayout {

    property string title;
    property string icon : "";
    property string note;
    property alias value : control.text;
    property string placeHolder : "Send message";
    property string alertType;
    property bool classicTitle : false
    property bool classicMode : false


    QtObject {
        id: internalOptions
        property bool hidden : false;
    }


    Layout.fillWidth: true;

    spacing: 0

    Item { height: 10; }

    // Control
    TextField {
        id:control
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        rightPadding: 20
        leftPadding: 20
        topPadding: classicMode ? 8 : 0
        Layout.fillWidth: true;
        font.family: fontSystem.getContentFont.name
        font.pixelSize: appStyle.paragraph
        placeholderText: classicTitle ? placeHolder : title
        cursorVisible: activeFocus
        color: appStyle.foregroundActivated

        onAccepted: {
            control.focus = false
        }

        placeholderTextColor: appStyle.foregroundHovered

        background: Rectangle {
            id:back
            color: appStyle.backgroundActivated
            height: 24
            radius: width
            implicitHeight: 24

            RowLayout {

                width: parent.width
                Layout.fillWidth: true

                Item { width: 5; }

                Text {
                    id: textIcon
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    visible: icon
                    font.family: fontSystem.getAwesomeRegular.name
                    font.pixelSize: appStyle.h4
                    color: appStyle.primary
                    text: icon
                }
            }
        }
    }

    Rectangle {
        width: parent.width
        Layout.fillWidth: true
        height: 2
        visible: !classicMode
        color: control.focus ? appStyle.borderFocused :  appStyle.borderActivated
        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }
    }
}
