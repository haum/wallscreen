import QtQuick 2.0
import HaumWallScreen 1.0

ListView {
    id: component
    model: dirc.model
    verticalLayoutDirection: ListView.BottomToTop
    interactive: false
    delegate: Rectangle {
        id: deleg
        anchors {
            left: parent.left
            right: parent.right
        }
        height: Math.max(userbox.height, msgbox.height)
        color: "#000"
        opacity: 0.8

        Text {
            id: userbox
            width: 100
            clip: true
            horizontalAlignment: Text.AlignRight
            text: "<b>" + model.user + "</b>"
            color: "#fff"
        }
        Text {
            id: msgbox
            anchors {
                left: userbox.right
                leftMargin: 10
                right: parent.right
            }
            horizontalAlignment: Text.AlignLeft
            wrapMode: Text.WordWrap
            text: model.msg
            color: "#fff"
        }

        NumberAnimation {
            target: deleg
            property: "opacity"
            to: 0
            duration: 60*1000 // 1 minute
            easing.type: Easing.InExpo
            running: true
        }
    }
    displaced: Transition {
        NumberAnimation { properties: "y"; duration: 500 }
    }
    add: Transition {
        NumberAnimation { properties: "y"; duration: 500 }
    }
    remove: Transition {
        ParallelAnimation {
            NumberAnimation { properties: "opacity"; to: 0; duration: 500 }
            NumberAnimation { properties: "y"; to: -component.height; duration: 500 }
        }
    }
    DirtyIRC {
        id: dirc
    }
}
