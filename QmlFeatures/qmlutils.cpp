#include "qmlutils.h"

QmlUtils::QmlUtils(QObject *parent):QObject(parent)
{
}

QDate QmlUtils::parseDate(QString date, QString format) const
{
    return QDate::fromString(date, format);
}
