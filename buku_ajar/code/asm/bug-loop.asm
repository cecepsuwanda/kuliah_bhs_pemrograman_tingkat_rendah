; ============================================================
; bug-loop.asm
; PROGRAM BER-BUG (sengaja salah) -- jangan dipakai sebagai contoh baku.
;
; Maksud program : menjumlahkan bilangan 1 sampai 5 (hasil benar = 15).
; Gejala         : program tidak pernah selesai (loop tak berujung).
; Penyebab       : penghitung CX dinaikkan di dalam badan loop,
;                  sedangkan instruksi LOOP selalu menguranginya.
;                  Akibatnya CX tidak pernah mencapai nol.
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
    INC CX                          ; BUG: penghitung dinaikkan, bukan dibiarkan menurun
    LOOP ULANG                      ; LOOP mengurangi CX, lalu melompat bila CX <> 0

    MOV AH, 09h                     ; baris ini tidak pernah dicapai
    LEA DX, pesan                   ; DX = alamat string judul
    INT 21h                         ; cetak judul keluaran

    MOV AH, 4Ch                     ; terminasi program
    MOV AL, 00h
    INT 21h

END START
