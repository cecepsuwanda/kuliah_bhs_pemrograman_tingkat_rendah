; ============================================================
; operasi-aritmatika.asm
; Mendemonstrasikan ADD, ADC, INC, SUB, SBB, DEC, MUL, dan DIV.
; Program tidak mencetak keluaran; hasil diperiksa pada segmen
; data dengan DEBUG atau emu8086.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    ; --- bilangan 32 bit untuk ADD/ADC ---
    a_lo    DW 0FFFFh
    a_hi    DW 0001h
    b_lo    DW 0001h
    b_hi    DW 0002h
    hasil_lo DW ?
    hasil_hi DW ?

    ; --- bilangan 32 bit untuk SUB/SBB ---
    c_lo    DW 0000h
    c_hi    DW 0005h
    d_lo    DW 0001h
    d_hi    DW 0002h
    kurang_lo DW ?
    kurang_hi DW ?

    ; --- hasil MUL dan DIV ---
    kali    DW ?
    bagi    DB ?
    sisa    DB ?

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; --- ADD dan ADC: 0001FFFFh + 00020001h = 00040000h ---
    MOV AX, a_lo
    ADD AX, b_lo                ; FFFFh + 0001h = 0000h, CF = 1
    MOV hasil_lo, AX
    MOV AX, a_hi
    ADC AX, b_hi                ; 0001h + 0002h + CF = 0004h
    MOV hasil_hi, AX

    ; --- SUB dan SBB: 00050000h - 00020001h = 0002FFFFh ---
    MOV AX, c_lo
    SUB AX, d_lo                ; 0000h - 0001h = FFFFh, CF = 1
    MOV kurang_lo, AX
    MOV AX, c_hi
    SBB AX, d_hi                ; 0005h - 0002h - CF = 0002h
    MOV kurang_hi, AX

    ; --- INC dan DEC ---
    MOV AX, 10
    INC AX                      ; AX = 11
    DEC AX                      ; AX = 10

    ; --- MUL 8 bit: 25 x 4 = 100 ---
    MOV AL, 25
    MOV BL, 4
    MUL BL                      ; AX = 0064h

    ; --- DIV 8 bit: 1000 / 7 = 142 sisa 6 ---
    MOV AX, 1000
    MOV BL, 7
    CMP AH, BL                  ; periksa agar hasil bagi muat di AL
    JAE luapan
    DIV BL                      ; AL = 142, AH = 6
    MOV bagi, AL
    MOV sisa, AH

luapan:
    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h

END START
