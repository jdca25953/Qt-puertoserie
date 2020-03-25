#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QQuickItem>
#include <QtSerialPort/QSerialPortInfo>
#include <QtSerialPort/QSerialPort>
#include <QTimer>

class SerialPortInfo : public QObject, public QSerialPortInfo
{
    Q_OBJECT
    Q_PROPERTY(QStringList baudrates READ baudrates CONSTANT)
    Q_PROPERTY(QStringList availablePorts READ availablePorts NOTIFY availablePortsChanged)
    Q_PROPERTY(QString portName READ portName)


public:
    SerialPortInfo(QObject *parent = 0);
    ~SerialPortInfo();
    void inicia();
    QStringList baudrates();
signals:
    void availablePortsChanged();
    //hago un slot para ontimeout
public slots:
    void onTimeOut();
    //puntero de QTimer
private:
    QTimer *m_timer;

    QStringList availablePorts();
    //QString portName();
};

class SerialPort : QObject
{
    Q_OBJECT

public:
    SerialPort(QObject *parent=0);
    Q_INVOKABLE void setup(const QString portName, int baudRate, QString eol=QString("\n"));
    Q_INVOKABLE bool open(QFile::OpenMode mode = QIODevice::ReadWrite);
    Q_INVOKABLE void close();

private:
    QString	serialEOL;
    QSerialPort	m_serial;
};

#endif // SERIALPORT_H
