#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtSerialPort/QtSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QObject>
#include <QQmlContext>
#include <QTimer>
#include "puertoserie.h"

QT_USE_NAMESPACE

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    //revisar, funciona
    SerialPortInfo serialPortInfo;
    //inicio del timer
    serialPortInfo.inicia();
    engine.rootContext()->setContextProperty("serialPortInfo", &serialPortInfo);

    engine.load(url);

    return app.exec();
}

SerialPortInfo::SerialPortInfo(QObject *parent):
    QObject(parent), QSerialPortInfo()
{
   //intento de hacer un Qtimer

   m_timer = new QTimer(this);
   connect(m_timer, SIGNAL(timeout()),this,SLOT(onTimeOut()));


   //emit availablePortsChanged();
}

SerialPortInfo::~SerialPortInfo()
{
}

//crea la lista de los nombres de los puertos

QStringList	SerialPortInfo::availablePorts(){
    QStringList r = QStringList();
    foreach (const QSerialPortInfo &port, QSerialPortInfo::availablePorts()){
        QString rt = QString(port.portName());
        r.append(rt);
    }
    return r;
}

//que hacer cuando se acabe el tiempo, yo creo que actualiza asi

void SerialPortInfo::onTimeOut()
{
   availablePorts();
}
//control de inicio desde la app
void SerialPortInfo::inicia(){
    m_timer->start(3000);
}




