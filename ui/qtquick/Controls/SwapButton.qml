// Copyright (C) 2022 The Genyleap.
// Copyright (C) 2022 Kambiz Asadzadeh
// SPDX-License-Identifier: LGPL-3.0-only

import QtQuick
import QtQuick.Controls as T
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../Controls" as Controls

Rectangle {
    width: 64
    height: 64
    radius: width
    color: appStyle.backgroundActivated

    property bool isSwapped: false

    signal swap();

    Rectangle {
        width: 48
        height: 48
        radius: width
        border.width: 1
        border.color: appStyle.borderActivated
        anchors.centerIn: parent
        z: 999
        Text {
            id: textSwap
            anchors.centerIn: parent
            font.family: fontSystem.getAwesomeLight.name
            font.pixelSize: 16
            font.bold: false
            text: "\uf0ec"
            rotation: 90
            color: appStyle.secondry
        }
        NumberAnimation {
            id: swapAnim
            target: textSwap
            property: "rotation"
            duration: appStyle.duration*1.5
            easing.type: Easing.InOutQuad
            from: -90
            to: 90
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            swap();
            swapAnim.start();
        }
    }
}
