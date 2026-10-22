; =========================================================
; m02-baca-baris.asm
; Modul 02 -- Membaca satu baris dengan INT 21h AH=0Ah,
; lalu mencetak kembali isi penyangga dengan AH=02h.
; Program .EXE.
; Rakit : tasm m02-baca-baris.asm
; Link  : tlink m02-baca-baris.obj
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
; Penyangga fungsi 0Ah:
;   byte 0 = kapasitas (termasuk tombol Enter)
;   byte 1 = jumlah karakter yang diketik (diisi DOS)
;   byte 2 = awal isi masukan, diakhiri 0Dh
BUF     DB 40                   ; kapasitas penyangga
        DB 0                    ; jumlah terisi (diisi DOS)
        DB 40 DUP(0)            ; ruang untuk isi masukan

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        MOV AH, 0Ah             ; pilih layanan baca baris
        MOV DX, OFFSET BUF      ; DX = offset awal penyangga
        INT 21h                 ; DOS mengisi jumlah dan isi masukan

        MOV BX, OFFSET BUF+2    ; BX menunjuk karakter pertama
        MOV CL, BUF+1           ; CL = jumlah karakter yang diketik
        MOV CH, 0               ; CX = jumlah karakter

; Pengulangan kecil ini hanya untuk menampilkan isi masukan.
; Bukan materi perulangan dan tidak memakai instruksi LOOP.
ULANG:
        MOV DL, [BX]            ; ambil satu karakter dari penyangga
        MOV AH, 02h             ; pilih layanan cetak satu karakter
        INT 21h                 ; cetak karakter pada DL
        INC BX                  ; maju ke karakter berikutnya
        DEC CX                  ; kurangi jumlah yang tersisa
        JNZ ULANG               ; ulangi selama CX belum nol

        MOV AH, 4Ch             ; pilih layanan akhiri program
        MOV AL, 00h             ; kode keluar 0
        INT 21h                 ; akhiri program .EXE
        END START
