; ============================================================
; input-nama.asm
; Meminta nama pengguna dengan INT 21h fungsi 0Ah (input string
; berpenyangga), lalu menyapa pengguna dengan nama tersebut.
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    tanya   DB  'Siapa nama Anda? $'          ; pertanyaan pembuka
    sapaan  DB  0Dh, 0Ah, 'Halo, $'           ; awal kalimat sapaan
    nama    DB  20                            ; byte 0: kapasitas maksimum
            DB  0                             ; byte 1: jumlah terisi (diisi DOS)
            DB  20 DUP(0)                     ; byte 2..: isi nama yang diketik
    penutup DB  '! Selamat belajar assembly.', 0Dh, 0Ah, '$'

.CODE
START:
    ; ---------- 1. inisialisasi register segmen data ----------
    MOV AX, @DATA
    MOV DS, AX                          ; DS menunjuk segmen .DATA

    ; ---------- 2. cetak pertanyaan ----------
    MOV AH, 09h                         ; fungsi 09h: cetak string '$'
    LEA DX, tanya                       ; DX = offset string pertanyaan
    INT 21h

    ; ---------- 3. baca nama pengguna ----------
    MOV AH, 0Ah                         ; fungsi 0Ah: input string berpenyangga
    LEA DX, nama                        ; DX = offset awal penyangga
    INT 21h                             ; DOS mengisi byte 1 dan byte 2..

    ; ---------- 4. sisipkan tanda '$' sesudah nama ----------
    LEA SI, nama                        ; SI menunjuk awal penyangga
    MOV BL, [SI+1]                      ; BL = jumlah karakter yang diketik
    MOV BH, 0                           ; BH = 0, sehingga BX = jumlah karakter
    ADD SI, 2                           ; SI menunjuk karakter pertama nama
    ADD SI, BX                          ; SI menunjuk sesudah karakter terakhir
    MOV BYTE PTR [SI], '$'              ; ganti 0Dh dengan penanda akhir '$'

    ; ---------- 5. cetak sapaan beserta nama ----------
    MOV AH, 09h
    LEA DX, sapaan                      ; cetak "Halo, "
    INT 21h

    MOV AH, 09h
    LEA DX, nama+2                      ; cetak nama yang diketik pengguna
    INT 21h

    MOV AH, 09h
    LEA DX, penutup                     ; cetak penutup kalimat
    INT 21h

    ; ---------- 6. akhiri program ----------
    MOV AH, 4Ch                         ; fungsi 4Ch: terminasi program
    MOV AL, 00h                         ; AL = 0, keluar tanpa kesalahan
    INT 21h

END START
