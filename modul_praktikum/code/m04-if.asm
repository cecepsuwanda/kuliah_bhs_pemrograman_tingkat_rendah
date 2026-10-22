; =========================================================
; m04-if.asm
; Modul 04 -- Percabangan if dengan CMP dan JBE.
; Program .EXE. Mencetak satu kalimat bila syarat terpenuhi.
; Rakit : tasm m04-if.asm
; Link  : tlink m04-if.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
PESAN   DB 'Nilai lebih besar dari lima.', 0Dh, 0Ah, '$'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AL, 7               ; nilai yang diperiksa
        CMP AL, 5               ; bandingkan AL dengan 5
        JBE LEWATI              ; lewati blok bila AL <= 5

        MOV AH, 09h             ; pilih layanan cetak string
        MOV DX, OFFSET PESAN    ; DX = offset kalimat
        INT 21h                 ; cetak kalimat

LEWATI:
        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
