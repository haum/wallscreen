TEMPLATE = app

QT += qml quick
CONFIG += c++11

HEADERS += \
    filelist.h \
    dirtyirc.h

SOURCES += \
    main.cpp \
    filelist.cpp \
    dirtyirc.cpp

OTHER_FILES = qml/*.qml

resources.path = $$OUT_PWD
resources.files = qml haum.png

INSTALLS += resources
