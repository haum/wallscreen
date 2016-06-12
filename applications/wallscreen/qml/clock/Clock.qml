import QtQuick 2.0

Item {
    id: component
    property int seconds: 0
    property int minutes: 0
    property int hour: 0
    property int day: 0
    property int month: 0
    height: inner.height * inner.scale

    Item {
        id: inner
        anchors.centerIn: parent
        property int axisx: 24 + seconds.width/2
        property int axisy: height - seconds.height/2
        width: minutes.width + seconds.width
        height: seconds.height + 60

        scale: parent.width/width

        Timer {
            running: true
            interval: 500
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                var date = new Date()

                component.seconds = date.getSeconds();
                component.minutes = date.getMinutes();
                component.hour = date.getHours();
                component.day = date.getDate();
                component.month = date.getMonth() + 1;
            }
        }

        Image {
            id: seconds
            x: parent.axisx - width/2
            y: parent.axisy - width/2
            width: 207
            height: 207
            source: "seconds.png"
            rotation: (component.seconds - 50) * -6 + 1
            Behavior on rotation {
                SpringAnimation {
                    duration: 1000
                    spring: 5
                    damping: 5
                    modulus: 360
                }
            }
        }
        Image {
            id: minutes
            property real minutesdec: component.minutes
            property real _angle: seconds.rotation + 3 + minutesdec * 6
            x: parent.axisx
            y: parent.axisy
            width: 34
            height: 42
            source: "minutes.png"
            transform: [
                Rotation { origin.x: 24; origin.y: 32; angle: -minutes._angle},
                Rotation { origin.x: 24-98; origin.y: 32; angle: minutes._angle},
                Translate { x: -24+98; y: -32}
            ]
            Behavior on minutesdec {
                NumberAnimation { duration: 500 }
            }
        }
        Image {
            id: hour
            x: parent.axisx-width/2
            y: parent.axisy-height/2
            width: 147
            height: 147
            source: "hours.png"
            rotation: (component.hour - 4) * -30 + component.minutes * -0.5 - 5
        }
        Image {
            x: parent.axisx-width/2
            y: parent.axisy-162
            width: 86
            height: 83
            source: "minigear.png"
            rotation: seconds.rotation * -2.4 + 1
        }
        Image {
            x: parent.axisx-30
            y: parent.axisy-133
            width: 113
            height: 183
            source: "front.png"
        }
        Image {
            id: day
            x: parent.axisx
            y: parent.axisy
            width: 63
            height: 10
            source: "day.png"
            transform: [
                Rotation { origin.x: 13; origin.y: day.height/2; angle: seconds.rotation + (component.day * 6) + 1},
                Translate { x: -13; y: -day.height/2}
            ]
        }
        Image {
            id: month
            x: parent.axisx
            y: parent.axisy
            width: 14
            height: 33
            source: "month.png"
            transform: [
                Rotation { origin.x: month.width/2; origin.y: 24; angle: hour.rotation + (component.month - 4) * 30 + 7},
                Translate { x: -month.width/2; y: -24}
            ]
        }
    }
}
