; =========================================================
; m09-cetak-desimal.asm
; Modul 09 -- Mencetak satu bilangan tidak bertanda (lebih dari
; satu digit) dalam bentuk desimal.
; Program .EXE. Algoritma: bagi dengan 10, simpan sisa di stack,
; lalu cetak sisa dari yang terakhir disimpan.
; Rakit : tasm m09-cetak-desimal.asm
; Link  : tlink m09-cetak-desimal.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
NILAI   DW 12345                ; bilangan yang akan dicetak

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AX, NILAI           ; AX = bilangan yang dicetak
        CALL CETAK_DESIMAL      ; cetak AX sebagai desimal

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE

; ---------------------------------------------------------
; Prosedur CETAK_DESIMAL
; Masuk : AX = bilangan tidak bertanda
; Hasil : deret digit desimal tercetak
; ---------------------------------------------------------
CETAK_DESIMAL PROC
        PUSH AX                 ; simpan register yang dipakai
        PUSH BX
        PUSH CX
        PUSH DX

        MOV CX, 0               ; CX = cacah digit
        MOV BX, 10              ; BX = pembagi

BAGI:
        MOV DX, 0               ; kosongkan DX sebelum DIV word
        DIV BX                  ; AX = hasil bagi, DX = sisa
        PUSH DX                 ; simpan satu digit di stack
        INC CX                  ; tambah cacah digit
        CMP AX, 0               ; hasil bagi sudah nol?
        JNE BAGI                ; ulangi bila belum nol

CETAK_DIGIT:
        POP DX                  ; ambil digit terakhir disimpan
        ADD DL, '0'             ; ubah digit menjadi kode ASCII
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak digit
        LOOP CETAK_DIGIT        ; ulangi sampai semua digit tercetak

        POP DX                  ; pulihkan register pemanggil
        POP CX
        POP BX
        POP AX
        RET                     ; kembali ke pemanggil
CETAK_DESIMAL ENDP

        END START
