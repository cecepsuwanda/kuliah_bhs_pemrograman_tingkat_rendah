; =========================================================
; m07-jumlah-array.asm
; Modul 07 -- Menjumlahkan array word dengan SI dan LOOP.
; Program .EXE. Jumlah pada contoh ini 9 sehingga dapat dicetak
; sebagai satu digit. Bila jumlah lebih dari 9, periksa AX.
; Rakit : tasm m07-jumlah-array.asm
; Link  : tlink m07-jumlah-array.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
DERET   DW 2, 3, 4              ; tiga elemen word, masing-masing 2 byte

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AX, 0               ; AX = akumulator jumlah
        MOV SI, OFFSET DERET    ; SI menunjuk elemen pertama
        MOV CX, 3               ; CX = banyaknya elemen

ULANG:
        ADD AX, [SI]            ; tambahkan elemen yang ditunjuk SI
        ADD SI, 2               ; maju dua byte ke elemen berikutnya
        LOOP ULANG              ; ulangi sampai CX nol

; Jumlah = 9; ubah menjadi kode ASCII dan cetak satu digit.
        ADD AL, 30h             ; AL = 39h, karakter '9'
        MOV DL, AL              ; DL = karakter yang dicetak
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
