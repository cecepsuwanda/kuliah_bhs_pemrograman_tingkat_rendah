; ============================================================
; array-string.asm
; Menjumlahkan array word dan menyalin string ke buffer.
; Hasil disimpan di segmen data untuk diperiksa dengan DEBUG.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    deret   DW 10, 20, 30, 40, 50
    BANYAK  EQU ($ - deret) / 2      ; banyak elemen = 5
    jumlah  DW ?                     ; hasil penjumlahan array

    sumber  DB 'ASSEMBLY$'           ; string sumber
    tujuan  DB 12 DUP(?)             ; penampung salinan
    panjang DB ?                     ; panjang string tanpa '$'

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; --- 1. menjumlahkan array word ---
    LEA SI, deret
    MOV CX, BANYAK
    XOR AX, AX                       ; AX = 0 (akumulator)
JUMLAH:
    ADD AX, [SI]                     ; tambahkan elemen
    ADD SI, 2                        ; maju satu word
    LOOP JUMLAH
    MOV jumlah, AX                   ; simpan hasil

    ; --- 2. menyalin string sampai penanda '$' ---
    LEA SI, sumber
    LEA DI, tujuan
    XOR CX, CX                       ; CX = cacah karakter
SALIN:
    MOV AL, [SI]                     ; ambil satu byte
    MOV [DI], AL                     ; salin ke buffer
    CMP AL, '$'                      ; sudah akhir string?
    JE  SELESAI
    INC SI
    INC DI
    INC CX
    JMP SALIN

SELESAI:
    MOV panjang, CL                  ; simpan panjang tanpa '$'

    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h

END START
