; =========================================================
; kali-bagi.asm
; Perkalian dan pembagian 8086 beserta penanganan
; kesalahan divide overflow pada instruksi DIV.
;
; Perakitan : tasm kali-bagi.asm
; Pengaitan : tlink kali-bagi.obj
; =========================================================

.MODEL SMALL
.STACK 100h

.DATA
    pesanMUL  DB 'MUL  : 25 x 4   = $'
    pesanIMUL DB 0Dh, 0Ah, 'IMUL : -3 x 5   = $'
    pesanDIV  DB 0Dh, 0Ah, 'DIV  : 1000 / 7 = $'
    pesanSisa DB '  sisa $'
    pesanOvf  DB 0Dh, 0Ah, 'DIV  : 1000 / 3 = $'
    pesanOvf2 DB 'divide overflow: hasil bagi tidak muat pada AL$'
    bagi      DW ?              ; hasil bagi yang disimpan
    sisa      DW ?              ; sisa pembagian yang disimpan

.CODE
START:
    MOV AX, @DATA               ; inisialisasi register segmen data
    MOV DS, AX

    ; ---------- MUL 8 bit : 25 x 4 ----------
    LEA DX, pesanMUL
    MOV AH, 09h
    INT 21h

    MOV AL, 25                  ; AL = pengali
    MOV BL, 4                   ; BL = operand pengali
    MUL BL                      ; AX = AL x BL = 100
    CALL CETAK_AX               ; hasil 16 bit selalu muat di AX

    ; ---------- IMUL 8 bit : -3 x 5 ----------
    LEA DX, pesanIMUL
    MOV AH, 09h
    INT 21h

    MOV AL, 0FDh                ; 0FDh adalah -3 dalam komplemen dua
    MOV BL, 5                   ; BL = operand bertanda
    IMUL BL                     ; AX = -15 (0FFF1h)
    CALL CETAK_AKS              ; cetak sebagai bilangan bertanda

    ; ---------- DIV 8 bit yang aman : 1000 / 7 ----------
    LEA DX, pesanDIV
    MOV AH, 09h
    INT 21h

    MOV AX, 1000                ; AX = 03E8h, bilangan yang dibagi
    MOV BL, 7                   ; BL = pembagi
    CMP AH, BL                  ; luapan terjadi bila AH >= BL
    JAE LUAPAN                  ; pemeriksaan keselamatan
    DIV BL                      ; AL = 142, AH = 6
    XOR CX, CX
    MOV CL, AL
    MOV bagi, CX                ; simpan hasil bagi
    XOR CX, CX
    MOV CL, AH
    MOV sisa, CX                ; simpan sisa pembagian

    MOV AX, bagi
    CALL CETAK_AX               ; cetak hasil bagi
    LEA DX, pesanSisa
    MOV AH, 09h
    INT 21h
    MOV AX, sisa
    CALL CETAK_AX               ; cetak sisa pembagian

    ; ---------- DIV 8 bit yang melampaui kapasitas : 1000 / 3 ----------
    LEA DX, pesanOvf
    MOV AH, 09h
    INT 21h

    MOV AX, 1000                ; hasil bagi 333 tidak muat pada AL
    MOV BL, 3                   ; BL = pembagi
    CMP AH, BL                  ; AH = 3 dan BL = 3
    JB BAGI_BENAR               ; tidak diambil pada kasus ini
    LEA DX, pesanOvf2           ; laporkan kesalahan dengan pesan
    MOV AH, 09h
    INT 21h
    JMP SELESAI

BAGI_BENAR:
    DIV BL                      ; dijalankan hanya bila aman
    CALL CETAK_AX

SELESAI:
    MOV AH, 4Ch                 ; keluar dan kembalikan ke DOS
    MOV AL, 00h
    INT 21h

LUAPAN:
    ; jalur pemeriksaan keselamatan untuk DIV pertama
    LEA DX, pesanOvf2
    MOV AH, 09h
    INT 21h
    JMP SELESAI

; ---------------------------------------------------------
; CETAK_AX : mencetak isi AX sebagai bilangan desimal tanpa
;            tanda (0 sampai 65535).
; ---------------------------------------------------------
CETAK_AX PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV CX, 0
    MOV BX, 10

CA_BAGI:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CA_BAGI

CA_CETAK:
    POP DX
    ADD DL, 30h
    MOV AH, 02h
    INT 21h
    LOOP CA_CETAK

    POP DX
    POP CX
    POP BX
    POP AX
    RET
CETAK_AX ENDP

; ---------------------------------------------------------
; CETAK_AKS : mencetak isi AX sebagai bilangan desimal
;             bertanda (-32768 sampai 32767). Tanda minus
;             dicetak lebih dahulu, lalu nilai mutlaknya.
; ---------------------------------------------------------
CETAK_AKS PROC
    CMP AX, 0                   ; periksa tanda hasil
    JNS CA_POSITIF
    PUSH AX                     ; simpan hasil negatif
    MOV DL, '-'                 ; cetak tanda minus
    MOV AH, 02h
    INT 21h
    POP AX
    NEG AX                      ; ubah menjadi nilai mutlak

CA_POSITIF:
    CALL CETAK_AX
    RET
CETAK_AKS ENDP

END START
