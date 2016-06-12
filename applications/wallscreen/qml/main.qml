import QtQuick 2.0
import QtQuick.Window 2.1

import "diaporama"
import "spaceapi"
import "irc"
import "clock"

Window {
    color: "#000000"
    title: "HAUM WallScreen"
    visible: true

    visibility: Window.AutomaticVisibility
    width: 1024
    height: 1024*9/16

    Rectangle {
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        width: parent.width / 5
        color: "#111"

        Image {
            id: logo
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 10
            }
            width: parent.width - 20
            fillMode: Image.PreserveAspectFit
            source: "../haum.png"
        }

        SpaceApi {
            id: spaceapi
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: logo.bottom
                topMargin: 10
            }
            width: parent.width - 20
        }

        Clock {
            anchors {
                left: parent.left
                right: parent.right
                top: spaceapi.bottom
                topMargin: 10
            }
        }
    }

    Diaporama {
        id: dioporama
        anchors {
            fill: parent
            rightMargin: parent.width / 5
        }
    }

    IrcViewer {
        anchors.fill: dioporama
    }
}
