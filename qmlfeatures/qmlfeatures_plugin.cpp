#include "qmlfeatures_plugin.h"

#include "qmlutils.h"
#include <qdeclarative.h>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>

void QmlFeaturesPlugin::registerTypes(const char *uri)
{
    // @uri QmlFeatures
    qmlRegisterType<QmlUtils>(uri, 1, 0, "QmlUtils");


}

void QmlFeaturesPlugin::initializeEngine(QDeclarativeEngine *engine, const char *uri)
{

    engine->rootContext()->setContextProperty("QmlUtil", new QmlUtils(this));

}

Q_EXPORT_PLUGIN2(QmlFeatures, QmlFeaturesPlugin)

