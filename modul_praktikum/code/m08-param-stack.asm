; =========================================================
; m08-param-stack.asm
; Modul 08 -- Satu prosedur dengan parameter lewat stack.
; Program .EXE. Hasil penjumlahan 3 + 5 = 8 dicetak.
; Rakit : tasm m08-param-stack.asm
; Link  : tlink m08-param-stack.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
; Tidak ada variabel; parameter dan hasil berada di stack/register.

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AX, 5               ; parameter kedua
        PUSH AX                 ; dorong parameter kedua lebih dahulu
        MOV AX, 3               ; parameter pertama
        PUSH AX                 ; dorong parameter pertama paling akhir

        CALL TAMBAH             ; panggil prosedur; hasil di AX
        ADD SP, 4               ; buang dua parameter (4 byte)

; Hasil AX = 8; ubah menjadi kode ASCII dan cetak satu digit.
        ADD AL, 30h             ; AL = 38h, karakter '8'
        MOV DL, AL              ; DL = karakter yang dicetak
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE

; ---------------------------------------------------------
; Prosedur TAMBAH
; Masuk : [BP+4] = parameter pertama, [BP+6] = parameter kedua
; Hasil : AX = jumlah kedua parameter
; ---------------------------------------------------------
TAMBAH  PROC
        PUSH BP                 ; simpan BP milik pemanggil
        MOV BP, SP              ; BP menunjuk puncak bingkai stack
        MOV AX, [BP+4]          ; AX = parameter pertama
        ADD AX, [BP+6]          ; AX = parameter pertama + kedua
        POP BP                  ; pulihkan BP milik pemanggil
        RET                     ; kembali; parameter dibuang pemanggil
TAMBAH  ENDP

        END START
