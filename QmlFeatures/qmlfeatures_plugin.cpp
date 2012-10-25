#include "qmlfeatures_plugin.h"

#include "qmlutils.h"
#include <qdeclarative.h>

void QmlFeaturesPlugin::registerTypes(const char *uri)
{
    // @uri QmlFeatures
    qmlRegisterUncreatableType<QmlUtils>(uri, 1, 0, "QmlUtils", QObject::tr("Cannot create seperate instance of QmlUtils."));

}

Q_EXPORT_PLUGIN2(QmlFeatures, QmlFeaturesPlugin)

