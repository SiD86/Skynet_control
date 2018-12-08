#-------------------------------------------------
#
# Project created by QtCreator 2017-02-14T19:39:05
#
#-------------------------------------------------

QT += core gui printsupport network quick charts qml
QT += serialport

TARGET = NEO4X
TEMPLATE = app


SOURCES += main.cpp\
    core.cpp \
    wirelesscontroller.cpp

HEADERS  += \
    core.h \
    wirelesscontroller.h \
    wireless_protocol.h

FORMS    +=

RESOURCES += \
    resource.qrc

RC_FILE += Resource.rc

DISTFILES +=
