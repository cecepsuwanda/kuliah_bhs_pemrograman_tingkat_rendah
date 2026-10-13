; =========================================================
; aritmatika.asm
; Kalkulator penjumlahan dan pengurangan dua bilangan
; satu digit yang dimasukkan pengguna melalui papan tombol.
;
; Perakitan : tasm aritmatika.asm
; Pengaitan : tlink aritmatika.obj
; =========================================================

.MODEL SMALL
.STACK 100h

.DATA
    tanya1   DB 'Masukkan angka pertama (0-9): $'
    tanya2   DB 0Dh, 0Ah, 'Masukkan angka kedua   (0-9): $'
    pesanT   DB 0Dh, 0Ah, 'Hasil tambah : $'
    pesanK   DB 0Dh, 0Ah, 'Hasil kurang : $'
    nilai1   DW ?               ; bilangan pertama sebagai word
    nilai2   DW ?               ; bilangan kedua sebagai word

.CODE
START:
    MOV AX, @DATA               ; inisialisasi register segmen data
    MOV DS, AX

    ; ---------- masukan bilangan pertama ----------
    LEA DX, tanya1              ; tampilkan pertanyaan pertama
    MOV AH, 09h
    INT 21h

    MOV AH, 01h                 ; baca satu karakter dari papan tombol
    INT 21h
    SUB AL, 30h                 ; ubah kode ASCII menjadi nilai 0-9
    XOR AH, AH                  ; nolkan AH agar AX berisi nilai penuh
    MOV nilai1, AX              ; simpan bilangan pertama

    ; ---------- masukan bilangan kedua ----------
    LEA DX, tanya2              ; tampilkan pertanyaan kedua
    MOV AH, 09h
    INT 21h

    MOV AH, 01h
    INT 21h
    SUB AL, 30h
    XOR AH, AH
    MOV nilai2, AX              ; simpan bilangan kedua

    ; ---------- penjumlahan 16 bit ----------
    MOV AX, nilai1              ; AX = bilangan pertama
    ADD AX, nilai2              ; AX = AX + bilangan kedua
    MOV BX, AX                  ; simpan hasil tambah di BX

    LEA DX, pesanT              ; cetak judul hasil tambah
    MOV AH, 09h
    INT 21h
    MOV AX, BX                  ; ambil kembali hasil tambah
    CALL CETAK_AX               ; cetak AX sebagai bilangan desimal

    ; ---------- pengurangan 16 bit ----------
    LEA DX, pesanK              ; cetak judul hasil kurang
    MOV AH, 09h
    INT 21h

    MOV AX, nilai1              ; AX = bilangan pertama
    SUB AX, nilai2              ; AX = AX - bilangan kedua
    JNS CETAK_KURANG            ; bila hasil positif, langsung cetak
    PUSH AX                     ; simpan hasil sementara
    MOV DL, '-'                 ; cetak tanda minus
    MOV AH, 02h
    INT 21h
    POP AX
    NEG AX                      ; ubah menjadi nilai mutlak

CETAK_KURANG:
    CALL CETAK_AX               ; cetak hasil pengurangan

    ; ---------- akhiri program ----------
    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h

; ---------------------------------------------------------
; CETAK_AX : mencetak isi AX sebagai bilangan desimal tanpa
;            tanda (0 sampai 65535).
; Masukan  : AX = nilai yang akan dicetak
; Keluaran : deretan digit pada layar
; ---------------------------------------------------------
CETAK_AX PROC
    PUSH AX                     ; simpan register yang akan dipakai
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0                   ; CX = cacah digit yang tersimpan
    MOV BX, 10                  ; BX = pembagi desimal

BAGI_DIGIT:
    XOR DX, DX                  ; siapkan DX:AX sebagai yang dibagi
    DIV BX                      ; AX = hasil bagi, DX = sisa
    PUSH DX                     ; simpan digit pada stack
    INC CX                      ; tambah cacah digit
    CMP AX, 0
    JNE BAGI_DIGIT              ; ulangi sampai hasil bagi nol

CETAK_DIGIT:
    POP DX                      ; ambil digit terakhir yang dihitung
    ADD DL, 30h                 ; ubah nilai menjadi kode ASCII
    MOV AH, 02h
    INT 21h                     ; cetak satu karakter
    LOOP CETAK_DIGIT            ; ulangi untuk setiap digit

    POP DX                      ; pulihkan register semula
    POP CX
    POP BX
    POP AX
    RET
CETAK_AX ENDP

END START
