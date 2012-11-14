#include "qmlutils.h"

QmlUtils::QmlUtils(QObject *parent):QObject(parent)
{
}

QDate QmlUtils::parseDate(QString date, QString format) const
{
    return QDate::fromString(date, format);
}

QDateTime QmlUtils::parseTime(QString time, QString format) const
{
    return QDateTime::fromString(time, format);
}

bool QmlUtils::isValidDateTime(QVariant time) const
{
    return time.isValid() && time.type() == QVariant::DateTime;
}

QDateTime QmlUtils::join(QDate date, QTime time) const
{

    return QDateTime(date, time);
}
