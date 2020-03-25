#include "puertoserie.h"

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

//crea la lista de baudrates como string

QStringList	SerialPortInfo::baudrates(){
    QStringList r = QStringList();
    foreach (const int baudrate, QSerialPortInfo::standardBaudRates()){
        r.append(QString::number(baudrate));
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
