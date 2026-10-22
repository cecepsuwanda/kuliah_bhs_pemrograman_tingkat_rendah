; =========================================================
; m01-cetak-karakter.asm
; Modul 01 -- Mencetak satu karakter dengan INT 21h AH=02h.
; Program .COM.
; Rakit : tasm m01-cetak-karakter.asm
; Link  : tlink /t m01-cetak-karakter.obj
; =========================================================
        .MODEL TINY
        .CODE
        ORG 100h
MULAI:
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        MOV DL, 'A'             ; karakter yang akan dicetak
        INT 21h                 ; DOS mencetak karakter pada DL
        INT 20h                 ; akhiri program .COM
        END MULAI
