import QtQuick 2.14
import QtQuick.Controls 2.12

Column {
    id: r
    spacing: 10
    anchors.horizontalCenter: parent.horizontalCenter
    property alias cbInstrumentos: instrumentSelector
    Row{
        spacing: 10
        Label {
            id: labelSoundFontPath
            text: "SoundFonts: "
            font.bold: true
            font.pixelSize: r.width*0.04
            color: "white"
        }
        Rectangle{
            width: r.width-labelSoundFontPath.contentWidth-parent.spacing
            height: tiSoundFontPath.font.pixelSize*1.2
            color: 'transparent'
            border.width: 1
            border.color: 'white'
            clip: true
            TextInput{
                id: tiSoundFontPath
                text: apps.cSoundFontsPath
                font.pixelSize: r.width*0.04
                color: "white"
                anchors.centerIn: parent
                onTextChanged: {
                    if(!u.fileExist(text)){
                        color='red'
                    }else{
                        color='white'
                        apps.cSoundFontsPath=text
                    }
                }
            }
        }
    }
    Label {
        //text: "Seleccionar Instrumento (FluidSynth):"
        text: "Instrumento actual: "+cbInstrumentos.currentText
        font.bold: true
        font.pixelSize: r.width*0.04
        color: "white"
    }
    ComboBox {
        id: instrumentSelector
        width: r.width
        textRole: "name" // Qué propiedad del modelo mostrar
        font.pixelSize: r.width*0.04
        valueRole: "prog" // Qué propiedad usar como valor interno
        //currentIndex: apps.cSelInstrumentIndex
        //tabIndex: capturador
        KeyNavigation.tab: capturador
        model: ListModel {
            id: instrumentModel
            // --- Pianos ---
            ListElement { name: "000 Acoustic Grand Piano"; prog: 0 }
            ListElement { name: "001 Bright Acoustic Piano"; prog: 1 }
            ListElement { name: "002 Electric Grand Piano"; prog: 2 }
            ListElement { name: "003 Honky-tonk Piano"; prog: 3 }
            ListElement { name: "004 Electric Piano 1"; prog: 4 }
            ListElement { name: "005 Electric Piano 2"; prog: 5 }
            ListElement { name: "006 Harpsichord"; prog: 6 }
            ListElement { name: "007 Clavi"; prog: 7 }

            // --- Percusión Cromática ---
            ListElement { name: "008 Celesta"; prog: 8 }
            ListElement { name: "009 Glockenspiel"; prog: 9 }
            ListElement { name: "010 Music Box"; prog: 10 }
            ListElement { name: "011 Vibraphone"; prog: 11 }
            ListElement { name: "012 Marimba"; prog: 12 }
            ListElement { name: "013 Xylophone"; prog: 13 }
            ListElement { name: "014 Tubular Bells"; prog: 14 }
            ListElement { name: "015 Dulcimer"; prog: 15 }

            // --- Órganos ---
            ListElement { name: "016 Drawbar Organ"; prog: 16 }
            ListElement { name: "017 Percussive Organ"; prog: 17 }
            ListElement { name: "018 Rock Organ"; prog: 18 }
            ListElement { name: "019 Church Organ"; prog: 19 }
            ListElement { name: "020 Reed Organ"; prog: 20 }
            ListElement { name: "021 Accordion"; prog: 21 }
            ListElement { name: "022 Harmonica"; prog: 22 }
            ListElement { name: "023 Tango Accordion"; prog: 23 }

            // --- Guitarras ---
            ListElement { name: "024 Acoustic Guitar (nylon)"; prog: 24 }
            ListElement { name: "025 Acoustic Guitar (steel)"; prog: 25 }
            ListElement { name: "026 Electric Guitar (jazz)"; prog: 26 }
            ListElement { name: "027 Electric Guitar (clean)"; prog: 27 }
            ListElement { name: "028 Electric Guitar (muted)"; prog: 28 }
            ListElement { name: "029 Overdriven Guitar"; prog: 29 }
            ListElement { name: "030 Distortion Guitar"; prog: 30 }
            ListElement { name: "031 Guitar harmonics"; prog: 31 }

            // --- Bajos ---
            ListElement { name: "032 Acoustic Bass"; prog: 32 }
            ListElement { name: "033 Electric Bass (finger)"; prog: 33 }
            ListElement { name: "034 Electric Bass (pick)"; prog: 34 }
            ListElement { name: "035 Fretless Bass"; prog: 35 }
            ListElement { name: "036 Slap Bass 1"; prog: 36 }
            ListElement { name: "037 Slap Bass 2"; prog: 37 }
            ListElement { name: "038 Synth Bass 1"; prog: 38 }
            ListElement { name: "039 Synth Bass 2"; prog: 39 }

            // --- Cuerdas (Strings) ---
            ListElement { name: "040 Violin"; prog: 40 }
            ListElement { name: "041 Viola"; prog: 41 }
            ListElement { name: "042 Cello"; prog: 42 }
            ListElement { name: "043 Contrabass"; prog: 43 }
            ListElement { name: "044 Tremolo Strings"; prog: 44 }
            ListElement { name: "045 Pizzicato Strings"; prog: 45 }
            ListElement { name: "046 Orchestral Harp"; prog: 46 }
            ListElement { name: "047 Timpani"; prog: 47 }

            // --- Ensamble ---
            ListElement { name: "048 String Ensemble 1"; prog: 48 }
            ListElement { name: "049 String Ensemble 2"; prog: 49 }
            ListElement { name: "050 SynthStrings 1"; prog: 50 }
            ListElement { name: "051 SynthStrings 2"; prog: 51 }
            ListElement { name: "052 Choir Aahs"; prog: 52 }
            ListElement { name: "053 Voice Oohs"; prog: 53 }
            ListElement { name: "054 Synth Voice"; prog: 54 }
            ListElement { name: "055 Orchestra Hit"; prog: 55 }

            // --- Brass (Metales) ---
            ListElement { name: "056 Trumpet"; prog: 56 }
            ListElement { name: "057 Trombone"; prog: 57 }
            ListElement { name: "058 Tuba"; prog: 58 }
            ListElement { name: "059 Muted Trumpet"; prog: 59 }
            ListElement { name: "060 French Horn"; prog: 60 }
            ListElement { name: "061 Brass Section"; prog: 61 }
            ListElement { name: "062 SynthBrass 1"; prog: 62 }
            ListElement { name: "063 SynthBrass 2"; prog: 63 }

            // --- Reed (Caña) ---
            ListElement { name: "064 Soprano Sax"; prog: 64 }
            ListElement { name: "065 Alto Sax"; prog: 64 } // GM a veces duplica el 64/65
            ListElement { name: "066 Tenor Sax"; prog: 66 }
            ListElement { name: "067 Baritone Sax"; prog: 67 }
            ListElement { name: "068 Oboe"; prog: 68 }
            ListElement { name: "069 English Horn"; prog: 69 }
            ListElement { name: "070 Bassoon"; prog: 70 }
            ListElement { name: "071 Clarinet"; prog: 71 }

            // --- Pipe (Viento madera) ---
            ListElement { name: "072 Piccolo"; prog: 72 }
            ListElement { name: "073 Flute"; prog: 73 }
            ListElement { name: "074 Recorder"; prog: 74 }
            ListElement { name: "075 Pan Flute"; prog: 75 }
            ListElement { name: "076 Blown Bottle"; prog: 76 }
            ListElement { name: "077 Shakuhachi"; prog: 77 }
            ListElement { name: "078 Whistle"; prog: 78 }
            ListElement { name: "079 Ocarina"; prog: 79 }

            // --- Synth Lead ---
            ListElement { name: "080 Lead 1 (square)"; prog: 80 }
            ListElement { name: "081 Lead 2 (sawtooth)"; prog: 81 }
            ListElement { name: "082 Lead 3 (calliope)"; prog: 82 }
            ListElement { name: "083 Lead 4 (chiff)"; prog: 83 }
            ListElement { name: "084 Lead 5 (charang)"; prog: 84 }
            ListElement { name: "085 Lead 6 (voice)"; prog: 85 }
            ListElement { name: "086 Lead 7 (fifths)"; prog: 86 }
            ListElement { name: "087 Lead 8 (bass + lead)"; prog: 87 }

            // --- Synth Pad ---
            ListElement { name: "088 Pad 1 (new age)"; prog: 88 }
            ListElement { name: "089 Pad 2 (warm)"; prog: 89 }
            ListElement { name: "090 Pad 3 (polysynth)"; prog: 90 }
            ListElement { name: "091 Pad 4 (choir)"; prog: 91 }
            ListElement { name: "092 Pad 5 (bowed)"; prog: 92 }
            ListElement { name: "093 Pad 6 (metallic)"; prog: 93 }
            ListElement { name: "094 Pad 7 (halo)"; prog: 94 }
            ListElement { name: "095 Pad 8 (sweep)"; prog: 95 }

            // --- Synth Effects ---
            ListElement { name: "096 FX 1 (rain)"; prog: 96 }
            ListElement { name: "097 FX 2 (soundtrack)"; prog: 97 }
            ListElement { name: "098 FX 3 (crystal)"; prog: 98 }
            ListElement { name: "099 FX 4 (atmosphere)"; prog: 99 }
            ListElement { name: "100 FX 5 (brightness)"; prog: 100 }
            ListElement { name: "101 FX 6 (goblins)"; prog: 101 }
            ListElement { name: "102 FX 7 (echoes)"; prog: 102 }
            ListElement { name: "103 FX 8 (sci-fi)"; prog: 103 }

            // --- Étnicos ---
            ListElement { name: "104 Sitar"; prog: 104 }
            ListElement { name: "105 Banjo"; prog: 105 }
            ListElement { name: "106 Shamisen"; prog: 106 }
            ListElement { name: "107 Koto"; prog: 107 }
            ListElement { name: "108 Kalimba"; prog: 108 }
            ListElement { name: "109 Bag pipe"; prog: 109 }
            ListElement { name: "110 Fiddle"; prog: 110 }
            ListElement { name: "111 Shanai"; prog: 111 }

            // --- Percusión ---
            ListElement { name: "112 Tinkle Bell"; prog: 112 }
            ListElement { name: "113 Agogo"; prog: 113 }
            ListElement { name: "114 Steel Drums"; prog: 114 }
            ListElement { name: "115 Woodblock"; prog: 115 }
            ListElement { name: "116 Taiko Drum"; prog: 116 }
            ListElement { name: "117 Melodic Tom"; prog: 117 }
            ListElement { name: "118 Synth Drum"; prog: 118 }
            ListElement { name: "119 Reverse Cymbal"; prog: 119 }

            // --- Efectos de Sonido ---
            ListElement { name: "120 Guitar Fret Noise"; prog: 120 }
            ListElement { name: "121 Breath Noise"; prog: 121 }
            ListElement { name: "122 Seashore"; prog: 122 }
            ListElement { name: "123 Bird Tweet"; prog: 123 }
            ListElement { name: "124 Telephone Ring"; prog: 124 }
            ListElement { name: "125 Helicopter"; prog: 125 }
            ListElement { name: "126 Applause"; prog: 126 }
            ListElement { name: "127 Gunshot"; prog: 127 }
        }

        onCurrentIndexChanged: {
            var programNumber = model.get(currentIndex).prog;
            cambiarInstrumento(programNumber);
            apps.cSelInstrumentIndex=instrumentSelector.currentIndex
        }
        onActivated: {
            // Obtener el número de programa del elemento seleccionado
            var programNumber = model.get(index).prog;
            cambiarInstrumento(programNumber);
            apps.cSelInstrumentIndex=instrumentSelector.currentIndex
        }
    }
    Item{width: 1; height: 20}
    Timer{
        id: tSetFocus
        interval: 3000
        onTriggered: {
            instrumentSelector.focus=false
            capturador.focus=true
        }
    }
    function cambiarInstrumento(prog) {
        //console.log("Cambiando a instrumento programa:", prog);
        if(apps.todoEnCanalCero){
            uqp.runWrite('prog 0 '+prog)
        }else{
            for(var i=0;i<app.totalKeys;i++){
                uqp.runWrite('prog '+i+' '+prog)
            }
        }

        // Asumiendo que tu objeto 'teclado' tiene un método programChange
        // El formato estándar suele ser: programChange(canal, programa)
        //programChange(0, prog);
        tSetFocus.restart()



        // O si usas un comando de texto tipo shell/raw:
        // teclado.sendRawCommand("prog 0 " + prog);
    }
}
