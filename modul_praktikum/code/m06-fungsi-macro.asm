; =========================================================
; m06-fungsi-macro.asm
; Modul 06 -- Satu fungsi pengembalian nilai di AL dan satu
; macro yang mencetak karakter di DL.
; Program .EXE. Parameter fungsi dikirim melalui AL.
; Rakit : tasm m06-fungsi-macro.asm
; Link  : tlink m06-fungsi-macro.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

; Macro mencetak karakter yang sudah berada di DL.
CETAK_KARAKTER MACRO
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter pada DL
        ENDM

        .DATA
; Tidak ada variabel; nilai diolah di register.

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AL, 5               ; parameter fungsi: AL = 5
        CALL TAMBAH_TIGA        ; hasil fungsi kembali di AL

        ADD AL, 30h             ; ubah satu digit 0--9 menjadi ASCII
        MOV DL, AL              ; DL = karakter yang akan dicetak
        CETAK_KARAKTER          ; pakai macro untuk mencetak

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE

; ---------------------------------------------------------
; Fungsi TAMBAH_TIGA
; Masuk : AL = nilai awal
; Hasil : AL = nilai awal + 3
; ---------------------------------------------------------
TAMBAH_TIGA PROC
        ADD AL, 3               ; tambahkan 3 pada AL
        RET                     ; kembali ke instruksi sesudah CALL
TAMBAH_TIGA ENDP

        END START
