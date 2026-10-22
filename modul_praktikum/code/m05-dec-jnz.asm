; =========================================================
; m05-dec-jnz.asm
; Modul 05 -- Perulangan yang sama tanpa LOOP, memakai DEC dan JNZ.
; Program .EXE. Pencacah perulangan berada di CX.
; Rakit : tasm m05-dec-jnz.asm
; Link  : tlink m05-dec-jnz.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
; Tidak ada variabel; pencacah dan karakter disimpan di register.

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV CX, 5               ; ulangi lima kali
        MOV DL, 'A'             ; karakter pertama

ULANG:
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter pada DL
        INC DL                  ; maju ke karakter berikutnya
        DEC CX                  ; kurangi pencacah; ZF menyala bila nol
        JNZ ULANG               ; ulangi selama CX belum nol

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
