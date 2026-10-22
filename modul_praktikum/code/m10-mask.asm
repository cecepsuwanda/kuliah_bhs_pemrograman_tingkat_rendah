; =========================================================
; m10-mask.asm
; Modul 10 -- Menyamarkan bit dengan OR dan AND, lalu memeriksa
; satu bit dengan TEST. Mencetak "ya" atau "tidak".
; Program .EXE.
; Rakit : tasm m10-mask.asm
; Link  : tlink m10-mask.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
YA      DB 'ya', 0Dh, 0Ah, '$'
TIDAK   DB 'tidak', 0Dh, 0Ah, '$'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AL, 00000101b       ; AL = 05h
        OR AL, 10000000b        ; nyalakan bit 7  -> AL = 85h
        AND AL, 11110000b       ; pertahankan nibble atas -> 80h

        TEST AL, 10000000b      ; periksa bit 7 tanpa mengubah AL
        JZ CETAK_TIDAK          ; ZF = 1 berarti bit 7 padam

        MOV AH, 09h             ; bit 7 menyala
        MOV DX, OFFSET YA
        INT 21h
        JMP SELESAI

CETAK_TIDAK:
        MOV AH, 09h             ; bit 7 padam
        MOV DX, OFFSET TIDAK
        INT 21h

SELESAI:
        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
