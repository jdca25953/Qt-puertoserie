#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QQuickItem>
#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QObject>
#include <QTimer>

class Qtimer;
/*class serialport : QObject
{
    Q_OBJECT

public:
    serialport(QObject *parent = 0);

    Q_INVOKABLE void setup(const QString portName, int baudRate, QString eol=QString("\n"));
    Q_INVOKABLE bool open(QFile::OpenMode mode = QIODevice::ReadWrite);
    Q_INVOKABLE void close();

    signals:

    public slots:

    private:
        QString	serialEOL;
        QSerialPort	m_serial;

};
*/
class SerialPortInfo : public QObject, public QSerialPortInfo
{
    Q_OBJECT
    //Q_PROPERTY(QList<int> baudrates READ baudrates CONSTANT)
    Q_PROPERTY(QStringList availablePorts READ availablePorts NOTIFY availablePortsChanged)
    Q_PROPERTY(QString portName READ portName)


public:
        SerialPortInfo(QObject *parent = 0);
        ~SerialPortInfo();
        void inicia();
signals:
        void availablePortsChanged();
    //hago un slot para ontimeout
public slots:
    void onTimeOut();
    //puntero de QTimer
    private:
        QTimer *m_timer;

    QStringList availablePorts();
    //QList<int> baudrates();
    //QString portName();
};

#endif // SERIALPORT_H
