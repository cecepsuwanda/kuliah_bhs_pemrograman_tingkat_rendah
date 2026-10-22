; =========================================================
; m11-bug-stack-fix.asm
; Perbaikan m11-bug-stack.asm.
; Perbaikan: POP AX ditambahkan sebelum RET sehingga jumlah
; PUSH dan POP seimbang dan RET mengambil alamat kembali.
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

        MOV AH, 09h             ; cetak pesan penutup
        MOV DX, OFFSET PESAN
        INT 21h

        MOV AH, 4Ch             ; akhiri program
        MOV AL, 00h
        INT 21h

; ---------------------------------------------------------
; Prosedur HITUNG -- menghitung 1 + 2, hasil di CX
; Jumlah PUSH dan POP sekarang seimbang.
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
        POP AX                  ; PERBAIKAN: pulihkan AX
        RET                     ; alamat kembali sudah di puncak stack
HITUNG  ENDP

        END START
