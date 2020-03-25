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

    Text {
        id: estado
        text: qsTr("desconectado")
        x: 483
        y: 115
        function cambiar() {
            text = qsTr("conectado");
        }
    }

    Rectangle {
        id: cuadromensajes
        width: 371
        height: 200
        x: 10
        y: 156
        color: "gray"

        Text {
            id: mensajes
            text: qsTr("text")
            x: 10
        }
    }

    ComboBox {
        id: baudRate
        x: 10
        y: 103
        width: 371
        height: 40
        model: ["prueba1","prueba2","prueba3"]
    }

    Button {
        id: conexion
        x: 444
        y: 50
        width: 149
        height: 40
        text: qsTr("conectar")
        function cambiar() {
            text = qsTr("desconectar");
        }
        onClicked: cambiar(conexion & estado);
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


}
