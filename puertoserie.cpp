#include "puertoserie.h"

SerialPort::SerialPort(QObject *parent):
    QObject(parent)
{

}
/*
 * portName: nombre del puerto serie del sistema
 * baudRate: velocidad en bits de conexión al puerto serie
 * eol: carácter de salto del línea
 */
void SerialPort::setup(const QString portName, int baudRate, QString eol){
     m_serial.setPortName(portName);
     m_serial.setBaudRate(baudRate);
     serialEOL = eol;
}

bool SerialPort::open(QFile::OpenMode mode){
    return m_serial.open(mode);
}

void SerialPort::close(){
     m_serial.close();
 }
