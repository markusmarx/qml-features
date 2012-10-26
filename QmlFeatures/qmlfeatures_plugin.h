#ifndef QMLFEATURES_PLUGIN_H
#define QMLFEATURES_PLUGIN_H

#include <QDeclarativeExtensionPlugin>

class QmlFeaturesPlugin : public QDeclarativeExtensionPlugin
{
    Q_OBJECT
    
public:
    void registerTypes(const char *uri);

    void initializeEngine(QDeclarativeEngine *engine, const char *uri);




};

#endif // QMLFEATURES_PLUGIN_H

