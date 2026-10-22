; =========================================================
; m01-cetak-kalimat.asm
; Modul 01 -- Mencetak kalimat dengan INT 21h AH=09h.
; Program .EXE.
; Rakit : tasm m01-cetak-kalimat.asm
; Link  : tlink m01-cetak-kalimat.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h
        .DATA
; 0Dh = kembali ke awal baris, 0Ah = turun satu baris.
; Tanda $ menandai akhir string dan tidak ikut dicetak.
PESAN   DB 'Praktikum Bahasa Pemrograman Tingkat Rendah', 0Dh, 0Ah
        DB 'Modul 01: keluaran dengan INT 21h.', 0Dh, 0Ah, '$'
        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data
        MOV AH, 09h             ; pilih layanan cetak string
        MOV DX, OFFSET PESAN    ; DX = offset awal string
        INT 21h                 ; DOS mencetak sampai tanda $
        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
