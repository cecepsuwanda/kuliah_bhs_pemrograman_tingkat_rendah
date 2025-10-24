;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
; PROGRAM : TAMBAH.ASM           ; 
; FUNGSI  : MELIHAT PENAMBAHAN   ; 
;           YANG DILAKUKAN       ; 
;           OLEH BERBAGAI        ; 
;           PERINTAH             ; 
;===========================S?to=; 
 .MODEL SMALL 
 .DATA
    bil1  DW 0
    bil2  DW 0
    hsl1  DW 0
    
 .CODE 
 ORG 100h 
 Proses : 
     MOV AX, @data   ; Mengatur segment data
     MOV DS, AX      ; Memuat segment data ke DS
     
     MOV bil1,2000d    ; bil1:=15h 
     
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
     
     MOV bil2,100d          ; bil2:=4
     
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
     
    
     
     XOR AX,AX
     MOV AX,hsl1         ; AX = angka yang akan dicetak
    
     MOV BX,10           ; BX = penyebut 
     XOR CX,CX           ; CX = 0 
    Ulang2 : 
     XOR DX,DX           ; Cegah sisa bagi menjadi pembilang ! 
     DIV BX              ; Bagi angka yang akan dicetak dengan 10 
     PUSH DX             ; Simpan sisa bagi dalam stack

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