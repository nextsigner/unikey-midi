import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent
    focus: true

    // El objeto 'teclado' y 'log' deben existir en el padre o globalmente
    // KeyNavigation.tab: selectorInstrumentos.cbInstrumentos

    readonly property var activeKeys: ({})

    // --- CONFIGURACIÓN DE MAPEO ---
    // Empezamos con 'q' = 41.
    // He organizado las teclas QWERTY de izquierda a derecha por filas.
    property var aTeclas: [
        // Fila Superior (Letras)
        'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p',
        // Fila Media (Letras)
        'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'ñ',
        // Fila Inferior (Letras)
        'z', 'x', 'c', 'v', 'b', 'n', 'm', ',', '.', '-',
        // Fila Números (Opcional, para notas más agudas)
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'
    ]

    property var aCodes: [
        // Asignación de notas MIDI correlativas
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, // q..p (41 a 50)
        51, 52, 53, 54, 55, 56, 57, 58, 59, 60, // a..ñ (51 a 60)
        61, 62, 63, 64, 65, 66, 67, 68, 69, 70, // z..- (61 a 70)
        71, 72, 73, 74, 75, 76, 77, 78, 79, 80  // 1..0 (71 a 80)
    ]

    Keys.onPressed: {
        var keyId = event.key;

        // Filtro de teclas especiales del sistema
        if (keyId === Qt.Key_Tab || keyId === Qt.Key_CapsLock) {
            event.accepted = false;
            return;
        }

        if (event.isAutoRepeat) {
            event.accepted = true;
            return;
        }

        if (activeKeys[keyId]) {
            event.accepted = true;
            return;
        }

        // Procesar solo si no hay modificadores (para no interferir con Shortcuts)
        if (!(event.modifiers & (Qt.ControlModifier | Qt.ShiftModifier | Qt.AltModifier))) {
            activeKeys[keyId] = true;
            procesarTecla(event.text, 1);
            event.accepted = true;
        }
    }

    Keys.onReleased: {
        var keyId = event.key;

        if (event.isAutoRepeat) {
            event.accepted = true;
            return;
        }

        if (activeKeys[keyId]) {
            procesarTecla(event.text, 0);
            delete activeKeys[keyId];
            event.accepted = true;
        }
    }

    function procesarTecla(c, t) {
        let canal
        if (!c) return; // Evitar error con teclas sin texto

        var charLower = c.toLowerCase();
        var index = aTeclas.indexOf(charLower);

        if (index !== -1) {
            var midiNote = aCodes[index];
            // Usamos el índice de la tecla como 'id de canal' o identificador
            if (t === 1) {
                canal=apps.todoEnCanalCero?0:index
                teclado.noteOn(canal, midiNote, 100);
                if (typeof log !== 'undefined') log.text += "Note ON: " + charLower + " -> MIDI: " + midiNote + "\n";
            } else {
                canal=apps.todoEnCanalCero?0:index
                teclado.noteOff(canal, midiNote, 0);
                if (typeof log !== 'undefined') log.text += "Note OFF: " + charLower + " -> MIDI: " + midiNote + "\n";
            }
        }
    }
}
