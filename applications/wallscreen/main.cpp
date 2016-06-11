#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "filelist.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType <FileList> ("HaumWallScreen", 1, 0, "FileList");

    QQmlApplicationEngine engine;
    engine.load("qml/main.qml");

    return app.exec();
}
