; =========================================================
; m04-if-else.asm
; Modul 04 -- Percabangan if--else dengan CMP, JGE, dan JMP.
; Program .EXE. Mencetak salah satu dari dua kalimat.
; Rakit : tasm m04-if-else.asm
; Link  : tlink m04-if-else.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
KECIL   DB 'Nilai kurang dari lima.', 0Dh, 0Ah, '$'
BESAR   DB 'Nilai lima atau lebih.', 0Dh, 0Ah, '$'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AL, 3               ; nilai yang diperiksa
        CMP AL, 5               ; bandingkan AL dengan 5
        JGE BESAR               ; lompat bila AL >= 5 (bertanda)

; Cabang else: dijalankan bila AL < 5.
        MOV AH, 09h             ; pilih layanan cetak string
        MOV DX, OFFSET KECIL    ; DX = offset kalimat cabang else
        INT 21h                 ; cetak kalimat
        JMP SELESAI             ; lewati cabang if

; Cabang if: tujuan lompatan JGE.
BESAR:
        MOV AH, 09h             ; pilih layanan cetak string
        MOV DX, OFFSET BESAR    ; DX = offset kalimat cabang if
        INT 21h                 ; cetak kalimat

SELESAI:
        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
