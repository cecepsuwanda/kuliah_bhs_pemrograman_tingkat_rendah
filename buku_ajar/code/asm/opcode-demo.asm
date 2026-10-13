; ============================================================
; opcode-demo.asm
; Program kecil untuk dibongkar (disassembly) dengan perintah U
; pada DEBUG, lalu dibandingkan dengan kode sumbernya.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL                ; model memori: satu segmen kode + data
.STACK 100h                 ; sediakan 256 byte ruang stack

.DATA
    pesan   DB  'Format instruksi mesin', 0Dh, 0Ah, '$'

.CODE
START:
    ; --- 1. inisialisasi register segmen data ---
    MOV AX, @DATA           ; B8 xx xx : alamat segmen .DATA
    MOV DS, AX              ; 8E D8    : salin ke DS

    ; --- 2. lima instruksi yang akan dibongkar ---
    MOV AX, 0005h           ; B8 05 00 : immediate 16 bit ke AX
    MOV BX, 0001h           ; BB 01 00 : immediate 16 bit ke BX
    ADD AX, BX              ; 03 C3    : register ke register
    MOV CX, AX              ; 89 C1    : salin AX ke CX
    SUB AX, 0002h           ; 2D 02 00 : kurangi AX dengan 2

    ; --- 3. cetak pesan dengan layanan DOS ---
    MOV AH, 09h             ; B4 09    : fungsi cetak string
    LEA DX, pesan           ; 8D 16 xx xx : DX = offset string
    INT 21h                 ; CD 21    : panggil interupsi DOS

    ; --- 4. keluar dari program ---
    MOV AH, 4Ch             ; B4 4C    : fungsi terminasi
    MOV AL, 00h             ; B0 00    : kode keluar 0
    INT 21h                 ; CD 21    : panggil interupsi DOS

END START                   ; titik masuk program = label START
