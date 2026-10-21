; ============================================================
; bilangan.asm
; Menyimpan nilai 243 dalam tiga basis dan satu karakter.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL                ; satu segmen kode dan satu segmen data
.STACK 100h                 ; ruang stack 256 byte

.DATA
    desimal  DB 243          ; 243 desimal
    biner    DB 11110011b    ; 11110011 biner = 243
    heksa    DB 0F3h         ; F3 heksadesimal = 243
    karakter DB 'A'          ; kode ASCII 41h

.CODE
START:
    MOV AX, @DATA           ; alamat segmen data
    MOV DS, AX              ; pasang ke register DS

    MOV AH, 4Ch             ; fungsi 4Ch: akhiri program
    MOV AL, 00h             ; kode keluar 0
    INT 21h

END START                   ; titik masuk program
