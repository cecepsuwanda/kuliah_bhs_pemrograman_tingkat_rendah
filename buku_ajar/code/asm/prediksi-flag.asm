; ============================================================
; prediksi-flag.asm
; Program pengamatan register dan flag.
; Dua penjumlahan dijalankan untuk memicu kondisi flag berbeda.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL                ; model memori: satu segmen kode + satu segmen data
.STACK 100h                 ; sediakan 256 byte ruang stack

.DATA
    hasil1  DW  0                                   ; penampung hasil kasus 1
    hasil2  DW  0                                   ; penampung hasil kasus 2
    pesan   DB  'Pengamatan flag selesai.', 0Dh, 0Ah, '$'

.CODE
START:
    ; --- inisialisasi register segmen data ---
    MOV AX, @DATA           ; alamat segmen .DATA
    MOV DS, AX              ; DS harus menunjuk ke .DATA

    ; --- kasus 1: 7FFFh + 0001h (overflow bertanda 16-bit) ---
    MOV AX, 7FFFh           ; AX = 7FFFh  (+32767)
    MOV BX, 0001h           ; BX = 0001h  (+1)
    ADD AX, BX              ; AX = 8000h -> SF=1, OF=1, CF=0, ZF=0
    MOV hasil1, AX          ; MOV tidak mengubah flag

    ; --- kasus 2: 8000h + 8000h (carry tak bertanda) ---
    MOV AX, 8000h           ; AX = 8000h  (-32768)
    MOV BX, 8000h           ; BX = 8000h  (-32768)
    ADD AX, BX              ; AX = 0000h -> CF=1, ZF=1, OF=1, SF=0
    MOV hasil2, AX          ; simpan hasil untuk diperiksa

    ; --- cetak pesan penutup ---
    MOV AH, 09h             ; AH = 09h : cetak string berakhir '$'
    LEA DX, pesan           ; DX = offset string pesan
    INT 21h                 ; panggil layanan DOS

    ; --- keluar dari program ---
    MOV AH, 4Ch             ; AH = 4Ch : terminasi program
    MOV AL, 00h             ; AL = kode keluar (0 = sukses)
    INT 21h

END START                   ; titik masuk program = label START
