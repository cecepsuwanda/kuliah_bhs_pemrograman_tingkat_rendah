; =========================================================
; hitung-alamat.asm
; Menghitung alamat fisik 20-bit dari pasangan segmen:offset.
; Alamat fisik = (segmen x 16) + offset.
; Hasil 20-bit disimpan pada pasangan register DX:AX,
; dengan DX menampung bit 16..19 dan AX menampung bit 0..15.
; =========================================================
.MODEL SMALL
.STACK 100h

.DATA
    var_nilai   DW 0ABCDh            ; variabel contoh pada segmen data
    nomor_seg   DW ?                 ; penampung nomor segmen
    nomor_off   DW ?                 ; penampung offset
    fisik_hi    DW ?                 ; penampung bit 16..19
    fisik_lo    DW ?                 ; penampung bit 0..15
    pesan_seg   DB 'Segmen: $'
    pesan_off   DB 0Dh, 0Ah, 'Offset: $'
    pesan_fis   DB 0Dh, 0Ah, 'Alamat fisik: $'
    buffer      DB '0000$'

.CODE
START:
    MOV AX, @DATA                    ; inisialisasi register DS
    MOV DS, AX

; --- 1. ambil dan tampilkan nomor segmen -----------------
    MOV AX, seg var_nilai            ; AX = nomor segmen var_nilai
    MOV nomor_seg, AX
    MOV AH, 09h
    LEA DX, pesan_seg
    INT 21h
    MOV AX, nomor_seg
    CALL cetak_hex

; --- 2. ambil dan tampilkan offset -----------------------
    MOV AX, OFFSET var_nilai         ; AX = offset var_nilai
    MOV nomor_off, AX
    MOV AH, 09h
    LEA DX, pesan_off
    INT 21h
    MOV AX, nomor_off
    CALL cetak_hex

; --- 3. hitung alamat fisik: (segmen x 16) + offset ------
    MOV AX, nomor_seg                ; AX = segmen
    MOV BX, nomor_off                ; BX = offset
    MOV DX, AX                       ; DX akan menerima bit 16..19
    MOV CL, 4
    SHR DX, CL                       ; DX = segmen / 16
    SHL AX, CL                       ; AX = segmen x 16
    ADD AX, BX                       ; tambahkan offset
    ADC DX, 0                        ; simpan carry ke DX
    MOV fisik_hi, DX
    MOV fisik_lo, AX

; --- 4. tampilkan alamat fisik ---------------------------
    MOV AH, 09h
    LEA DX, pesan_fis
    INT 21h
    MOV AX, fisik_hi
    CALL cetak_hex
    MOV AX, fisik_lo
    CALL cetak_hex

    MOV AH, 02h                      ; akhiri baris terakhir
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

    MOV AH, 4Ch                      ; keluar dari program
    MOV AL, 00h
    INT 21h

; ---------------------------------------------------------
; cetak_hex : mencetak isi AX sebagai 4 digit heksadesimal
; Masukan   : AX = nilai 16-bit yang akan dicetak
; ---------------------------------------------------------
cetak_hex PROC
    PUSH BX
    PUSH CX
    PUSH DX

    LEA BX, buffer                   ; BX menunjuk penampung hasil
    MOV CX, 4                        ; empat digit heksadesimal
ulang:
    ROL AX, 4                        ; pindahkan 4 bit tertinggi ke bawah
    MOV DL, AL
    AND DL, 0Fh                      ; sisakan 4 bit terbawah saja
    CMP DL, 9
    JBE angka                        ; 0..9 sudah berupa digit
    ADD DL, 7                        ; 0Ah..0Fh digeser ke 'A'..'F'
angka:
    ADD DL, '0'                      ; ubah menjadi kode ASCII
    MOV [BX], DL                     ; simpan digit ke buffer
    INC BX
    LOOP ulang

    MOV AH, 09h                      ; cetak isi buffer
    LEA DX, buffer
    INT 21h

    POP DX
    POP CX
    POP BX
    RET
cetak_hex ENDP

END START
