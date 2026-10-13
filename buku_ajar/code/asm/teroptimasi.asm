; ============================================================
; teroptimasi.asm  --  VERSI TEROPTIMASI
; Pekerjaan : menjumlahkan 10 elemen larik, lalu mengalikan
;             jumlah itu dengan 8  (sama dengan versi naif).
; Data      : larik = 10, 20, ..., 100  ->  jumlah = 550
; Hasil     : 550 x 8 = 4400 (1130h)
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
;
; Perbaikan yang diterapkan dibandingkan versi naif:
;   1. SI menunjuk langsung ke larik, sehingga pengalamatan
;      memori tidak lagi memakai displacement (EA 5, bukan 8).
;   2. XOR AX, AX menggantikan MOV AX, 0  (2 byte, 3 siklus).
;   3. MUL BX diganti tiga kali SHL AX, 1 (6 siklus, bukan 118+).
;   4. Hasil tidak lagi ditulis ke memori lalu dibaca kembali.
; ============================================================

.MODEL SMALL                ; model memori kecil
.STACK 100h                 ; 256 byte ruang stack

.DATA
    larik   DW 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    jumlah  DW 0            ; tetap dideklarasikan sebagai pembanding
    hasil   DW 0            ; hasil akhir

.CODE
START:
    MOV AX, @DATA           ; inisialisasi register segmen data
    MOV DS, AX

    ; --- bagian yang diukur: mulai di sini ---
    MOV CX, 10              ; penghitung iterasi
    MOV SI, OFFSET larik    ; SI menunjuk elemen pertama larik
    XOR AX, AX              ; akumulator = 0 tanpa memuat konstanta

ULANG:
    ADD AX, [SI]            ; akses memori tanpa displacement
    ADD SI, 2               ; maju satu word
    LOOP ULANG              ; ulangi sampai CX = 0

    ; AX sekarang berisi jumlah = 550; kalikan dengan 8
    SHL AX, 1               ; AX = AX x 2
    SHL AX, 1               ; AX = AX x 4
    SHL AX, 1               ; AX = AX x 8   (3 x 2 = 6 siklus)

    MOV hasil, AX           ; simpan hasil akhir (satu akses memori)
    ; --- bagian yang diukur: selesai di sini ---

    MOV AH, 4Ch             ; layanan DOS: akhiri program
    MOV AL, 00h
    INT 21h

END START
