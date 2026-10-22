; =========================================================
; m06-prosedur.asm
; Modul 06 -- Satu prosedur pencetak, dipanggil dua kali.
; Program .EXE. Parameter string dikirim melalui DX.
; Rakit : tasm m06-prosedur.asm
; Link  : tlink m06-prosedur.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
BARIS1  DB 'Prosedur dipanggil pertama kali.', 0Dh, 0Ah, '$'
BARIS2  DB 'Prosedur dipanggil kedua kali.', 0Dh, 0Ah, '$'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV DX, OFFSET BARIS1   ; parameter: alamat kalimat pertama
        CALL CETAK              ; panggil prosedur pencetak

        MOV DX, OFFSET BARIS2   ; parameter: alamat kalimat kedua
        CALL CETAK              ; panggil prosedur yang sama

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE

; ---------------------------------------------------------
; Prosedur CETAK
; Masuk : DS:DX = alamat string yang diakhiri tanda $
; Hasil : string tercetak
; ---------------------------------------------------------
CETAK   PROC
        MOV AH, 09h             ; pilih layanan cetak string
        INT 21h                 ; cetak string pada DS:DX
        RET                     ; kembali ke instruksi sesudah CALL
CETAK   ENDP

        END START
