; ============================================================
; naif.asm  --  VERSI NAIF
; Pekerjaan : menjumlahkan 10 elemen larik, lalu mengalikan
;             jumlah itu dengan 8.
; Data      : larik = 10, 20, ..., 100  ->  jumlah = 550
; Hasil     : 550 x 8 = 4400 (1130h)
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
;
; Cara memakai versi ini bersama versi teroptimasi:
;   tasm naif.asm   /   tlink naif.obj   /   naif
;   lalu bongkar dengan DEBUG:  -u 100 11A
; ============================================================

.MODEL SMALL                ; model memori kecil
.STACK 100h                 ; 256 byte ruang stack

.DATA
    larik   DW 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    jumlah  DW 0            ; tempat menyimpan jumlah
    hasil   DW 0            ; tempat menyimpan hasil akhir

.CODE
START:
    MOV AX, @DATA           ; inisialisasi register segmen data
    MOV DS, AX

    ; --- bagian yang diukur: mulai di sini ---
    MOV CX, 10              ; penghitung iterasi: 10 elemen
    MOV SI, 0               ; SI = indeks byte (0, 2, 4, ...)
    MOV AX, 0               ; akumulator mulai dari nol

ULANG:
    ADD AX, larik[SI]       ; ambil elemen dari memori setiap iterasi
    ADD SI, 2               ; maju satu word (2 byte)
    LOOP ULANG              ; ulangi sampai CX = 0

    MOV jumlah, AX          ; simpan jumlah ke memori
    MOV AX, jumlah          ; muat kembali dari memori (akses tambahan)
    MOV BX, 8               ; pengali = 8
    MUL BX                  ; DX:AX = AX x BX  (118-133 siklus)
    MOV hasil, AX           ; simpan hasil akhir
    ; --- bagian yang diukur: selesai di sini ---

    MOV AH, 4Ch             ; layanan DOS: akhiri program
    MOV AL, 00h             ; kode keluar sukses
    INT 21h

END START                   ; titik masuk program = label START
