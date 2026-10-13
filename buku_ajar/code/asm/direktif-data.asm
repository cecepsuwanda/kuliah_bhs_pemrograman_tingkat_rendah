; =========================================================
; direktif-data.asm
; Mendemonstrasikan direktif data DB, DW, DD, DUP, dan '$'.
; Perakitan : tasm /l direktif-data.asm
; Pengaitan : tlink /m direktif-data.obj
; =========================================================

.MODEL SMALL            ; model memori: satu segmen kode, satu data
.STACK 100h             ; ruang stack 256 byte

.DATA
    ; --- DB : satu satuan 1 byte ---
    sapaan  DB 'Halo, assembly!', 0Dh, 0Ah, '$'
    panjang EQU $ - sapaan       ; dihitung assembler: 18 byte

    ; --- DW : satu satuan 2 byte, urutan little-endian ---
    ; 4241h disimpan sebagai 41h ('A') lalu 42h ('B')
    kata    DW 4241h, 4443h

    ; --- DD : satu satuan 4 byte ---
    nilai   DD 12345678h

    ; --- DUP : mengulang satu pola ---
    bintang DB 4 DUP('*')

    ; --- '?' : menyediakan ruang tanpa nilai awal ---
    buffer  DB 8 DUP(?)

.CODE
START:
    MOV AX, @DATA            ; salin nomor segmen data
    MOV DS, AX               ; pasang ke register DS

    MOV AH, 09h              ; fungsi 09h: cetak string berakhir '$'
    LEA DX, sapaan
    INT 21h

    MOV AH, 02h              ; fungsi 02h: cetak satu karakter
    MOV DL, BYTE PTR [kata]      ; byte rendah  4241h -> 41h = 'A'
    INT 21h
    MOV DL, BYTE PTR [kata+1]    ; byte tinggi  4241h -> 42h = 'B'
    INT 21h
    MOV DL, BYTE PTR [kata+2]    ; byte rendah  4443h -> 43h = 'C'
    INT 21h
    MOV DL, BYTE PTR [kata+3]    ; byte tinggi  4443h -> 44h = 'D'
    INT 21h

    MOV AH, 02h              ; cetak 4 byte hasil DUP('*')
    MOV DL, BYTE PTR [bintang]
    INT 21h
    MOV DL, BYTE PTR [bintang+1]
    INT 21h
    MOV DL, BYTE PTR [bintang+2]
    INT 21h
    MOV DL, BYTE PTR [bintang+3]
    INT 21h

    MOV AH, 4Ch              ; fungsi 4Ch: akhiri program
    MOV AL, 00h
    INT 21h

END START
