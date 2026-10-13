; ============================================================
; teroptimasi-unroll.asm  --  VERSI TEROPTIMASI + LOOP UNROLLING
; Pekerjaan : menjumlahkan 10 elemen larik, lalu mengalikan
;             jumlah itu dengan 8 (hasil sama dengan kedua versi
;             sebelumnya).
; Data      : larik = 10, 20, ..., 100  ->  jumlah = 550
; Hasil     : 550 x 8 = 4400 (1130h)
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
;
; Perbaikan tambahan dibandingkan teroptimasi.asm:
;   Isi perulangan digandakan (unrolling 2x), sehingga satu
;   iterasi mengerjakan dua elemen sekaligus. Jumlah iterasi
;   turun dari 10 menjadi 5, dan overhead LOOP (17 siklus)
;   berkurang separuh. Harganya: kode bertambah 3 byte.
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    larik   DW 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    hasil   DW 0

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; --- bagian yang diukur: mulai di sini ---
    MOV CX, 5               ; 5 iterasi untuk 10 elemen
    MOV SI, OFFSET larik
    XOR AX, AX

ULANG:
    ADD AX, [SI]            ; elemen ke-1
    ADD AX, [SI+2]          ; elemen ke-2 (unrolling)
    ADD SI, 4               ; maju dua word sekaligus
    LOOP ULANG

    SHL AX, 1               ; AX = AX x 2
    SHL AX, 1               ; AX = AX x 4
    SHL AX, 1               ; AX = AX x 8
    MOV hasil, AX
    ; --- bagian yang diukur: selesai di sini ---

    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h

END START
