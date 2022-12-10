// Copyright (C) 2022 The Genyleap.
// Copyright (C) 2022 Kambiz Asadzadeh
// SPDX-License-Identifier: LGPL-3.0-only

import QtQuick
import QtQuick.Controls as T
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../Controls" as Controls

T.Slider {
    id: control
    Layout.fillWidth: true
    value: 0.5
    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 4
        width: control.availableWidth
        height: implicitHeight
        radius: 2
        color: "#f7f7f9"

        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            color: "#4e4e4e"
            radius: 2
        }
    }

    snapMode: Slider.SnapAlways

    handle: Rectangle {
        id: frontRect
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: 26
        implicitHeight: 26
        radius: 13
        color: "#4e4e4e"
        layer.enabled: true
        layer.effect:
            DropShadow {
            anchors.fill: frontRect
            horizontalOffset: 0
            verticalOffset: 3
            radius: 16.0
            color: "#c7cad3"
            samples: 32.0
            spread: 0.0
        }
        Rectangle {
            anchors.centerIn: parent
            width: 14
            height: 14
            radius: width
            color: "#ffffff"
        }
    }

}
