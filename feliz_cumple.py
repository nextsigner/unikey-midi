import struct

def crear_midi_cumple():
    # Cabecera MIDI (MThd): Formato 0, 1 pista, 480 pulsos por negra
    header = b'MThd' + struct.pack('>IHHH', 6, 0, 1, 480)
    
    # Eventos de la pista (Nota, Delta-time)
    # Formato: [Delta-time, Tipo(0x90=On/0x80=Off), Nota, Velocidad]
    # Una negra son 480 unidades. 0.5 negras son 240.
    
    def evento(delta, tipo, nota, vel):
        # Codificación simple de delta time (para valores bajos)
        return bytes([delta]) + bytes([tipo, nota, vel])

    # Melodía: (Nota MIDI, Duración en deltas)
    # C4=60, D4=62, E4=64, F4=65, G4=67, A4=69, Bb4=70, C5=72
    melodia = [
        (60, 240), (60, 240), (62, 480), (60, 480), (65, 480), (64, 960), # Cum-ple-a-ños fe-liz
        (60, 240), (60, 240), (62, 480), (60, 480), (67, 480), (65, 960), # Cum-ple-a-ños fe-liz
        (60, 240), (60, 240), (72, 480), (69, 480), (65, 480), (64, 480), (62, 480), # Te de-sea-mos...
        (70, 240), (70, 240), (69, 480), (65, 480), (67, 480), (65, 960)  # ...fe-liz
    ]

    track_data = bytearray()
    for nota, duracion in melodia:
        # Nota ON (0x90), Velocidad 100 (0x64)
        track_data += b'\x00\x90' + bytes([nota, 0x64])
        # Nota OFF (0x80) después de la duración (codificada de forma simple para este caso)
        # Usamos 0x81, 0x70 si es > 127, pero para simplificar usamos deltas cortos:
        if duracion > 127:
            # Delta time variable length para 240 y 480
            if duracion == 240: d = b'\x81\x70' 
            elif duracion == 480: d = b'\x83\x60'
            elif duracion == 960: d = b'\x87\x40'
            else: d = b'\x00'
        else:
            d = bytes([duracion])
            
        track_data += d + b'\x80' + bytes([nota, 0])

    # Fin de pista
    track_data += b'\x01\xFF\x2F\x00'
    
    # Cabecera de pista (MTrk)
    track = b'MTrk' + struct.pack('>I', len(track_data)) + track_data

    with open("feliz_cumple.mid", "wb") as f:
        f.write(header + track)
    
    print("Archivo 'feliz_cumple.mid' generado con éxito sin librerías externas.")

if __name__ == "__main__":
    crear_midi_cumple()
