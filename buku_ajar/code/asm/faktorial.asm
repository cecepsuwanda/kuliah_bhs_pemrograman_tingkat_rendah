; ============================================================
; faktorial.asm
; Menghitung n! secara rekursif untuk memperlihatkan bahwa
; rekursi pada assembly bekerja melalui stack yang sama,
; yaitu satu stack frame baru untuk setiap pemanggilan.
;
; Masukan : n = 5 (ubah isi variabel n bila perlu)
; Keluaran: AX = 120 (0078h)
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    n       DW 5            ; masukan faktorial
    hasil   DW 0            ; penampung hasil

.CODE
START:
    MOV AX, @DATA           ; inisialisasi register segmen data
    MOV DS, AX

    PUSH n                  ; dorong argumen n
    CALL Faktorial          ; AX <- n!
    ADD SP, 2               ; pemanggil membersihkan argumen

    MOV hasil, AX           ; simpan hasil (5! = 120 = 0078h)
    MOV BX, AX              ; BX <- hasil, untuk diperiksa di debugger

    ; --- keluar dari program ---
    MOV AH, 4Ch             ; AH = 4Ch : terminasi program
    MOV AL, 00h             ; AL = 00h : kode keluar sukses
    INT 21h

; ------------------------------------------------------------
; Prosedur : Faktorial  (rekursif)
; Masuk   : [BP+4] = n
; Keluar  : AX     = n!
; Aturan  : kasus basis n <= 1 menghasilkan AX = 1
; Rusak   : AX saja; BP dipertahankan
; ------------------------------------------------------------
Faktorial PROC
    PUSH BP                 ; simpan BP milik pemanggil
    MOV BP, SP              ; bangun stack frame baru

    MOV AX, [BP+4]          ; AX <- n
    CMP AX, 1               ; apakah n <= 1 ?
    JBE basis               ; ya -> hentikan rekursi

    DEC AX                  ; AX <- n - 1
    PUSH AX                 ; dorong argumen (n-1)
    CALL Faktorial          ; AX <- (n-1)!  -> rekursi
    ADD SP, 2               ; bersihkan argumen rekursif

    MUL WORD PTR [BP+4]     ; DX:AX <- (n-1)! * n

    POP BP                  ; pulihkan BP milik pemanggil
    RET                     ; kembali ke pemanggil

basis:
    MOV AX, 1               ; 0! = 1! = 1
    POP BP                  ; pulihkan BP milik pemanggil
    RET                     ; kembali ke pemanggil

Faktorial ENDP

END START
