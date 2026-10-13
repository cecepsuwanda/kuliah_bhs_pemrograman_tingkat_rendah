; ============================================================
; bug-stack.asm
; PROGRAM BER-BUG (sengaja salah) -- jangan dipakai sebagai contoh baku.
;
; Maksud program : memanggil prosedur HITUNG (1 + 2 = 3), lalu
;                  mencetak pesan "Selesai.".
; Gejala         : program melompat ke alamat sampah dan macet;
;                  pesan "Selesai." tidak pernah tercetak.
; Penyebab       : prosedur menekan (PUSH) tiga register tetapi hanya
;                  memulihkan (POP) dua. Stack menjadi tidak seimbang,
;                  sehingga RET mengambil nilai yang bukan alamat kembali.
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

    MOV AH, 09h                     ; baris ini tidak pernah dicapai
    LEA DX, pesan                   ; DX = alamat string pesan
    INT 21h                         ; cetak pesan penutup

    MOV AH, 4Ch                     ; terminasi program
    MOV AL, 00h
    INT 21h

; ------------------------------------------------------------
; Prosedur HITUNG -- menghitung 1 + 2 dan menyimpannya di CX
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
    ; BUG: POP AX untuk memulihkan AX tidak ada di sini
    RET                             ; RET mengambil nilai AX lama, bukan alamat kembali
HITUNG ENDP

END START
