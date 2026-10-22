; =========================================================
; m03-pindah-data.asm
; Modul 03 -- MOV dan XCHG antar register.
; Program .EXE. Tidak mencetak keluaran; hasil diperiksa pada
; register dengan emu8086 atau DEBUG.
; Rakit : tasm m03-pindah-data.asm
; Link  : tlink m03-pindah-data.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
; Tidak ada variabel; seluruh nilai disimpan di register.

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AX, 1234h           ; AX = 1234h
        MOV BX, 5678h           ; BX = 5678h
        MOV CX, 9ABCh           ; CX = 9ABCh
        MOV DX, AX              ; DX = 1234h, menyalin isi AX

        XCHG AX, BX             ; AX = 5678h, BX = 1234h
        XCHG AX, CX             ; AX = 9ABCh, CX = 5678h

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
