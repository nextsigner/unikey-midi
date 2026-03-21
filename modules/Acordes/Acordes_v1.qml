import QtQuick 2.12

Item {
    id: r

    // Referencia al proceso de audio que pasarás desde el main
    property var engine: uqp

    // --- FUNCIONES INTERNAS ---

    function playNote(note) {
        if (engine) engine.runWrite('noteon 0 ' + note + ' 80')
    }

    function stopNote(note) {
        if (engine) engine.runWrite('noteoff 0 ' + note + ' 0')
    }

    // --- ACORDES ---

    // Toca un acorde dado el tono base y el tipo
    // tipo: "M" (Mayor), "m" (Menor), "7" (Sétima)
    function playAcorde(root, tipo) {
        playNote(root); // Tónica

        if (tipo === "M") {
            playNote(root + 4); // Tercera mayor
            playNote(root + 7); // Quinta
        } else if (tipo === "m") {
            playNote(root + 3); // Tercera menor
            playNote(root + 7); // Quinta
        } else if (tipo === "7") {
            playNote(root + 4); // Tercera mayor
            playNote(root + 7); // Quinta
            playNote(root + 10); // Sétima menor
        }
    }

    function stopAcorde(root, tipo) {
        stopNote(root);
        if (tipo === "M") {
            stopNote(root + 4);
            stopNote(root + 7);
        } else if (tipo === "m") {
            stopNote(root + 3);
            stopNote(root + 7);
        } else if (tipo === "7") {
            stopNote(root + 4);
            stopNote(root + 7);
            stopNote(root + 10);
        }
    }

    // Función rápida para apagar todo (Panic button)
    function allNotesOff() {
        if (engine) engine.runWrite('alloff')
    }
}
