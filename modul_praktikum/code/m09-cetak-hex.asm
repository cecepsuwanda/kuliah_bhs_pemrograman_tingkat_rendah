; =========================================================
; m09-cetak-hex.asm
; Modul 09 -- Mencetak satu word sebagai heksadesimal empat digit.
; Program .EXE. Algoritma pembagian yang sama dipakai dengan
; pembagi 16; sisa 0--15 diubah menjadi karakter 0--9 dan A--F.
; Rakit : tasm m09-cetak-hex.asm
; Link  : tlink m09-cetak-hex.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
NILAI   DW 12345                ; 12345 = 3039h

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AX, NILAI           ; AX = word yang dicetak
        CALL CETAK_HEX          ; cetak AX sebagai empat digit hex

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE

; ---------------------------------------------------------
; Prosedur CETAK_HEX
; Masuk : AX = word yang dicetak
; Hasil : empat digit heksadesimal tercetak
; ---------------------------------------------------------
CETAK_HEX PROC
        PUSH AX                 ; simpan register yang dipakai
        PUSH BX
        PUSH CX
        PUSH DX

        MOV CX, 4               ; empat digit heksadesimal
        MOV BX, 16              ; BX = pembagi

HEX_ULANG:
        MOV DX, 0               ; kosongkan DX sebelum DIV word
        DIV BX                  ; AX = hasil bagi, DX = sisa 0--15
        PUSH DX                 ; simpan satu digit di stack
        LOOP HEX_ULANG          ; ulangi empat kali

        MOV CX, 4               ; siapkan cacah digit untuk dicetak
HEX_CETAK:
        POP DX                  ; ambil digit paling kiri lebih dahulu
        CMP DL, 9               ; digit 0--9 atau 10--15?
        JBE HEX_ANGKA           ; langsung ke angka bila 0--9
        ADD DL, 7               ; 10--15 menjadi A--F
HEX_ANGKA:
        ADD DL, '0'             ; ubah nilai digit menjadi kode ASCII
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak digit
        LOOP HEX_CETAK          ; ulangi sampai empat digit tercetak

        POP DX                  ; pulihkan register pemanggil
        POP CX
        POP BX
        POP AX
        RET                     ; kembali ke pemanggil
CETAK_HEX ENDP

        END START
