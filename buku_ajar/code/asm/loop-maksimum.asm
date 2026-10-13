; ============================================================
; loop-maksimum.asm
; Mencari nilai terbesar (maksimum) dalam sebuah larik 16-bit,
; lalu mencetak hasilnya sebagai bilangan desimal.
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
; Struktur  : perulangan LOOP + lompatan bersyarat JAE (tak bertanda)
; ============================================================

.MODEL SMALL                    ; satu segmen kode + satu segmen data
.STACK 100h                     ; 256 byte ruang stack

.DATA
    deret   DW 25, 7, 82, 41, 93, 18, 60, 5   ; larik yang diperiksa
    BANYAK  EQU ($ - deret) / 2               ; banyak elemen = 8
    pesan1  DB 'Nilai maksimum: $'
    pesan2  DB 0Dh, 0Ah, '$'                  ; pindah baris

.CODE
START:
    MOV AX, @DATA               ; AX <- nomor segmen data
    MOV DS, AX                  ; DS menunjuk segmen data

    ; --- 1. siapkan pencarian ---
    LEA SI, deret               ; SI = alamat elemen pertama
    MOV CX, BANYAK - 1          ; sisa elemen yang akan dibandingkan
    MOV AX, [SI]                ; kandidat maksimum = elemen pertama
    ADD SI, 2                   ; maju ke elemen berikutnya (DW = 2 byte)

    ; --- 2. bandingkan setiap elemen dengan kandidat ---
CARI:
    CMP AX, [SI]                ; bandingkan kandidat dengan elemen
    JAE LANJUT                  ; bila kandidat >= elemen: jangan diganti
    MOV AX, [SI]                ; kandidat baru: elemen yang lebih besar
LANJUT:
    ADD SI, 2                   ; SI menunjuk elemen berikutnya
    LOOP CARI                   ; CX--; ulangi selama CX belum nol

    ; --- 3. cetak hasil ---
    MOV AH, 09h                 ; fungsi 09h: cetak string
    LEA DX, pesan1
    INT 21h

    CALL CETAK_DESIMAL          ; cetak isi AX sebagai bilangan desimal

    MOV AH, 09h
    LEA DX, pesan2
    INT 21h

    ; --- 4. keluar dari program ---
    MOV AH, 4Ch                 ; fungsi 4Ch: terminasi program
    MOV AL, 00h                 ; kode keluar: sukses
    INT 21h

; ------------------------------------------------------------
; Prosedur CETAK_DESIMAL
; Mencetak isi register AX sebagai bilangan desimal tanpa tanda.
; Digit dihitung dari belakang (sisa pembagian) lalu disimpan
; ke stack, kemudian dicetak dari depan.
; Register yang berubah: AX, BX, CX, DX.
; ------------------------------------------------------------
CETAK_DESIMAL PROC
    MOV CX, 0                   ; CX = banyak digit yang terkumpul
    MOV BX, 10                  ; pembagi tetap
BAGI:
    XOR DX, DX                  ; bersihkan DX sebelum DIV
    DIV BX                      ; AX = AX / 10, DX = sisa (digit)
    PUSH DX                     ; simpan digit ke stack
    INC CX                      ; tambah satu digit
    CMP AX, 0                   ; apakah angka sudah habis?
    JNE BAGI                    ; ulangi selama AX belum nol

CETAK:
    POP DX                      ; ambil digit paling depan
    ADD DL, '0'                 ; ubah angka 0-9 menjadi karakter
    MOV AH, 02h                 ; fungsi 02h: cetak karakter pada DL
    INT 21h
    LOOP CETAK                  ; CX--; ulangi untuk digit berikutnya
    RET                         ; kembali ke pemanggil
CETAK_DESIMAL ENDP

END START                       ; titik masuk program = label START
