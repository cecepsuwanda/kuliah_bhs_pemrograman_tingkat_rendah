; =========================================================
; equ-konstanta.asm
; Memakai EQU sebagai konstanta simbolik agar program mudah dibaca.
; Bandingkan: equ-salah.asm (EQU yang didefinisikan ulang).
; =========================================================

LAYAR       EQU 02h     ; fungsi DOS: cetak karakter
TULIS       EQU 09h     ; fungsi DOS: cetak string
KELUAR      EQU 4Ch     ; fungsi DOS: akhiri program
BARIS_BARU  EQU 0Dh     ; kode ASCII carriage return
AWAL_BARIS  EQU 0Ah     ; kode ASCII line feed

.MODEL SMALL
.STACK 100h

.DATA
    judul   DB 'Konstanta EQU', 0Dh, 0Ah, '$'
    isi     DB 'X = ', '$'

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV AH, TULIS           ; cetak judul
    LEA DX, judul
    INT 21h

    MOV AH, TULIS           ; cetak awalan 'X = '
    LEA DX, isi
    INT 21h

    MOV AH, LAYAR           ; cetak karakter '7'
    MOV DL, '7'
    INT 21h

    MOV AH, LAYAR           ; pindah ke baris baru
    MOV DL, BARIS_BARU
    INT 21h
    MOV DL, AWAL_BARIS
    INT 21h

    MOV AH, KELUAR          ; akhiri program
    MOV AL, 00h
    INT 21h

END START
