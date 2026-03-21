import QtQuick 2.12
import QtQuick.Controls 2.0
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import unik.UnikQProcess 1.0

import Capturador 2.0
import Teclado 1.0
import SelectorInstrumentos 1.0
//import Ritmos 1.1
import Acordes 1.0

ApplicationWindow{
    id: app
    visibility: apps.showMaximized?'Maximized':'Windowed'
    color: 'black'
    title: 'MidiM'
    width: 500
    height: 200
    flags: Qt.WindowStaysOnTopHint


    property int initTono: 41 //Nota Fa

    readonly property int startNote: 36
    readonly property int totalKeys: 49
    Settings{
        id: apps
        property bool showMaximized: true
        property bool todoEnCanalCero: true
        property bool showLog: true
        property int cProg: 16
        property int cSelInstrumentIndex: 0
        property string cSoundFontsPath: '/usr/share/sounds/sf2/FluidR3_GM.sf2'
    }
    //sf2dump
    UnikQProcess{
        id: uqpList
        onLogDataChanged: {
            log.text+=logData
            if(logData.indexOf('FluidSynth runtime version')>=0){
                log.text+='FluidSynth Iniciado.'
                selectorInstrumentos.cbInstrumentos.currentIndex=apps.cSelInstrumentIndex            }
        }
        onFinished: log.text+='Terminó!'
        Component.onCompleted: {
            //run('fluidsynth -a alsa -g 1.0 -L '+app.totalKeys+' /usr/share/sounds/sf2/FluidR3_GM.sf2')
            //run('fluidsynth -a alsa -g 1.0 -L '+app.totalKeys+' /media/ns/Archivos/mis_sonidos_midi.sf2')

        }
    }
    UnikQProcess{
        id: uqp
        onLogDataChanged: {
            log.text+=logData
            if(logData.indexOf('FluidSynth runtime version')>=0){
                log.text+='FluidSynth Iniciado.'
                selectorInstrumentos.cbInstrumentos.currentIndex=apps.cSelInstrumentIndex            }
        }
        onFinished: log.text+='Terminó!'
        Component.onCompleted: {
            run('fluidsynth -a alsa -g 1.0 -L '+app.totalKeys+' '+apps.cSoundFontsPath)
            //run('fluidsynth -a alsa -g 1.0 -L '+app.totalKeys+' /media/ns/Archivos/mis_sonidos_midi.sf2')

        }
    }
    //Ritmos{}
    Acordes{id: acordes}
    Column{
        id: col
        width: parent.width
        Row{
            height: parent.parent.height-teclado.height-selectorInstrumentos.height
            visible: apps.showLog
            Text{
                id: log
                font.pixelSize: 25
                color: 'white'
                width: Screen.width*0.5
                height: contentHeight
                wrapMode: Text.WordWrap
                anchors.bottom: parent.bottom
            }
        }
        SelectorInstrumentos{id: selectorInstrumentos}
        Teclado{id: teclado}
    }
    Capturador{id: capturador}
    /
    Component.onCompleted: {
        apps.cSoundFontsPath= '/usr/share/sounds/sf2/FluidR3_GM.sf2'
        //cancion.play()
        //selectorInstrumentos.cbInstrumentos.currentIndex=apps.cSelInstrumentIndex
    }
    Shortcut{
        sequence: 'Shift+Tab'
        onActivated: {
            capturador.focus=true
        }
    }
    Shortcut{
        sequence: 'Shift+0'
        onActivated: {
            acordes.playAcorde(41, "M")
        }
    }
    Shortcut{
        sequence: 'Shift+1'
        onActivated: {
            acordes.playAcorde(41, "m")
        }
    }
    Shortcut{
        sequence: 'Shift+2'
        onActivated: {
            acordes.playAcorde(41, "7")
        }
    }
    Shortcut{
        sequence: 'Up'
        onActivated: {
            if(selectorInstrumentos.cbInstrumentos.currentIndex<selectorInstrumentos.cbInstrumentos.count-1){
                selectorInstrumentos.cbInstrumentos.currentIndex++
            }else{
                selectorInstrumentos.cbInstrumentos.currentIndex=0
            }
        }
    }
    Shortcut{
        sequence: 'Down'
        onActivated: {
            if(selectorInstrumentos.cbInstrumentos.currentIndex>0){
                selectorInstrumentos.cbInstrumentos.currentIndex--
            }else{
                selectorInstrumentos.cbInstrumentos.currentIndex=selectorInstrumentos.cbInstrumentos.count-1
            }
        }
    }
    /*Shortcut{
        sequence: 'Ctrl+0'
        onActivated: {
            uqp.runWrite('prog 0 16')
        }
    }
    Shortcut{
        sequence: 'Ctrl+1'
        onActivated: {
            uqp.runWrite('prog 0 24')
        }
    }
    Shortcut{
        sequence: 'Ctrl+2'
        onActivated: {
            uqp.runWrite('prog 0 36')
        }
    }
    Shortcut{
        sequence: 'Ctrl+3'
        onActivated: {
            uqp.runWrite('prog 0 48')
        }
    }
    Shortcut{
        sequence: 'Ctrl+4'
        onActivated: {
            uqp.runWrite('prog 0 56')
        }
    }*/
    Shortcut{
        sequence: 'Ctrl+Esc'
        onActivated: Qt.quit()
    }

    function isBlackKey(note) {
        var normalized = note % 12;
        // 1=Do#, 3=Re#, 6=Fa#, 8=Sol#, 10=La#
        return [1, 3, 6, 8, 10].indexOf(normalized) !== -1;
    }
}
