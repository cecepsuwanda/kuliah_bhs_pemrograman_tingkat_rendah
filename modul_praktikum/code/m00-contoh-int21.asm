; =========================================================
; m00-contoh-int21.asm
; Modul 00 -- Contoh program .COM dengan layanan INT 21h.
; Program ini hanya dibaca pada Modul 00; mahasiswa belum menulis
; atau merakit program.
; =========================================================
        .MODEL TINY
        .CODE
        ORG 100h

START:
        JMP MULAI               ; lompati data agar tidak dieksekusi

; Setiap karakter menempati satu byte. 0Dh dan 0Ah memindahkan
; kursor ke awal baris berikutnya. Tanda $ menutup string.
PESAN   DB 'Selamat datang di praktikum 8086.', 0Dh, 0Ah
        DB 'Modul 00: register dan interupsi.', '$'

MULAI:
        MOV AH, 09h             ; AH memilih layanan cetak string
        MOV DX, OFFSET PESAN    ; DX menyimpan offset awal string
        INT 21h                 ; DOS mengerjakan layanan

        MOV AH, 02h             ; AH memilih layanan cetak karakter
        MOV DL, '!'             ; DL menyimpan karakter yang dicetak
        INT 21h                 ; DOS mencetak karakter pada DL

        INT 20h                 ; akhiri program .COM
        END START
