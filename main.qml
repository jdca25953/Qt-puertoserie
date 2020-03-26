import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Serial Port")

    Rectangle {
        id: rectangle
        x: 10
        y: 384
        width: 371
        height: 38
        color: "#d1fcff"
    }

    ComboBox {
        id: puertoserie        
        model: serialPortInfo.availablePorts
        width: 371
        height: 40
        x: 10
        y: 50
        onPressedChanged: model = serialPortInfo.availablePorts
    }

    ComboBox {
        id: baudRate
        x: 10
        y: 126
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

    TextInput {
        id: entradamensaje
        x: 10
        y: 384
        width: 371
        height: 38
        text: qsTr("Text Input")
        font.pixelSize: 12
    }

    Button {
        id: enviar
        text: qsTr("enviar")
        x: 387
        y: 384
        width: 85
        height: 38
    }

    Text {
        id: element
        x: 10
        y: 29
        width: 115
        height: 15
        text: qsTr("SerialPorts")
        font.pixelSize: 12
    }

    Text {
        id: element1
        x: 10
        y: 105
        text: qsTr("BaudRates")
        font.pixelSize: 12
    }

    TextArea {
        id: mensajes
        x: 10
        y: 178
        width: 371
        height: 200
        text: qsTr("Esperando datos...")
        z: 1
        font.pointSize: 9
        font.family: "Courier"
    }

    Rectangle {
        id: rectangle1
        x: 10
        y: 178
        width: 371
        height: 200
        color: "#bbbbbb"
        z: 0
    }


}
