import QtQuick
import QtQuick.Controls as T
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

T.BusyIndicator {
    id: control
    width: 32
    height: 32
    contentItem: Item {
        implicitWidth: 16
        implicitHeight: 16

        Item {
            id: itemProgress
            x: parent.width / 2 - 16
            y: parent.height / 2 - 16
            width: 32
            height: 32
            opacity: control.running ? 1 : 0

            Behavior on opacity {
                OpacityAnimator {
                    duration: 250
                }
            }

            RotationAnimator {
                target: itemProgress
                running: control.visible && control.running
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: 1250
            }

            Repeater {
                id: repeater
                model: 3

                Rectangle {
                    x: itemProgress.width / 2 - width / 2
                    y: itemProgress.height / 2 - height / 2
                    implicitWidth: 5
                    implicitHeight: 5
                    radius: 2.5
                    color: appStyle.primary
                    transform: [
                        Translate {
                            y: -Math.min(itemProgress.width, itemProgress.height) * 0.5 + 7
                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: 2.5
                            origin.y: 2.5
                        }
                    ]
                }
            }
        }
    }

    onRunningChanged: {

    }
}
