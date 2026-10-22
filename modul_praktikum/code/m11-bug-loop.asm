; =========================================================
; m11-bug-loop.asm
; Latihan debugging: menjumlahkan bilangan 1 sampai 5.
; Program ini sengaja mengandung kesalahan; jangan dipakai
; sebagai contoh baku.
; Gejala: program tidak kembali ke DOS.
; Petunjuk: periksa nilai CX setiap kali LOOP dijalankan.
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
JUDUL   DB 'Jumlah 1..5 = $'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        XOR AX, AX              ; AX = akumulator jumlah
        MOV CX, 5               ; CX = pencacah mula-mula

ULANG:
        ADD AX, CX              ; jumlahkan nilai pencacah
        INC CX                  ; baris yang perlu diperiksa
        LOOP ULANG              ; LOOP mengurangi CX lalu melompat

        MOV AH, 09h             ; baris ini tidak pernah dicapai
        MOV DX, OFFSET JUDUL
        INT 21h

        MOV AH, 4Ch             ; akhiri program
        MOV AL, 00h
        INT 21h
        END START
