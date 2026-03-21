import QtQuick 2.12
import unik.UnikQProcess 1.0

Item {
    id: song

    // ────────────────────────────────────────────────
    //          CONFIGURACIÓN GLOBAL
    // ────────────────────────────────────────────────
    property UnikQProcess synth
    property int channel: 0
    property int velocity: 90

    // Tempo (puedes cambiarlo en cualquier momento)
    property real bpm: 100
    readonly property real beatMs: 60000 / bpm   // milisegundos por negra (1 beat)

    // Notas (en minúscula como las pusiste tú)
    // Octava 2 (la más baja en la mayoría de teclados 49 teclas)
    readonly property int do2:   36     // C2
    readonly property int doS2:  37     // C#2 / Db2
    readonly property int re2:   38     // D2
    readonly property int reS2:  39     // D#2 / Eb2
    readonly property int mi2:   40     // E2
    readonly property int fa2:   41     // F2
    readonly property int faS2:  42     // F#2 / Gb2
    readonly property int sol2:  43     // G2
    readonly property int solS2: 44     // G#2 / Ab2
    readonly property int la2:   45     // A2
    readonly property int laS2:  46     // A#2 / Bb2
    readonly property int si2:   47     // B2

    // Octava 3
    readonly property int do3:   48     // C3
    readonly property int doS3:  49     // C#3 / Db3
    readonly property int re3:   50     // D3
    readonly property int reS3:  51     // D#3 / Eb3
    readonly property int mi3:   52     // E3
    readonly property int fa3:   53     // F3
    readonly property int faS3:  54     // F#3 / Gb3
    readonly property int sol3:  55     // G3
    readonly property int solS3: 56     // G#3 / Ab3
    readonly property int la3:   57     // A3
    readonly property int laS3:  58     // A#3 / Bb3
    readonly property int si3:   59     // B3

    // Octava 4 (do4 es tu Do central)
    readonly property int do4:   60     // C4 (Middle C)
    readonly property int doS4:  61     // C#4 / Db4
    readonly property int re4:   62     // D4
    readonly property int reS4:  63     // D#4 / Eb4
    readonly property int mi4:   64     // E4
    readonly property int fa4:   65     // F4
    readonly property int faS4:  66     // F#4 / Gb4
    readonly property int sol4:  67     // G4
    readonly property int solS4: 68     // G#4 / Ab4
    readonly property int la4:   69     // A4 (La de referencia 440 Hz)
    readonly property int laS4:  70     // A#4 / Bb4
    readonly property int si4:   71     // B4

    // Octava 5
    readonly property int do5:   72     // C5
    readonly property int doS5:  73     // C#5 / Db5
    readonly property int re5:   74     // D5
    readonly property int reS5:  75     // D#5 / Eb5
    readonly property int mi5:   76     // E5
    readonly property int fa5:   77     // F5
    readonly property int faS5:  78     // F#5 / Gb5
    readonly property int sol5:  79     // G5
    readonly property int solS5: 80     // G#5 / Ab5
    readonly property int la5:   81     // A5
    readonly property int laS5:  82     // A#5 / Bb5
    readonly property int si5:   83     // B5

    // Octava 6 (la nota más alta en teclados 49 teclas estándar)
    readonly property int do6:   84     // C6

    // ────────────────────────────────────────────────
    //          PARTITURA / SECUENCIA (modo secuencial)
    // ────────────────────────────────────────────────
    property var sequence: [
        // Ejemplo con duraciones en beats (más legible)
        {note: do4,  beats: 1},
        {note: re4,  beats: 0.5},
        {note: mi4,  beats: 0.5},
        {note: fa4,  beats: 1},
        {note: sol4, beats: 1},

        // Arpegio de ejemplo usando la función
        function() { arpeggioUp(do4, 3, 0.25) },   // ← se ejecuta al llegar aquí

        {notes: [do4, mi4, sol4, si4], beats: 2},  // Dm7
        {notes: [re4, fa4, la4, do5],  beats: 2},  // G7

        // Puedes mezclar con tiempos absolutos más abajo
    ]

    // ────────────────────────────────────────────────
    //          MODO TIEMPO ABSOLUTO (timeline)
    // ────────────────────────────────────────────────
    // Si quieres usar tiempo absoluto en vez de secuencial,
    // comenta la propiedad "sequence" de arriba y descomenta esto:
     /*property var timeline: [
         {time: 0.0,   notes: [do4, mi4, sol4]},     // beat 0
         {time: 2.0,   note:  la4,   beats: 1},
         {time: 4.0,   notes: [do5, fa5, la5], beats: 2},
         {time: 8.0,   function() { arpeggioDown(sol4, 4, 0.125) }},
     ]*/
    property var timeline: [
        // "Feliz cum-ple-a-ños"
        {time: 0.0,   notes: [do4, do4]},           // Fe-liz     (dos corcheas)
        {time: 1.0,   note:  re4,    beats: 1},     // cum-
        {time: 2.0,   note:  do4,    beats: 1},     // ple-
        {time: 3.0,   note:  fa4,    beats: 1},     // a-
        {time: 4.0,   note:  mi4,    beats: 2},     // ños     (más larga)

        // "Fe-liz cum-ple-a-ños"
        {time: 6.0,   notes: [do4, do4]},           // Fe-liz
        {time: 7.0,   note:  re4,    beats: 1},
        {time: 8.0,   note:  do4,    beats: 1},
        {time: 9.0,   note:  sol4,   beats: 1},
        {time: 10.0,  note:  fa4,    beats: 2},

        // "Fe-liz cum-ple-a-ños que-rí-do/a [nombre]"
        {time: 12.0,  notes: [do4, do4]},           // Fe-liz
        {time: 13.0,  note:  do5,    beats: 1},     // cum-
        {time: 14.0,  note:  la4,    beats: 1},     // ple-
        {time: 15.0,  note:  fa4,    beats: 1},     // a-
        {time: 16.0,  note:  mi4,    beats: 1},     // ños
        {time: 17.0,  note:  re4,    beats: 2},     // que-ri-do/a...

        // "Fe-liz cum-ple-a-ños [nombre]"
        {time: 19.0,  notes: [si4, si4]},           // Fe-liz     (aquí suele bajar a Si♭ en algunas versiones, pero usamos si4 para mantener Do mayor)
        {time: 20.0,  note:  la4,    beats: 1},
        {time: 21.0,  note:  fa4,    beats: 1},
        {time: 22.0,  note:  sol4,   beats: 1},
        {time: 23.0,  note:  fa4,    beats: 3}      // ños... (final larga)
    ]

    // ────────────────────────────────────────────────
    //          CONTROL DE REPRODUCCIÓN
    // ────────────────────────────────────────────────
    property int seqIndex: 0
    property real startTime: 0      // para modo absoluto (en ms)

    function play() {
        seqIndex = 0
        startTime = new Date().getTime()
        if (timeline !== undefined && timeline.length > 0) {
            playTimeline()
        } else {
            playNextSequence()
        }
    }

    // ─── MODO SECUENCIAL ───────────────────────────────────────
    function playNextSequence() {
        if (seqIndex >= sequence.length) {
            console.log("Secuencia terminada")
            return
        }

        var step = sequence[seqIndex]

        // Si es una función → la ejecutamos (arpegios, loops, etc.)
        if (typeof step === "function") {
            step()
            seqIndex++
            scheduleNext(0.5) // pequeño avance para no trabar
            return
        }

        var durationMs = (step.beats || 1) * beatMs

        if (step.note !== undefined) {
            noteOn(step.note)
            noteOffLater(step.note, durationMs)
        }
        else if (step.notes !== undefined) {
            for (var i = 0; i < step.notes.length; i++) {
                noteOn(step.notes[i])
                noteOffLater(step.notes[i], durationMs)
            }
        }

        seqIndex++
        scheduleNext(durationMs)
    }

    function scheduleNext(delayMs) {
        var t = Qt.createQmlObject("import QtQuick 2.12; Timer {}", song)
        t.interval = Math.max(1, delayMs)
        t.triggered.connect(playNextSequence)
        t.start()
    }

    // ─── MODO TIMELINE (tiempo absoluto) ────────────────────────
    property var pendingEvents: []

    function playTimeline() {
        pendingEvents = []
        for (var i = 0; i < timeline.length; i++) {
            var ev = timeline[i]
            var eventTimeMs = ev.time * beatMs
            var obj = {
                triggerMs: eventTimeMs,
                action: ev
            }
            pendingEvents.push(obj)
        }
        checkTimeline()
    }

    function checkTimeline() {
        var now = new Date().getTime() - startTime

        while (pendingEvents.length > 0 && pendingEvents[0].triggerMs <= now) {
            var ev = pendingEvents.shift().action

            if (ev.note) {
                noteOn(ev.note)
                if (ev.beats) noteOffLater(ev.note, ev.beats * beatMs)
            }
            else if (ev.notes) {
                for (var n of ev.notes) {
                    noteOn(n)
                    if (ev.beats) noteOffLater(n, ev.beats * beatMs)
                }
            }
            else if (typeof ev === "function") {
                ev()
            }
        }

        if (pendingEvents.length > 0) {
            var nextDelay = pendingEvents[0].triggerMs - now
            var t = Qt.createQmlObject("import QtQuick 2.12; Timer {}", song)
            t.interval = Math.max(1, nextDelay)
            t.triggered.connect(checkTimeline)
            t.start()
        } else {
            console.log("Timeline terminada")
        }
    }

    // ────────────────────────────────────────────────
    //          FUNCIONES MUSICALES ÚTILES
    // ────────────────────────────────────────────────

    function noteOn(note) {
        synth.runWrite("noteon " + channel + " " + note + " " + velocity)
    }

    function noteOff(note) {
        synth.runWrite("noteoff " + channel + " " + note)
    }

    function noteOffLater(note, ms) {
        var t = Qt.createQmlObject("import QtQuick 2.12; Timer {}", song)
        t.interval = ms
        t.triggered.connect(() => noteOff(note))
        t.start()
    }

    // Arpegio ascendente (up)
    function arpeggioUp(root, octaves, beatDuration) {
        var dur = beatDuration * beatMs
        var idx = 0
        function playOne() {
            if (idx >= octaves * 3) return
            var note = root + [0,4,7][idx % 3] + Math.floor(idx / 3) * 12
            noteOn(note)
            noteOffLater(note, dur * 0.9)
            idx++
            var tt = Qt.createQmlObject("import QtQuick 2.12; Timer {}", song)
            tt.interval = dur
            tt.triggered.connect(playOne)
            tt.start()
        }
        playOne()
    }

    // Arpegio descendente (down)
    function arpeggioDown(root, octaves, beatDuration) {
        var dur = beatDuration * beatMs
        var idx = octaves * 3 - 1
        function playOne() {
            if (idx < 0) return
            var note = root + [0,4,7][idx % 3] + Math.floor(idx / 3) * 12
            noteOn(note)
            noteOffLater(note, dur * 0.9)
            idx--
            var tt = Qt.createQmlObject("import QtQuick 2.12; Timer {}", song)
            tt.interval = dur
            tt.triggered.connect(playOne)
            tt.start()
        }
        playOne()
    }

    // Bonus: función para tocar una escala (ejemplo)
    function playScale(root, type = "major", beatsPerNote = 0.25) {
        var intervals = type === "major" ? [0,2,4,5,7,9,11,12] : [0,2,3,5,7,8,10,12]
        for (var i = 0; i < intervals.length; i++) {
            let note = root + intervals[i]
            let delay = i * beatsPerNote * beatMs
            let t = Qt.createQmlObject("import QtQuick 2.12; Timer {}", song)
            t.interval = delay
            t.triggered.connect(() => {
                noteOn(note)
                noteOffLater(note, beatsPerNote * beatMs * 0.9)
            })
            t.start()
        }
    }
}
