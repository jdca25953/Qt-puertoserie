import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Serial Port")
    Text {
        id: tituloserialport
        x: 10
        y: 29
        width: 115
        height: 15
        text: qsTr("SerialPorts")
        font.pixelSize: 12
    }
    ComboBox {
        id: puertoserie        
        model: serialPortInfo.availablePorts
        anchors.top: tituloserialport.bottom
        anchors.left: tituloserialport.left
        width: 371
        height: 40
        onPressedChanged: model = serialPortInfo.availablePorts
    }
    Text {
        id: titulobaudrate
        x: 10
        y: 105
        text: qsTr("BaudRates")
        font.pixelSize: 12
    }
    ComboBox {
        id: baudRate
        anchors.top: titulobaudrate.bottom
        anchors.left: titulobaudrate.left
        width: 371
        height: 40
        model: serialPortInfo.baudrates
        currentIndex: 12 // 9600
    }

    Text {
        id: estado
        text: qsTr("Desconectado")
        x: 471
        y: 115
    }

    Button {
        id: conexion
        x: 444
        y: 50
        width: 149
        height: 40
        text: qsTr("Conectar")
        onClicked: function() {
            console.log("vamos a ello!");
            if(estoyConectado.checked){
                console.log("a desconectar");
                timerLectura.stop();
                serialPort.close();
                // toggle
                estoyConectado.checked = !estoyConectado.checked
                conexion.text = "Conectar"
                estado.text = "Desconectado"
            }else{
                console.log("a conectar");
                mensajes.text = ""
                serialPort.setup(puertoserie.currentValue, baudRate.currentValue);
                // serialPort.setOutput(mensajes);
                console.log(serialPort.open());
                console.log("en principio ya esta");
                timerLectura.start();
                // toggle
                estoyConectado.checked = !estoyConectado.checked
                conexion.text = "Desconectar"
                estado.text = "Conectado"
            }
        }
    }

    CheckBox {
        id: estoyConectado
        checked: false
        visible: false
    }
    Rectangle {
        id: fondoentradamensaje
        anchors.left: tituloserialport.left
        y: 384
        width: 371
        height: 38
        color: "#d1fcff"
        TextInput {
            id: entradamensaje
            anchors.fill: parent
            text: qsTr("Text Input")
            font.pixelSize: 12
        }
    }

    Button {
        id: enviar
        text: qsTr("enviar")
        anchors.left: fondoentradamensaje.right
        anchors.top: fondoentradamensaje.top
        width: 85
        height: 38
    }
    ScrollView{
        id: scroll
        x: 10
        y: 178
        width: 371
        height: 200
        z: 1
        TextArea {
            id: mensajes
            anchors.fill: scroll
            text: qsTr("Esperando datos...")
            textFormat: Text.AutoText
            font.pointSize: 9
            font.family: "Courier"
        }
        Rectangle {
            id: rectangle1
            width: 371
            height: 200
            color: "#bbbbbb"
            z: 0
        }
    }



    Item {
        Timer {
            id: timerLectura
            interval: 100
            running: false
            repeat: true
            onTriggered: function() {
                var texto = serialPort.read();
                console.log(texto);
                if(texto){
                    mensajes.text += texto;
                }
                // console.log(serialPort.read());
            }
        }
    }


}
