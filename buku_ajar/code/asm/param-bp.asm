; ============================================================
; param-bp.asm
; Membaca dua "parameter" yang diletakkan pada stack melalui
; register BP dengan mode base-relative [BP + disp].
; Segmen default untuk [BP+disp] adalah SS, bukan DS.
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    judul   DB  '1 + 2 = $'         ; judul keluaran

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX                      ; DS menunjuk segmen data

    ; ---------- 1. letakkan dua parameter pada stack ----------
    MOV AX, 0002h                   ; parameter kedua
    PUSH AX                         ; SS:SP <- 2
    MOV AX, 0001h                   ; parameter pertama
    PUSH AX                         ; SS:SP <- 1 (paling atas)

    ; ---------- 2. arahkan BP ke puncak stack ----------
    MOV BP, SP                      ; BP menjadi basis bingkai stack

    MOV AX, [BP+0]                  ; parameter pertama, SS:BP + 0 = 1
    MOV BX, [BP+2]                  ; parameter kedua,   SS:BP + 2 = 2

    ; ---------- 3. jumlahkan kedua parameter ----------
    ADD AX, BX                      ; AX = 1 + 2 = 3

    MOV AH, 09h                     ; cetak judul
    LEA DX, judul                   ; DX = offset string judul
    INT 21h

    MOV DL, AL                      ; hasil penjumlahan ke DL
    ADD DL, '0'                     ; ubah angka menjadi karakter
    MOV AH, 02h                     ; cetak satu karakter hasil
    INT 21h

    ; ---------- 4. bersihkan stack lalu keluar ----------
    POP AX                          ; buang parameter pertama
    POP AX                          ; buang parameter kedua
    MOV AH, 4Ch                     ; terminasi program
    MOV AL, 00h
    INT 21h

END START
