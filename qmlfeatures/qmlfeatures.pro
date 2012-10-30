TEMPLATE = lib
TARGET = QmlFeatures
QT += declarative
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = QmlFeatures

# Input
SOURCES += \
    qmlfeatures_plugin.cpp \
    myitem.cpp \
    qmlutils.cpp

HEADERS += \
    qmlfeatures_plugin.h \
    myitem.h \
    qmlutils.h

OTHER_FILES = qmldir \
    CalendarNavigation.qml \
    DatePicker.qml \
    common/utils.js \
    DateEdit.qml \
    LabelLayout.qml \
    ToolTip.qml

QML_DIRS = images common

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir

qmlfiles.files = $$OTHER_FILES
qmlfiles.sources = $$OTHER_FILES

qmldirs.files = $$QML_DIRS
qmldirs.sources = $$QML_DIRS


maemo5 | !isEmpty(MEEGO_VERSION_MAJOR) {
    installPath = /usr/lib/qt4/imports/$$replace(uri, \\., /)
} else {
    installPath = $$[QT_INSTALL_IMPORTS]/$$replace(uri, \\., /)
}
qmldir.path = $$installPath
target.path = $$installPath
qmldirs.path = $$installPath
qmlfiles.path = $$installPath
INSTALLS += target qmldir qmlfiles qmldirs


