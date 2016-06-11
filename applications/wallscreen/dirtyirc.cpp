#include "dirtyirc.h"

DirtyIRC::DirtyIRC(QObject *parent) : QObject(parent)
{
    QObject::connect(&sock, &QTcpSocket::connected, this, &DirtyIRC::onConnected);
    QObject::connect(&sock, &QTcpSocket::disconnected, this, &DirtyIRC::onDisconnected);
    QObject::connect(&sock, &QTcpSocket::readyRead, this, &DirtyIRC::onReadyRead);
    sock.connectToHost("irc.freenode.org", 6667);
    qDebug() << "DirtyIRC = connect";
}

void DirtyIRC::say(QString msg) {
    send(("PRIVMSG #haum :" + msg).toLocal8Bit());
}

void DirtyIRC::send(QByteArray data) {
    QByteArray sentdata = data + "\r\n";
    sock.write(sentdata);
    qDebug() << "DirtyIRC >" << sentdata;
}

void DirtyIRC::onConnected() {
    qDebug() << "DirtyIRC = connected";
    send("NICK wallscreen");
    send("USER wallscreen 8 *  : wallscreen bot");
    send("JOIN #haum");
}

void DirtyIRC::onDisconnected() {
    qDebug() << "DirtyIRC = disconnected";
}

void DirtyIRC::onReadyRead() {
    while (true) {
        QString line = sock.readLine();
        if (line == "") break;
        qDebug() << "DirtyIRC <" << line;

        if (line.startsWith("PING :")) {
            send(("PONG :" + line.remove(0,6).trimmed()).toLocal8Bit());
        } else if (line.contains("PRIVMSG #haum :")) {
            QString user = line.split("!")[0].remove(0,1);
            QString msg = line.split("PRIVMSG #haum :")[1].trimmed();
            msg.replace("wallscreen", "<font color=\"red\">wallscreen</font>");
            if (msg != "" && msg.at(0) == '\u0001') {
                msg = "<b>" + user + "</b>" + msg.remove(msg.length()-1, 1).remove(0,7);
                user = "*";
            }
            datamodel.addMsg(user, msg);
        } else if (line.contains("PRIVMSG wallscreen :")) {
            QString user = line.split("!")[0].remove(0,1);
            QString msg = line.split("PRIVMSG wallscreen :")[1].trimmed();
            if (msg != "" && msg.at(0) == '\u0001') {
                msg = msg.remove(msg.length()-1, 1).remove(0,7);
                say(msg);
            }
        }
    }
}

void DirtyIRC::DataModel::addMsg(QString user, QString msg) {
    beginInsertRows(QModelIndex(), 0, 0);
    Message m {user, msg};
    msgs.prepend(m);
    endInsertRows();

    if (msgs.length() > 20) {
        int toberemoved = msgs.length() - 20;
        beginRemoveRows(QModelIndex(), 20, msgs.length());
        for (int i = 0; i < toberemoved; ++i)
            msgs.removeAt(20);
        endRemoveRows();
    }
}

int DirtyIRC::DataModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent)
    return msgs.length();
}

QVariant DirtyIRC::DataModel::data(const QModelIndex & index, int role) const {
    if (role == Qt::UserRole) {
        return msgs[index.row()].user;
    } else if (role == Qt::UserRole + 1) {
        return msgs[index.row()].msg;
    }
    return QVariant();
}

QHash<int, QByteArray> DirtyIRC::DataModel::roleNames() const {
    QHash<int, QByteArray> ret;
    ret[Qt::UserRole] = "user";
    ret[Qt::UserRole + 1] = "msg";
    return ret;
}
