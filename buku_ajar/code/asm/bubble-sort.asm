; ============================================================
; bubble-sort.asm
; Mengurutkan larik delapan byte secara menaik (ascending) dengan
; algoritme pengurutan gelembung, lalu mencetak hasilnya.
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
; Struktur  : perulangan bersarang (LOOP bertingkat) + JBE
; ============================================================

.MODEL SMALL                    ; satu segmen kode + satu segmen data
.STACK 100h                     ; 256 byte ruang stack

.DATA
    deret  DB 7, 3, 9, 1, 8, 2, 6, 4   ; larik yang akan diurutkan
    BANYAK EQU $-deret                 ; banyak elemen = 8
    pesan  DB 'Hasil pengurutan: $'
    baris  DB 0Dh, 0Ah, '$'            ; pindah baris

.CODE
START:
    MOV AX, @DATA               ; AX <- nomor segmen data
    MOV DS, AX                  ; DS menunjuk segmen data

    ; --- 1. perulangan luar: lintasan sebanyak n - 1 ---
    MOV CX, BANYAK - 1          ; banyak lintasan pengurutan

LINTASAN:
    PUSH CX                     ; simpan pencacah lintasan ke stack
    MOV SI, 0                   ; SI = indeks elemen kiri
    MOV DI, 1                   ; DI = indeks elemen kanan
    MOV CX, BANYAK - 1          ; banyak pembandingan per lintasan

BANDING:
    MOV AL, deret[SI]           ; AL = elemen kiri
    MOV BL, deret[DI]           ; BL = elemen kanan
    CMP AL, BL                  ; bandingkan kedua elemen
    JBE TIDAK_TUKAR             ; AL <= BL berarti sudah urut

    MOV deret[SI], BL           ; tukar: elemen kanan pindah ke kiri
    MOV deret[DI], AL           ;        elemen kiri pindah ke kanan

TIDAK_TUKAR:
    INC SI                      ; maju ke pasangan berikutnya
    INC DI
    LOOP BANDING                ; CX--; ulangi pembandingan

    POP CX                      ; ambil kembali pencacah lintasan
    LOOP LINTASAN               ; ulangi lintasan berikutnya

    ; --- 2. cetak larik hasil pengurutan ---
    MOV AH, 09h                 ; fungsi 09h: cetak string
    LEA DX, pesan
    INT 21h

    MOV CX, BANYAK              ; cetak sebanyak n elemen
    MOV SI, 0
    MOV AH, 02h                 ; fungsi 02h: cetak karakter

CETAK:
    MOV DL, deret[SI]           ; ambil satu elemen
    ADD DL, '0'                 ; ubah angka 0-9 menjadi karakter
    INT 21h
    MOV DL, ' '                 ; pemisah antarelemen
    INT 21h
    INC SI                      ; maju ke elemen berikutnya
    LOOP CETAK                  ; CX--; ulangi untuk semua elemen

    MOV AH, 09h
    LEA DX, baris
    INT 21h

    ; --- 3. keluar dari program ---
    MOV AH, 4Ch                 ; fungsi 4Ch: terminasi program
    MOV AL, 00h                 ; kode keluar: sukses
    INT 21h

END START                       ; titik masuk program = label START
