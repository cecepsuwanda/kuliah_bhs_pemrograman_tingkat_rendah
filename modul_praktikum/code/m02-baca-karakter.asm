; =========================================================
; m02-baca-karakter.asm
; Modul 02 -- Membaca satu karakter dengan INT 21h AH=01h,
; lalu mencetak kembali isinya dengan AH=02h.
; Program .EXE.
; Rakit : tasm m02-baca-karakter.asm
; Link  : tlink m02-baca-karakter.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
TANYA   DB 'Ketik satu karakter: $'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AH, 09h             ; pilih layanan cetak string
        MOV DX, OFFSET TANYA    ; DX = offset string pertanyaan
        INT 21h                 ; tampilkan pertanyaan

        MOV AH, 01h             ; pilih layanan baca satu karakter
        INT 21h                 ; hasil ada di AL, karakter ikut tercetak

        MOV DL, AL              ; pindahkan hasil baca ke DL
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak kembali karakter dari AL

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
