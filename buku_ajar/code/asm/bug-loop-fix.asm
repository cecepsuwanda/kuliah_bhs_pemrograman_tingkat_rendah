; ============================================================
; bug-loop-fix.asm
; VERSI PERBAIKAN dari bug-loop.asm.
;
; Perbaikan      : instruksi INC CX dihapus. Instruksi LOOP sudah
;                  mengurangi CX sendiri, sehingga penghitung menurun
;                  secara teratur dari 5 sampai 0.
; Hasil          : AX = 15 (0Fh), dicetak sebagai dua digit desimal.
; Prosesor       : Intel 8086 (mode real, 16-bit)
; Assembler      : MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    pesan   DB  'Jumlah 1..5 = $'   ; judul keluaran

.CODE
START:
    MOV AX, @DATA                   ; salin alamat segmen data ke AX
    MOV DS, AX                      ; DS diarahkan ke segmen data

    XOR AX, AX                      ; AX = akumulator jumlah, mulai dari 0
    MOV CX, 5                       ; CX = penghitung, mulai dari 5

ULANG:
    ADD AX, CX                      ; tambahkan nilai penghitung ke akumulator
    LOOP ULANG                      ; CX berkurang otomatis tiap iterasi

    MOV BX, AX                      ; BX = hasil penjumlahan (15)
    MOV AH, 09h                     ; cetak judul
    LEA DX, pesan
    INT 21h

    MOV AX, BX                      ; AX = hasil, untuk pembagian
    MOV BL, 10                      ; pembagi 10
    DIV BL                          ; AL = puluhan, AH = satuan
    MOV BH, AH                      ; simpan satuan di BH
    MOV DL, AL                      ; DL = digit puluhan
    ADD DL, '0'                     ; ubah menjadi karakter ASCII
    MOV AH, 02h                     ; cetak satu karakter
    INT 21h

    MOV DL, BH                      ; DL = digit satuan
    ADD DL, '0'                     ; ubah menjadi karakter ASCII
    MOV AH, 02h                     ; cetak satu karakter
    INT 21h

    MOV AH, 4Ch                     ; terminasi program
    MOV AL, 00h
    INT 21h

END START
