; =========================================================
; m08-push-pop.asm
; Modul 08 -- Menyimpan dan mengambil dua register dari stack.
; Program .EXE. Urutan LIFO diperiksa dengan DEBUG.
; Rakit : tasm m08-push-pop.asm
; Link  : tlink m08-push-pop.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h
        .DATA
; Tidak ada variabel; nilai disimpan sementara di stack.

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AX, 1111h           ; nilai pertama
        MOV BX, 2222h           ; nilai kedua
        PUSH AX                 ; simpan AX lebih dahulu
        PUSH BX                 ; simpan BX paling akhir

        POP CX                  ; CX = 2222h, data terakhir masuk
        POP DX                  ; DX = 1111h, data pertama masuk
        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
