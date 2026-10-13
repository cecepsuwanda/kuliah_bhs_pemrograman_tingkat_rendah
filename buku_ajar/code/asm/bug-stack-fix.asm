; ============================================================
; bug-stack-fix.asm
; VERSI PERBAIKAN dari bug-stack.asm.
;
; Perbaikan      : ditambahkan satu instruksi POP AX sebelum RET,
;                  sehingga jumlah PUSH dan POP seimbang dan RET
;                  mengambil alamat kembali yang benar.
; Hasil          : prosedur mengembalikan kendali ke instruksi
;                  setelah CALL dan pesan "Selesai." tercetak.
; Prosesor       : Intel 8086 (mode real, 16-bit)
; Assembler      : MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    pesan   DB  'Selesai.$'         ; pesan penutup

.CODE
START:
    MOV AX, @DATA                   ; salin alamat segmen data ke AX
    MOV DS, AX                      ; DS diarahkan ke segmen data

    CALL HITUNG                     ; panggil prosedur HITUNG

    MOV AH, 09h                     ; cetak pesan penutup
    LEA DX, pesan                   ; DX = alamat string pesan
    INT 21h

    MOV AH, 4Ch                     ; terminasi program
    MOV AL, 00h
    INT 21h

; ------------------------------------------------------------
; Prosedur HITUNG -- menghitung 1 + 2 dan menyimpannya di CX
; Jumlah PUSH dan POP kini seimbang.
; ------------------------------------------------------------
HITUNG PROC
    PUSH AX                         ; simpan nilai AX lama
    PUSH BX                         ; simpan nilai BX lama
    PUSH CX                         ; simpan nilai CX lama

    MOV AX, 0001h                   ; suku pertama
    MOV BX, 0002h                   ; suku kedua
    ADD AX, BX                      ; AX = 0003h
    MOV CX, AX                      ; CX = hasil perhitungan

    POP CX                          ; pulihkan CX
    POP BX                          ; pulihkan BX
    POP AX                          ; PERBAIKAN: pulihkan AX
    RET                             ; alamat kembali di puncak stack sudah benar
HITUNG ENDP

END START
