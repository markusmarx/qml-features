#ifndef MYITEM_H
#define MYITEM_H

#include <QDeclarativeItem>

class MyItem : public QDeclarativeItem
{
    Q_OBJECT
    Q_DISABLE_COPY(MyItem)
    
public:
    MyItem(QDeclarativeItem *parent = 0);
    ~MyItem();
};

QML_DECLARE_TYPE(MyItem)

#endif // MYITEM_H

