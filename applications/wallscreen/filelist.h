#ifndef FILELIST_H
#define FILELIST_H

#include <QObject>
#include <QStringList>
#include <QDir>

class FileList : public QObject {
    Q_OBJECT

    Q_PROPERTY(QStringList files READ files NOTIFY filesChanged)
    Q_PROPERTY(QString directory READ directory WRITE setDirectory NOTIFY directoryChanged)
    Q_PROPERTY(int count READ count NOTIFY filesChanged)

signals:
    void filesChanged();
    void directoryChanged();

public:
    FileList(QObject * parent = nullptr);

public slots:
    QStringList files();
    int count();
    QString directory();
    void setDirectory(QString path);

private:
    QDir dir;
    int countfiles;
};

#endif // FILELIST_H
