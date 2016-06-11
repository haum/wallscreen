import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    color: "#000000"
    title: "HAUM WallScreen"
    visible: true

    visibility: Window.AutomaticVisibility
    width: 1024
    height: 1024*9/16

    Image {
        x: 20
        y: 20
        width: parent.width / 3
        height: width * 3 / 8
        fillMode: Image.PreserveAspectFit
        source: "../haum.png"
    }
}
