import QtQuick 2.0

Image {
    id: component
    property string img: ""

    source: img ? "badge_" + img + ".png" : ""
    fillMode: Image.PreserveAspectFit

    Timer {
        id: xhrloader
        function reload_status() {
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4) {
                    if (xhr.status == 200) {
                        var json = JSON.parse(xhr.responseText)
                        component.img = json.state.open ? "open" : "close"
                    }
                    xhrloader.start();
                }
            };
            xhr.open("GET", "http://spaceapi.net/new/space/haum/status/json", true);
            xhr.send();
        }
        interval: 30*1000
        running: false
        repeat: false
        onTriggered: reload_status()
        Component.onCompleted: reload_status()
    }
}
