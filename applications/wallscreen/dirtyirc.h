#ifndef DIRTYIRC_H
#define DIRTYIRC_H

#include <QObject>
#include <QTcpSocket>
#include <QAbstractListModel>

class DirtyIRC : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QAbstractListModel * model READ model CONSTANT)
public:
    explicit DirtyIRC(QObject *parent = nullptr);

    class DataModel : public QAbstractListModel {
    public:
        void addMsg(QString user, QString msg);

    private:
        int rowCount(const QModelIndex & parent = QModelIndex()) const override;
        QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;
        QHash<int, QByteArray> roleNames() const override;

        struct Message {
            QString user;
            QString msg;
        };

        QList <Message> msgs;
    };

signals:

public slots:
    QAbstractListModel * model() { return &datamodel; }
    void say(QString msg);

private slots:
    void onConnected();
    void onDisconnected();
    void onReadyRead();

private:
    QTcpSocket sock;
    void send(QByteArray data);

    DataModel datamodel;
};

#endif // DIRTYIRC_H
