; =========================================================
; m07-maksimum.asm
; Modul 07 -- Mencari elemen terbesar pada array byte.
; Program .EXE. Hasil terbesar pada contoh ini 9 sehingga dapat
; dicetak sebagai satu digit. Bila lebih dari 9, periksa AL.
; Rakit : tasm m07-maksimum.asm
; Link  : tlink m07-maksimum.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
DERET   DB 5, 9, 3, 7, 2        ; lima elemen byte

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV BX, OFFSET DERET    ; BX menunjuk elemen pertama
        MOV AL, [BX]            ; AL = kandidat terbesar, yaitu 5
        INC BX                  ; BX menunjuk elemen kedua
        MOV CX, 4               ; empat elemen lagi yang diperiksa

ULANG:
        CMP AL, [BX]            ; bandingkan kandidat dengan elemen
        JAE LANJUT              ; kandidat tetap bila AL >= elemen
        MOV AL, [BX]            ; ganti kandidat dengan elemen lebih besar

LANJUT:
        INC BX                  ; maju satu byte ke elemen berikutnya
        LOOP ULANG              ; ulangi sampai CX nol

; AL = 9; ubah menjadi kode ASCII dan cetak satu digit.
        ADD AL, 30h             ; AL = 39h, karakter '9'
        MOV DL, AL              ; DL = karakter yang dicetak
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
