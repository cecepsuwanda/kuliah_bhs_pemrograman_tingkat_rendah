; ============================================================
; prosedur-luas.asm
; Menghitung luas persegi panjang melalui prosedur berparameter.
; Parameter dikirim melalui stack, nilai balik di register AX.
; Prosedur membersihkan sendiri argumennya dengan RET 4.
;
; Masukan : lebar = 5, tinggi = 10
; Keluaran: luas  = 50 (0032h) pada variabel luas dan register AX
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    lebar   DW 5            ; parameter pertama : lebar
    tinggi  DW 10           ; parameter kedua   : tinggi
    luas    DW 0            ; penampung hasil perhitungan

.CODE
START:
    MOV AX, @DATA           ; inisialisasi register segmen data
    MOV DS, AX

    ; --- pemanggil menyiapkan argumen di stack ---
    PUSH tinggi             ; dorong parameter kedua lebih dahulu
    PUSH lebar              ; dorong parameter pertama paling akhir
    CALL HitungLuas         ; panggil prosedur; AX <- lebar * tinggi

    MOV luas, AX            ; simpan nilai balik ke variabel luas
    MOV BX, AX              ; BX <- hasil, untuk diperiksa di debugger

    ; --- keluar dari program ---
    MOV AH, 4Ch             ; AH = 4Ch : terminasi program
    MOV AL, 00h             ; AL = 00h : kode keluar sukses
    INT 21h

; ------------------------------------------------------------
; Prosedur : HitungLuas
; Masuk   : [BP+4] = lebar, [BP+6] = tinggi
; Keluar  : AX     = lebar * tinggi
; Rusak   : AX saja; BP, BX, CX, DX, SI, DI tetap seperti semula
; ------------------------------------------------------------
HitungLuas PROC
    PUSH BP                 ; simpan BP milik pemanggil
    MOV BP, SP              ; BP <- titik acuan stack frame

    MOV AX, [BP+4]          ; AX <- lebar (parameter pertama)
    MUL WORD PTR [BP+6]     ; DX:AX <- AX * tinggi (parameter kedua)

    POP BP                  ; pulihkan BP milik pemanggil
    RET 4                   ; kembali, lalu buang 4 byte argumen

HitungLuas ENDP

END START
