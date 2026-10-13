; ============================================================
; paritas.asm
; Menentukan paritas sebuah byte dengan menghitung cacah bit 1.
;   - paritas GENAP  bila cacah bit 1 genap;
;   - paritas GANJIL bila cacah bit 1 ganjil.
; Metode: geser logis (SHR) delapan kali, lalu jumlahkan bit yang
; keluar ke CF dengan instruksi ADC.
; Byte uji 1011 0110b memiliki lima bit 1 -> paritas GANJIL.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    nilai   DB 10110110b                      ; byte yang diperiksa
    pesan1  DB 'Byte 10110110b berparitas: $'
    genap   DB 'GENAP', 0Dh, 0Ah, '$'
    ganjil  DB 'GANJIL', 0Dh, 0Ah, '$'

.CODE
START:
    MOV AX, @DATA           ; inisialisasi register segmen data
    MOV DS, AX

    ; --- cetak teks pembuka ---
    MOV AH, 09h             ; AH = 09h : cetak string
    LEA DX, pesan1          ; DX <- alamat string pembuka
    INT 21h

    ; --- hitung cacah bit 1 pada byte uji ---
    MOV AL, nilai           ; AL <- byte yang diperiksa
    MOV BL, 0               ; BL <- penghitung cacah bit 1
    MOV CX, 8               ; periksa delapan bit

ULANG:
    SHR AL, 1               ; bit terkanan pindah ke CF
    ADC BL, 0               ; BL <- BL + CF (tanpa membawa sisa)
    LOOP ULANG              ; ulangi sampai CX habis

    ; --- tentukan pesan berdasarkan bit terendah cacah ---
    TEST BL, 1              ; periksa bit 0 dari cacah bit 1
    JNZ CETAK_GANJIL        ; ZF = 0 -> cacah ganjil

    MOV AH, 09h             ; cacah genap
    LEA DX, genap
    INT 21h
    JMP SELESAI

CETAK_GANJIL:
    MOV AH, 09h             ; cacah ganjil
    LEA DX, ganjil
    INT 21h

SELESAI:
    MOV AH, 4Ch             ; AH = 4Ch : terminasi program
    MOV AL, 00h             ; kode keluar sukses
    INT 21h

END START
