import QtQuick 2.0

Rectangle{
    id: r
    width: parent.width
    height: 200
    Row {
        id: whiteKeysRow
        anchors.fill: parent
        Repeater {
            model: totalKeys
            delegate: Rectangle {
                // Solo creamos el rectángulo si la nota NO es negra
                visible: !isBlackKey(startNote + index)
                width: visible ? r.width / 29 : 0 // 26 blancas en total
                height: r.height
                color: mouseAreaWhite.pressed ? "#ddd" : "white"
                border.color: "black"
                border.width: 1
                Rectangle{
                    id: rToque
                    color: 'red'
                    anchors.fill: parent
                    visible: false
                    Behavior on opacity {NumberAnimation{duration: 200}}
                    onVisibleChanged: {
                        if(visible)opacity=0.0
                    }
                    onOpacityChanged: {
                        if(opacity===0.0){
                            visible=false
                            opacity=1.0
                        }
                    }
                }
                Text{
                    text:  ''+parseInt(startNote+index)
                    font.pixelSize: parent.width*0.8
                    color: 'red'
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                MouseArea {
                    id: mouseAreaWhite
                    hoverEnabled: true
                    anchors.fill: parent
                    onEntered: pres()
                    onExited: rele()
                    onPressed: {
                        pres()
                    }
                    onReleased: {
                        rele()
                    }
                    function pres(){
                        let note = startNote + index
                        let canal=apps.todoEnCanalCero?0:index
                        showToqueNote(note)
                        uqp.runWrite('noteon '+canal+' ' + note + ' 100')
                    }
                    function rele(){
                        let note = startNote + index
                        let canal=apps.todoEnCanalCero?0:index
                        uqp.runWrite('noteoff '+canal+' ' + note + ' 0')
                    }
                }
                function toque(){
                    rToque.visible=true
                }
            }
        }
    }
    // --- TECLAS NEGRAS ---
    // Se dibujan encima de las blancas
    Item {
        id: blackKeysContainer
        anchors.fill: parent

        Repeater {
            model: totalKeys
            delegate: Item {
                // Solo mostramos si es nota negra
                property int code: startNote+index
                readonly property bool isBlack: isBlackKey(startNote + index)
                visible: isBlack

                // Calculamos la posición X basada en la tecla blanca anterior
                // Este es un cálculo simplificado para que coincidan en los huecos
                x: (index_of_white_before * (r.width / 29)) - (width / 2)

                // Propiedad personalizada para calcular la posición X real
                // Contamos cuántas blancas hay antes de esta nota para posicionarla
                property int index_of_white_before: {
                    var count = 0;
                    for(var i = 0; i < index; i++) {
                        if(!isBlackKey(startNote + i)) count++;
                    }
                    return count;
                }

                width: r.width / 49
                height: r.height * 0.6

                Rectangle {
                    anchors.fill: parent
                    color: mouseAreaBlack.pressed ? "#555" : "black"
                    radius: 2
                }
                Rectangle{
                    id: rToqueNegra
                    color: 'yellow'
                    anchors.fill: parent
                    visible: false
                    Behavior on opacity {NumberAnimation{duration: 200}}
                    onVisibleChanged: {
                        if(visible)opacity=0.0
                    }
                    onOpacityChanged: {
                        if(opacity===0.0){
                            visible=false
                            opacity=1.0
                        }
                    }
                }
                Text{
                    text:  ''+parseInt(startNote+index)
                    font.pixelSize: parent.width*0.8
                    color: 'red'
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    id: mouseAreaBlack
                    hoverEnabled: true
                    anchors.fill: parent
                    onEntered: pres()
                    onExited: rele()
                    onPressed: {
                        pres()
                    }
                    onReleased: {
                        rele()
                    }
                    function pres(){
                        let note = startNote + index
                        let canal=apps.todoEnCanalCero?0:index
                        showToqueBlack(note)
                        uqp.runWrite('noteon '+canal+' ' + note + ' 100')
                    }
                    function rele(){
                        let note = startNote + index
                        let canal=apps.todoEnCanalCero?0:index
                        uqp.runWrite('noteoff '+canal+' ' + note + ' 0')
                    }
                }
                function toque(){
                    //log.text+='Activo!\n'
                    rToqueNegra.visible=true//!rToqueNegra.visible
                }
            }
        }
    }
    /*Timer{
        running: true
        repeat: true
        interval: 1000
        onTriggered: {

            //log.text+='Index: '+getTeclaIndex(42, 1)+'\n'
            //showToque(0, 1)
            //showToqueBlack(42)
        }
    }*/
    function noteOn(canal, codigo, volumen){
        showToqueNote(codigo)
        showToqueBlack(codigo)
        uqp.runWrite('noteon '+canal+' '+codigo+' '+volumen+'')
    }
    function noteOff(canal, codigo, volumen){
        uqp.runWrite('noteoff '+canal+' '+codigo+' '+volumen+'')
    }
    function showToqueNote(code){
        showToque(getTeclaIndex(code))
    }
    function showToque(index){
        let t=whiteKeysRow.children[index]
        t.toque()

    }
    function showToqueBlack(code){
        for(var i=0;i<44;i++){
            let t=blackKeysContainer.children[i]
            //log.text+='Code Black: '+t.code+'\n'
            if(t.code===code){
                t.toque()
                //t.visible=!t.visible
                return
            }
        }
    }
    function getTeclaIndex(code){
        let ret=-1
        for(var i=0;i<app.totalKeys;i++){
            let t=whiteKeysRow.children[i]
            //log.text+='     t.code: '+t.code+'\n'
            if(code===app.startNote+i){
                return i
            }
        }
        return ret
    }
}
