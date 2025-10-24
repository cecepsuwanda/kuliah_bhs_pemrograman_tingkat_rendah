;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
; PROGRAM : TAMBAH1.ASM           ; 
; FUNGSI  : MELIHAT PENAMBAHAN   ; 
;           YANG DILAKUKAN       ; 
;           OLEH BERBAGAI        ; 
;           PERINTAH             ; 
;===========================S?to=; 
 .MODEL SMALL 
 .DATA
    bil1  DW 0
    bil2  DW 0
    hsl1 DW 0             ; Tempat menyimpan hasil penjumlahan bagian bawah (16-bit)
    carry DW 0              ; Tempat menyimpan bagian overflow (Carry)
 .CODE 
 ORG 100h 
 Proses : 
     MOV AX, @data   ; Mengatur segment data
     MOV DS, AX      ; Memuat segment data ke DS
     
     MOV bil1,1234h    ; bil1:=1234h 
     
     XOR AX,AX
     MOV AX,bil1         ; AX = angka yang akan dicetak 
     MOV BX,10           ; BX = penyebut 
     XOR CX,CX           ; CX = 0 
    Ulang : 
     XOR DX,DX           ; Cegah sisa bagi menjadi pembilang ! 
     DIV BX              ; Bagi angka yang akan dicetak dengan 10 
     PUSH DX             ; Simpan sisa bagi dalam stack

     INC CX              ; CX ditambah 1 
     CMP AX,0            ; Apakah hasil bagi sudah habis ? 
     JNE Ulang           ; Jika belum, ulangi lagi ! 
    Cetak : 
     POP DX              ; Ambil 1 angka yang disimpan 
     ADD DL,'0'          ; Ubah angka tersebut dalam kode ASCII 
     MOV AH,02           ; 
     INT 21h             ; Cetak angka tersebut 
     LOOP Cetak
     
     MOV DL,'+'          ; Ubah angka tersebut dalam kode ASCII 
     MOV AH,02           ; 
     INT 21h             ; Cetak angka tersebut
     
     MOV bil2,0F221h     ; bil2:=0F221h
     
     XOR AX,AX
     MOV AX,bil2         ; AX = angka yang akan dicetak 
     MOV BX,10           ; BX = penyebut 
     XOR CX,CX           ; CX = 0 
    Ulang1 : 
     XOR DX,DX           ; Cegah sisa bagi menjadi pembilang ! 
     DIV BX              ; Bagi angka yang akan dicetak dengan 10 
     PUSH DX             ; Simpan sisa bagi dalam stack

     INC CX              ; CX ditambah 1 
     CMP AX,0            ; Apakah hasil bagi sudah habis ? 
     JNE Ulang1           ; Jika belum, ulangi lagi ! 
    Cetak1 : 
     POP DX              ; Ambil 1 angka yang disimpan 
     ADD DL,'0'          ; Ubah angka tersebut dalam kode ASCII 
     MOV AH,02           ; 
     INT 21h             ; Cetak angka tersebut 
     LOOP Cetak1
     
     MOV DL,'='          ; Ubah angka tersebut dalam kode ASCII 
     MOV AH,02           ; 
     INT 21h             ; Cetak angka tersebut
     
     MOV AX,bil1
     ADD AX,bil2
     MOV hsl1,AX
     
     JC set_carry            ; Jika ada carry, lompat ke set_carry
     JMP no_carry            ; Jika tidak ada carry, lompat ke no_carry

set_carry:
     MOV carry, 1            ; Set carry ke 1 jika overflow terjadi
     JMP continue_conversion ; Lanjutkan ke konversi

no_carry:
     MOV carry, 0            ; Set carry ke 0 jika tidak ada overflow
     
     
     
 continue_conversion:     
     XOR AX,AX
     MOV AX,hsl1         ; AX = angka yang akan dicetak
     MOV DX, carry       ; Memindahkan nilai carry (0 atau 1) ke DX 
     MOV BX,10           ; BX = penyebut 
     XOR CX,CX           ; CX = 0 
    Ulang2 : 
     
     DIV BX              ; Bagi angka yang akan dicetak dengan 10 
     PUSH DX             ; Simpan sisa bagi dalam stack
     XOR DX,DX           ; Cegah sisa bagi menjadi pembilang ! 

     INC CX              ; CX ditambah 1 
     CMP AX,0            ; Apakah hasil bagi sudah habis ? 
     JNE Ulang2           ; Jika belum, ulangi lagi ! 
    Cetak2 : 
     POP DX              ; Ambil 1 angka yang disimpan 
     ADD DL,'0'          ; Ubah angka tersebut dalam kode ASCII 
     MOV AH,02           ; 
     INT 21h             ; Cetak angka tersebut 
     LOOP Cetak2
     
     MOV AH,4CH         ; Keluar dari program dengan kode 0
     MOV AL,0
     INT 21H            ; Memanggil interrupt untuk mengakhiri program
 
END Proses 