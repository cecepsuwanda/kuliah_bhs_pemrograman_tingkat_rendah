; =========================================================
; m10-geser.asm
; Modul 10 -- Menggeser satu byte dengan SHR.
; Program .EXE. Hasil 09h SHR 1 = 04h dilihat di register,
; lalu dicetak karena masih berupa satu digit.
; Rakit : tasm m10-geser.asm
; Link  : tlink m10-geser.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
; Tidak ada variabel; nilai diolah di register.

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AL, 00001001b       ; AL = 09h
        SHR AL, 1               ; AL = 04h, bit 0 keluar ke CF

; Hasil 04h dapat diperiksa pada AL sebelum diubah menjadi karakter.
        ADD AL, 30h             ; AL = 34h, karakter '4'
        MOV DL, AL              ; DL = karakter yang dicetak
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
