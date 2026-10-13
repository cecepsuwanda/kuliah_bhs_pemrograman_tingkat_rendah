; ============================================================
; xor-cipher.asm
; Enkripsi dan dekripsi sebuah string dengan XOR satu kunci.
;   - enkripsi : setiap byte di-XOR dengan kunci;
;   - dekripsi : hasil enkripsi di-XOR ulang dengan kunci yang sama.
; Sifat A XOR K XOR K = A membuat proses ini dapat dibalik.
; Kunci 20h dipilih agar hasil enkripsi tetap tercetak sebagai
; karakter yang dapat dibaca (huruf besar menjadi huruf kecil).
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    kunci   DB 20h                  ; kunci XOR untuk seluruh string
    asli    DB 'BELAJARASM$'        ; teks asli, diakhiri penanda '$'
    buffer  DB 20 DUP('?')          ; penampung hasil enkripsi
    pesan1  DB 'Teks asli    : $'
    pesan2  DB 0Dh, 0Ah, 'Terenkripsi  : $'
    pesan3  DB 0Dh, 0Ah, 'Terdekripsi  : $'

.CODE
START:
    MOV AX, @DATA                   ; inisialisasi register segmen data
    MOV DS, AX

    ; --- 1. tampilkan teks asli ---
    MOV AH, 09h
    LEA DX, pesan1
    INT 21h
    MOV AH, 09h
    LEA DX, asli
    INT 21h

    ; --- 2. enkripsi tiap byte dengan XOR ---
    LEA SI, asli                    ; SI <- penunjuk byte sumber
    LEA DI, buffer                  ; DI <- penunjuk byte tujuan

ENKRIPSI:
    MOV AL, [SI]                    ; ambil satu byte teks asli
    CMP AL, '$'                     ; sudah sampai penanda akhir?
    JE  TAMPIL_ENK                  ; ya -> hentikan perulangan
    XOR AL, kunci                   ; XOR dengan kunci
    MOV [DI], AL                    ; simpan byte terenkripsi
    INC SI                          ; maju ke byte berikutnya
    INC DI
    JMP ENKRIPSI

TAMPIL_ENK:
    MOV BYTE PTR [DI], '$'          ; tutup string terenkripsi
    MOV AH, 09h
    LEA DX, pesan2
    INT 21h
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; --- 3. dekripsi dengan XOR ulang pada tempat yang sama ---
    LEA SI, buffer                  ; SI <- penunjuk hasil enkripsi

DEKRIPSI:
    MOV AL, [SI]                    ; ambil satu byte terenkripsi
    CMP AL, '$'                     ; sudah sampai penanda akhir?
    JE  TAMPIL_DEK                  ; ya -> hentikan perulangan
    XOR AL, kunci                   ; XOR kedua mengembalikan data asli
    MOV [SI], AL                    ; tulis kembali di tempat yang sama
    INC SI
    JMP DEKRIPSI

TAMPIL_DEK:
    MOV AH, 09h
    LEA DX, pesan3
    INT 21h
    MOV AH, 09h
    LEA DX, buffer
    INT 21h

    ; --- 4. keluar dari program ---
    MOV AH, 4Ch                     ; AH = 4Ch : terminasi program
    MOV AL, 00h
    INT 21h

END START
