#include "puertoserie.h"
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QObject>

/*serialport::serialport(QObject *parent):
    QObject(parent)
{
}
void serialport::setup(const QString portName, int baudRate, QString eol){
     m_serial.setPortName(portName);
     m_serial.setBaudRate(baudRate);
     serialEOL = eol;
}

bool serialport::open(QFile::OpenMode mode){
     return m_serial.open(mode);
 }

 void serialport::close(){
     m_serial.close();
 }


 SerialPortInfo::SerialPortInfo(QQuickItem *parent):
     QQuickItem(parent), QSerialPortInfo()
 {
    emit(SerialPortInfo::availablePorts());
 }

 SerialPortInfo::~SerialPortInfo()
 {
 }
*/
