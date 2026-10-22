; =========================================================
; m03-hitung.asm
; Modul 03 -- ADD, SUB, INC, dan DEC.
; Program .EXE. Satu hasil 0--9 dicetak; hasil lain dilihat
; pada register dengan emu8086 atau DEBUG.
; Rakit : tasm m03-hitung.asm
; Link  : tlink m03-hitung.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
; Tidak ada variabel; seluruh nilai dihitung di register.

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

; Hasil lebih dari satu digit: periksa AX di emu8086 atau DEBUG.
        MOV AX, 1234h           ; AX = 1234h
        ADD AX, 5678h           ; AX = 68ACh, hasil multi-digit

; Runtunan yang menghasilkan satu digit.
        MOV AL, 5               ; AL = 5
        ADD AL, 3               ; AL = 8
        SUB AL, 1               ; AL = 7
        INC AL                  ; AL = 8
        DEC AL                  ; AL = 7

; Cetak satu digit 0--9: tambahkan 30h agar menjadi kode ASCII.
        ADD AL, 30h             ; AL = 37h, yaitu karakter '7'
        MOV DL, AL              ; DL = karakter yang dicetak
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
