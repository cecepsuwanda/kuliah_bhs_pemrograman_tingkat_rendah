; =========================================================
; alamat-fisik.asm
; Menampilkan offset setiap variabel pada segmen data.
; Mahasiswa membaca offset tersebut, lalu menghitung alamat
; fisiknya dengan rumus:  Fisik = (DS x 16) + Offset
;
; Rakit   : TASM alamat-fisik.asm
; Gabungkan: TLINK alamat-fisik.obj
; =========================================================
.MODEL SMALL
.STACK 100h

.DATA
    var_byte  DB 10h                 ; variabel satu byte
    var_word  DW 1234h               ; variabel satu word
    tanya1    DB 'Offset var_byte = $'
    tanya2    DB 0Dh, 0Ah, 'Offset var_word = $'
    buffer    DB '0000$'             ; penampung 4 digit heksadesimal

.CODE
START:
    MOV AX, @DATA                    ; inisialisasi register DS
    MOV DS, AX

    MOV AH, 09h                      ; cetak teks pengantar pertama
    LEA DX, tanya1
    INT 21h

    MOV AX, OFFSET var_byte          ; AX = offset var_byte
    CALL cetak_hex                   ; tampilkan sebagai 4 digit hex

    MOV AH, 09h                      ; cetak teks pengantar kedua
    LEA DX, tanya2                   ; (dimulai dengan pindah baris)
    INT 21h

    MOV AX, OFFSET var_word          ; AX = offset var_word
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
