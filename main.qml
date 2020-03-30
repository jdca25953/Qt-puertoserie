import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    minimumWidth: 640
    minimumHeight: 440
    title: qsTr("Serial Port")
    Text {
        id: tituloserialport
        anchors.top: parent.top
        anchors.topMargin: 5
        x: 10
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
        anchors.top: puertoserie.bottom
        anchors.topMargin: 10
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
    Rectangle{
        id: cuadroconexion
        anchors.left: puertoserie.right
        anchors.right: fondomensajes.right
        anchors.top: tituloserialport.top
        anchors.bottom: baudRate.bottom
        Text {
            id: estado
            text: qsTr("Desconectado")
            horizontalAlignment: Text.AlignHCenter
            anchors.top: cuadroconexion.top
            anchors.topMargin: 20
            width: cuadroconexion.width
        }

        Button {
            id: conexion
            anchors.horizontalCenter: cuadroconexion.horizontalCenter
            anchors.bottom: cuadroconexion.bottom
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
    }
    CheckBox {
        id: estoyConectado
        checked: false
        visible: false
    }
    Rectangle {
        id: fondoentradamensaje
        anchors.left: puertoserie.left
        anchors.right: enviar.left
        anchors.top: fondomensajes.bottom
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        height: 38
        color: "#d1fcff"
        TextInput {
            id: entradamensaje
            anchors.fill: fondoentradamensaje
            text: qsTr("Text Input")
            font.pixelSize: 12
        }
    }

    Button {
        id: enviar
        text: qsTr("enviar")
        anchors.right: fondomensajes.right
        anchors.top: fondoentradamensaje.top
        width: 85
        height: 38
    }
    Rectangle{
        id:fondomensajes
        x: 10
        anchors.top: baudRate.bottom
        anchors.topMargin: 10
        z: 0
        width: Math.max(200, parent.width - 20)
        height: Math.max(250, parent.height - 190)
        color: "#bbbbbb"
        ScrollView{
            id: barrido
            z: 1
            anchors.fill: fondomensajes
            TextArea {
                id: mensajes
                anchors.fill: barrido
                text: qsTr("Esperando datos...")
                textFormat: Text.AutoText
                font.pointSize: 9
                font.family: "Courier"
            }
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
