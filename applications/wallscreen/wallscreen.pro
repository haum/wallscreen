TEMPLATE = app

QT += qml quick
CONFIG += c++11

SOURCES += main.cpp

OTHER_FILES = qml/*.qml

resources.path = $$OUT_PWD
resources.files = qml haum.png

INSTALLS += resources
