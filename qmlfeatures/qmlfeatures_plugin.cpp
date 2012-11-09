#include "qmlfeatures_plugin.h"

#include "qmlutils.h"
#include <qdeclarative.h>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>


#include "DeclarativeDragArea.h"
#include "DeclarativeDragDropEvent.h"
#include "DeclarativeDropArea.h"
#include "DeclarativeMimeData.h"

void QmlFeaturesPlugin::registerTypes(const char *uri)
{
    // @uri QmlFeatures
    //qmlRegisterType<QmlUtils>(uri, 1, 0, "QmlUtils");
    qmlRegisterType<DeclarativeDropArea>(uri, 1, 0, "DropArea");
    qmlRegisterType<DeclarativeDragArea>(uri, 1, 0, "DragArea");
    qmlRegisterUncreatableType<DeclarativeMimeData>(uri, 1, 0, "MimeData", "MimeData cannot be created from QML.");
    qmlRegisterUncreatableType<DeclarativeDragDropEvent>(uri, 1, 0, "DragDropEvent", "DragDropEvent cannot be created from QML.");

}

void QmlFeaturesPlugin::initializeEngine(QDeclarativeEngine *engine, const char *uri)
{

    engine->rootContext()->setContextProperty("QmlUtil", new QmlUtils(this));

}

Q_EXPORT_PLUGIN2(QmlFeatures, QmlFeaturesPlugin)

