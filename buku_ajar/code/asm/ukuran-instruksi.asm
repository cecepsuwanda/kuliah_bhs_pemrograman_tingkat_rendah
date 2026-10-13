; ============================================================
; ukuran-instruksi.asm
; Membandingkan jumlah byte dua bentuk penulisan yang hasilnya
; sama: AX = BX = 1.
;   Bentuk A : dua nilai segera          -> 3 + 3 = 6 byte
;   Bentuk B : satu nilai segera + salin -> 3 + 2 = 5 byte
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; Bentuk   : program .COM (satu segmen, ORG 100h)
; ============================================================

.MODEL TINY                 ; seluruh program dalam satu segmen
.CODE
ORG 100h                    ; program .COM dimulai pada offset 100h

START:
    ; ---------- bentuk A : dua nilai segera (6 byte) ----------
    MOV AX, 0001h           ; B8 01 00 : nilai 1 ke AX (3 byte)
    MOV BX, 0001h           ; BB 01 00 : nilai 1 ke BX (3 byte)

    ; ---------- bentuk B : satu nilai segera + salinan (5 byte) -
    MOV BX, 0001h           ; BB 01 00 : nilai 1 ke BX (3 byte)
    MOV AX, BX              ; 89 D8    : salin BX ke AX (2 byte)

    ; ---------- tampilkan pesan ----------
    MOV AH, 09h             ; B4 09    : fungsi cetak string
    MOV DX, OFFSET pesan    ; BA xx xx : DX = offset string
    INT 21h                 ; CD 21    : panggil interupsi DOS

    ; ---------- keluar dari program ----------
    MOV AH, 4Ch             ; B4 4C    : fungsi terminasi
    MOV AL, 00h             ; B0 00    : kode keluar 0
    INT 21h                 ; CD 21    : panggil interupsi DOS

pesan DB 'Dua bentuk, hasil sama, ukuran berbeda.', 0Dh, 0Ah, '$'
END START                   ; titik masuk program = label START
