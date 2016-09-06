import QtQuick 2.0
import QtQuick.Controls 1.0
import HaumWallScreen 1.0

Item {
    id: component
    property int nr: 0
    property int time: 10
    property string path: "diaporama"

    onNrChanged: {
        console.log("diaporama: " + fl.files[nr])
        sv.push({"item" : view, "properties" : {"nb" : nr}, "replace": true})
    }

    FileList {
        id: fl
        directory: component.path
    }

    StackView {
        id: sv
        anchors.fill: parent
        initialItem: view

        delegate: StackViewDelegate {
            pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 800
                }
                PropertyAnimation {
                    target: enterItem
                    property: "scale"
                    easing {
                        type: Easing.OutExpo
                    }
                    from: 0.5
                    to: 1
                    duration: 1000
                }
                PropertyAnimation {
                    target: exitItem
                    property: "opacity"
                    from: 1
                    to: 0
                }
            }
        }

        Component {
            id: view

            Image {
                property int nb: 0

                width: sv.width
                height: sv.height
                fillMode: Image.PreserveAspectFit
                source: fl.files[nb]
            }
        }
    }

    Timer {
        running: true
        repeat: true
        triggeredOnStart: true
        interval: component.time * 1000
        onTriggered: component.nr = Math.floor(Math.random() * fl.count)
    }
}
