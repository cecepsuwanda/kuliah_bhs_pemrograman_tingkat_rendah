; ============================================================
; pesan-flag.asm
; Memilih pesan keluaran berdasarkan flag hasil penjumlahan.
; Contoh sederhana sebelum bab lompatan bersyarat dibahas.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    pesan_carry DB  'Terjadi carry, CF = 1.', 0Dh, 0Ah, '$'
    pesan_nol   DB  'Hasil penjumlahan nol, ZF = 1.', 0Dh, 0Ah, '$'
    pesan_neg   DB  'Hasil bertanda negatif, SF = 1.', 0Dh, 0Ah, '$'
    pesan_aman  DB  'Tanpa carry, hasil tidak nol.', 0Dh, 0Ah, '$'

.CODE
START:
    ; --- inisialisasi register segmen data ---
    MOV AX, @DATA
    MOV DS, AX

    ; --- operasi yang diuji: F0h + 10h ---
    MOV AL, 0F0h            ; AL = 1111 0000b
    MOV BL, 10h             ; BL = 0001 0000b
    ADD AL, BL              ; AL = 00h, CF = 1, ZF = 1, SF = 0

    ; --- periksa CF dengan JC / JNC ---
    JNC tanpa_carry         ; lompat bila CF = 0
    MOV AH, 09h             ; cetak pesan carry
    LEA DX, pesan_carry
    INT 21h
tanpa_carry:

    ; --- periksa ZF dengan JNZ ---
    JNZ bukan_nol           ; lompat bila ZF = 0
    MOV AH, 09h             ; cetak pesan hasil nol
    LEA DX, pesan_nol
    INT 21h
bukan_nol:

    ; --- periksa SF dengan JNS ---
    JNS tanpa_negatif       ; lompat bila SF = 0
    MOV AH, 09h             ; cetak pesan hasil negatif
    LEA DX, pesan_neg
    INT 21h
tanpa_negatif:

    ; --- cetak pesan umum bila tidak ada penanda khusus ---
    CMP AL, 0               ; bandingkan hasil dengan nol
    JZ  selesai             ; lompat bila hasil memang nol
    MOV AH, 09h
    LEA DX, pesan_aman
    INT 21h
selesai:

    ; --- keluar dari program ---
    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h

END START
