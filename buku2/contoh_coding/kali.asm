;================================; 
; PROGRAM : KALI.ASM             ; 
; FUNGSI  : MENGALIKAN BILANGAN  ; 
;           16 BIT, HASIL        ; 
;           PADA DX:AX           ; 
;================================; 
 .MODEL SMALL 
 .DATA
    A DW 2000d 
    B DW 100d 
    HslLo DW ? 
    HslHi DW ?
 .CODE 
 ORG 100h 
Proses: 
 MOV AX, @data   ; Mengatur segment data
 MOV DS, AX      ; Memuat segment data ke DS
 
     XOR AX,AX
     MOV AX,A            ; AX = angka yang akan dicetak 
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
 
     MOV DL,'x'          ; Ubah angka tersebut dalam kode ASCII 
     MOV AH,02           ; 
     INT 21h    
 
     XOR AX,AX
     MOV AX,B            ; AX = angka yang akan dicetak 
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
     INT 21h    
 
     XOR AX,AX
     XOR DX,DX
     MOV AX,A     ; AX=1EF 
     MUL B        ; Kalikan 1FH*2FE 
     MOV HslLo,AX ; AX bernilai C922 sehingga HslLo=C922 
     MOV HslHi,DX ; DX bernilai 0005 sehingga HslHi=0005
     
     XOR AX,AX
     MOV AX,HslLo        ; AX = angka yang akan dicetak 
     MOV DX,HslHi
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