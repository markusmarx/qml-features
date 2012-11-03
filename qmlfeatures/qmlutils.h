#ifndef QMLUTILS_H
#define QMLUTILS_H
#include <QObject>
#include <QDate>
#include <QTime>
#include <QVariant>
class QmlUtils: public QObject
{
    Q_OBJECT
public:
    QmlUtils(QObject *parent=0);
    Q_INVOKABLE QDate parseDate(QString date, QString format) const;
    Q_INVOKABLE QDateTime parseTime(QString time, QString format) const;
    Q_INVOKABLE bool isValidDateTime(QVariant time) const;
};

#endif // QMLUTILS_H
