; ============================================================
; siklus-dasar.asm
; Program minimal untuk menelusuri siklus instruksi langkah demi
; langkah (fetch - decode - execute) dengan Single Step Emu8086.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL                ; model memori kecil: 1 segmen kode + 1 segmen data
.STACK 100h                 ; sediakan 256 byte ruang stack

.DATA
    nilai_awal DW 1234h     ; variabel contoh, tidak wajib dibaca program

.CODE
START:
    ; --- 1. inisialisasi register segmen data ---
    MOV AX, @DATA           ; AX <- nomor segmen .DATA
    MOV DS, AX              ; DS menunjuk ke segmen data

    ; --- 2. instruksi utama yang ditelusuri ---
    MOV AX, 1234h           ; instruksi 3 byte: B8 34 12

    ; --- 3. keluar dari program ---
    MOV AH, 4Ch             ; AH = 4Ch : terminasi program
    MOV AL, 00h             ; AL = 00h : kode keluar sukses
    INT 21h                 ; panggil layanan DOS

END START                   ; titik masuk program = label START
