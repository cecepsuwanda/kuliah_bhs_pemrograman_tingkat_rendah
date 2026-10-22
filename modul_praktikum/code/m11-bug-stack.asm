; =========================================================
; m11-bug-stack.asm
; Latihan debugging: memanggil prosedur HITUNG.
; Program ini sengaja mengandung kesalahan; jangan dipakai
; sebagai contoh baku.
; Gejala: pesan penutup tidak tercetak.
; Petunjuk: hitung jumlah PUSH dan POP di dalam HITUNG.
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
PESAN   DB 'Selesai.$'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        CALL HITUNG             ; panggil prosedur HITUNG

        MOV AH, 09h             ; baris ini tidak pernah dicapai
        MOV DX, OFFSET PESAN
        INT 21h

        MOV AH, 4Ch             ; akhiri program
        MOV AL, 00h
        INT 21h

; ---------------------------------------------------------
; Prosedur HITUNG -- menghitung 1 + 2, hasil di CX
; ---------------------------------------------------------
HITUNG  PROC
        PUSH AX                 ; simpan AX lama
        PUSH BX                 ; simpan BX lama
        PUSH CX                 ; simpan CX lama

        MOV AX, 0001h           ; suku pertama
        MOV BX, 0002h           ; suku kedua
        ADD AX, BX              ; AX = 0003h
        MOV CX, AX              ; CX = hasil

        POP CX                  ; pulihkan CX
        POP BX                  ; pulihkan BX
        ; periksa keseimbangan stack sebelum RET
        RET                     ; ambil alamat kembali dari stack
HITUNG  ENDP

        END START
