; ============================================================
; transfer-data.asm
; Mendemonstrasikan MOV, LEA, XCHG, CMP, XLAT, CBW, dan CWD.
; Program tidak mencetak keluaran; hasil diperiksa pada register
; dengan Single Step emu8086 atau DEBUG.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    nilai1  DW 1234h                 ; data pertama
    nilai2  DW 5678h                 ; data kedua
    tabel   DB '0','1','2','3','4','5','6','7','8','9'
    hasil   DB ?                     ; penampung hasil XLAT

.CODE
START:
    MOV AX, @DATA                    ; inisialisasi segmen data
    MOV DS, AX

    ; --- MOV dan XCHG ---
    MOV AX, nilai1                   ; AX = 1234h
    MOV BX, nilai2                   ; BX = 5678h
    XCHG AX, BX                      ; AX = 5678h, BX = 1234h

    ; --- LEA dan akses tidak langsung ---
    LEA SI, nilai1                   ; SI = offset nilai1
    MOV CX, [SI]                     ; CX = isi nilai1 = 1234h

    ; --- XLAT: menerjemahkan indeks menjadi karakter ---
    LEA BX, tabel                    ; BX = awal tabel
    MOV AL, 4                        ; indeks ke-4
    XLATB                            ; AL = tabel[4] = '4'
    MOV hasil, AL                    ; simpan hasil

    ; --- CBW: AL -> AX (8 bit bertanda menjadi 16 bit) ---
    MOV AL, 0FEh                     ; AL = -2
    CBW                              ; AX = FFFEh

    ; --- CWD: AX -> DX:AX (16 bit bertanda menjadi 32 bit) ---
    MOV AX, -2                       ; AX = FFFEh
    CWD                              ; DX = FFFFh

    ; --- CMP: membandingkan tanpa mengubah operand ---
    MOV AX, nilai1
    CMP AX, nilai2                   ; bandingkan 1234h dengan 5678h

    ; --- keluar dari program ---
    MOV AH, 4Ch
    MOV AL, 00h
    INT 21h

END START
