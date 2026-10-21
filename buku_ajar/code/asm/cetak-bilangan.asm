; ============================================================
; cetak-bilangan.asm
; Mencetak satu bilangan word dalam bentuk desimal dan
; heksadesimal dengan layanan DOS INT 21h fungsi 02h.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    pesan1  DB 'Desimal: $'
    pesan2  DB 0Dh, 0Ah, 'Heksadesimal: $'
    nilai   DW 12345                 ; 12345 = 3039h

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; --- cetak label desimal ---
    MOV AH, 09h
    LEA DX, pesan1
    INT 21h

    MOV AX, nilai
    CALL CETAK_DESIMAL

    ; --- cetak label heksadesimal ---
    MOV AH, 09h
    LEA DX, pesan2
    INT 21h

    MOV AX, nilai
    CALL CETAK_HEX

    ; --- keluar ---
    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h

; ------------------------------------------------------------
; CETAK_DESIMAL : mencetak AX sebagai bilangan desimal tanpa tanda
; ------------------------------------------------------------
CETAK_DESIMAL PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0                       ; cacah digit
    MOV BX, 10                      ; pembagi
BAGI:
    XOR DX, DX                      ; DX:AX siap dibagi
    DIV BX                          ; AX = hasil bagi, DX = sisa
    PUSH DX                         ; simpan digit
    INC CX
    CMP AX, 0
    JNE BAGI

CETAK_DIGIT:
    POP DX
    ADD DL, '0'                     ; ubah digit menjadi karakter
    MOV AH, 02h
    INT 21h
    LOOP CETAK_DIGIT

    POP DX
    POP CX
    POP BX
    POP AX
    RET
CETAK_DESIMAL ENDP

; ------------------------------------------------------------
; CETAK_HEX : mencetak AX sebagai empat digit heksadesimal
; ------------------------------------------------------------
CETAK_HEX PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 4                       ; empat digit
HEX_ULANG:
    ROL AX, 4                       ; pindahkan 4 bit tertinggi ke bawah
    MOV DL, AL
    AND DL, 0Fh                     ; ambil empat bit rendah
    CMP DL, 9
    JBE HEX_ANGKA
    ADD DL, 7                       ; A-F
HEX_ANGKA:
    ADD DL, '0'
    MOV AH, 02h
    INT 21h
    LOOP HEX_ULANG

    POP DX
    POP CX
    POP BX
    POP AX
    RET
CETAK_HEX ENDP

END START
