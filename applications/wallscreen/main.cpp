#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "filelist.h"
#include "dirtyirc.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType <FileList> ("HaumWallScreen", 1, 0, "FileList");
    qmlRegisterType <DirtyIRC> ("HaumWallScreen", 1, 0, "DirtyIRC");

    QQmlApplicationEngine engine;
    engine.load("qml/main.qml");

    return app.exec();
}
