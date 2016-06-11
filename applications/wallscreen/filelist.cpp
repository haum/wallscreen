#include "filelist.h"
#include <qdebug.h>

FileList::FileList(QObject * parent) : QObject(parent), dir{"."}
{
}

QStringList FileList::files() {
    QStringList ret;

    if (!dir.exists())
        return ret;

    QFlags <QDir::Filter> filter = 0;
    filter = QDir::NoDotAndDotDot | QDir::Files;
    QFileInfoList entries = dir.entryInfoList(filter);

    countfiles = 0;
    for (QFileInfo entryInfo : entries) {
        QString path = entryInfo.absoluteFilePath();
        countfiles++;
        ret << path;
    }

    return ret;
}

int FileList::count() {
    return countfiles;
}

QString FileList::directory() {
    return dir.path();
}

void FileList::setDirectory(QString path) {
    if (path != dir.path()) {
        dir.setPath(path);
        emit directoryChanged();
        emit filesChanged();
    }
}
