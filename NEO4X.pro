#-------------------------------------------------
#
# Project created by QtCreator 2017-02-14T19:39:05
#
#-------------------------------------------------

QT += core gui printsupport network quick charts qml
QT += serialport

INCLUDEPATH += $$_PRO_FILE_PWD_\SDL2-2.0.4\include
LIBS += -L$$_PRO_FILE_PWD_\SDL2-2.0.4\lib\x64\ -lSDL2

TARGET = NEO4X
TEMPLATE = app


SOURCES += main.cpp\

HEADERS  += \

FORMS    +=

RESOURCES += \
    resource.qrc

RC_FILE += Resource.rc

DISTFILES +=
