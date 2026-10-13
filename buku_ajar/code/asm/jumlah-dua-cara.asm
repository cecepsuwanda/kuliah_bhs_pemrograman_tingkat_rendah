; ============================================================
; jumlah-dua-cara.asm
; Membandingkan biaya penjumlahan dua bilangan dengan dua cara:
;   cara 1 - kedua operand sudah berada di register (cepat);
;   cara 2 - kedua operand diambil dari memori satu per satu.
; Hasil kedua cara harus sama, yaitu 68ACh.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    bil1    DW 1234h        ; bilangan pertama di memori
    bil2    DW 5678h        ; bilangan kedua di memori
    hasil1  DW 0            ; penampung hasil cara 1
    hasil2  DW 0            ; penampung hasil cara 2

.CODE
START:
    MOV AX, @DATA           ; inisialisasi register segmen data
    MOV DS, AX

    ; --- cara 1: operand langsung dari register (tanpa akses memori) ---
    MOV AX, 1234h           ; AX <- bilangan pertama (immediate)
    MOV BX, 5678h           ; BX <- bilangan kedua (immediate)
    ADD AX, BX              ; AX <- AX + BX, hasil di register
    MOV hasil1, AX          ; simpan hasil cara 1

    ; --- cara 2: operand dibaca dari memori (tiap MOV memicu bus) ---
    MOV AX, bil1            ; AX <- isi memori bil1
    ADD AX, bil2            ; AX <- AX + isi memori bil2
    MOV hasil2, AX          ; simpan hasil cara 2

    ; --- keluar dari program ---
    MOV AH, 4Ch             ; AH = 4Ch : terminasi program
    MOV AL, 00h             ; AL = 00h : kode keluar sukses
    INT 21h

END START
