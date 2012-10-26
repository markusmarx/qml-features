#ifndef QMLUTILS_H
#define QMLUTILS_H
#include <QObject>
#include <QDate>
class QmlUtils: public QObject
{
    Q_OBJECT
public:
    QmlUtils(QObject *parent=0);
    Q_INVOKABLE QDate parseDate(QString date, QString format) const;
};

#endif // QMLUTILS_H
