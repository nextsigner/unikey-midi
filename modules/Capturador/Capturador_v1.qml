import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent
    focus: true
    KeyNavigation.tab: selectorInstrumentos.cbInstrumentos

    // Registro de teclas para evitar duplicados
    readonly property var activeKeys: ({})

    // Mapeo de teclas y códigos
    property var aTeclas: ['<', 'z', 'x', 'f', 'd', 's', 'a', 'q', 'w', 'e', '4', '3', '2', '1']
    property var aCodes: [60, 62, 64, 65, 67, 69, 71, 72, 74, 76, 77, 79, 81, 83]

    Keys.onPressed: {
        // 1. FILTRO ANTIRREPETICIÓN (Hardware/OS auto-repeat)
        var keyId = event.key;

        log.text+='Tecla : PRESIONADA ['+event.text+'] keyId: '+keyId+'\n'
        //Tecla Tab
        if(keyId===16777217){
          log.text+='Se presionó el Tabulador: '+keyId+'\n'
            event.accepted = false;
            return
        }
        //Tecla Mayus
        if(keyId===16777252){
          log.text+='Se presionó la tecla Mayúscula: '+keyId+'\n'
            event.accepted = false;
            return
        }

        if (event.isAutoRepeat) {
            event.accepted = true;
            return;
        }

        // 2. VERIFICACIÓN DE ESTADO (Evita NoteOn si ya está activa)
        if (activeKeys[keyId]) {
            event.accepted = true;
            return;
        }

        // 3. LÓGICA DE FILTRADO DE MODIFICADORES
        // Solo procesamos si NO hay Ctrl, Shift o Alt presionados
        if (!(event.modifiers & (Qt.ControlModifier | Qt.ShiftModifier | Qt.AltModifier))) {

            // Registramos que la tecla está presionada
            activeKeys[keyId] = true;

            // EJECUTAMOS LA NOTA
            procesarTecla(event.text, 1);

            // Marcamos como aceptado para anular Shortcuts globales
            event.accepted = true;
        } else {
            // Si hay modificadores, permitimos que el evento siga hacia los Shortcuts
            event.accepted = false;
        }
    }

    Keys.onReleased: {
        // 1. Ignorar si es un auto-repeat del sistema (algunos OS lo envían en el release)


        var keyId = event.key;

        log.text+='Tecla : PRESIONADA ['+event.text+'] keyId: '+keyId+'\n'
        //Tecla Tab
        if(keyId===16777217){
          log.text+='Se presionó el Tabulador: '+keyId+'\n'
            event.accepted = false;
            return
        }
        //Tecla Mayus
        if(keyId===16777252){
          log.text+='Se presionó la tecla Mayúscula: '+keyId+'\n'
            event.accepted = false;
            return
        }

        if (event.isAutoRepeat) {
            event.accepted = true;
            return;
        }

        // 2. Si la tecla estaba en nuestro registro, la liberamos
        if (activeKeys[keyId]) {

            // ENVIAR NOTE OFF
            procesarTecla(event.text, 0);

            // Limpiar registro
            delete activeKeys[keyId];

            event.accepted = true;
        }
    }

    function procesarTecla(c, t) {
        //log.text+='procesarTecla()... '+c.toLowerCase()+'\n'
        var index = aTeclas.indexOf(c.toLowerCase());
        if (index !== -1) {
            if (t === 1) {
                teclado.noteOn(index, aCodes[index], 100);
                console.log("Note ON:", c, "Midi:", aCodes[index]);
            } else {
                teclado.noteOff(index, aCodes[index], 100);
                console.log("Note OFF:", c, "Midi:", aCodes[index]);
            }
        }
    }
}
