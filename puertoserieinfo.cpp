#include "puertoserie.h"

SerialPortInfo::SerialPortInfo(QObject *parent):
    QObject(parent), QSerialPortInfo()
{

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
