#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QQuickItem>
#include <QtSerialPort/QSerialPortInfo>
#include <QtSerialPort/QSerialPort>

class SerialPortInfo : public QObject, public QSerialPortInfo
{
    Q_OBJECT
    Q_PROPERTY(QStringList baudrates READ baudrates CONSTANT)
    Q_PROPERTY(QStringList availablePorts READ availablePorts NOTIFY availablePortsChanged)
    Q_PROPERTY(QString portName READ portName)

signals:
    void availablePortsChanged();

public:
    SerialPortInfo(QObject *parent = 0);
    ~SerialPortInfo();
    QStringList baudrates();
    QStringList availablePorts();
};

// -------------------------

class SerialPort : public QObject
{
    Q_OBJECT

public:
    SerialPort(QObject *parent=0);
    Q_INVOKABLE void setup(const QString portName, int baudRate, QString eol=QString("\n"));
    Q_INVOKABLE bool open(QFile::OpenMode mode = QIODevice::ReadWrite);
    Q_INVOKABLE void close();
    Q_INVOKABLE int read(char )

private:
    QString	serialEOL;
    QSerialPort	m_serial;
};

#endif // SERIALPORT_H
