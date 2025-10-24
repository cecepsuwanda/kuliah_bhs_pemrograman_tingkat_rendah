;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
; PROGRAM : TAMBAH2.ASM           ; 
; FUNGSI  : MELIHAT PENAMBAHAN   ; 
;           YANG DILAKUKAN       ; 
;           OLEH BERBAGAI        ; 
;           PERINTAH             ; 
;===========================S?to=; 
 .MODEL SMALL 
 .DATA
    ALo EQU 5678h 
    AHi EQU 0005h 
    BLo EQU DEF0h 
    BHi EQU 0001h
    HslLo DW ? 
    HslHi DW ?  
 .CODE 
 ORG 100h 
 Proses : 
     MOV AX, @data   ; Mengatur segment data
     MOV DS, AX      ; Memuat segment data ke DS
     
     XOR AX,AX
     MOV AX,ALo         ; AX = angka yang akan dicetak
     MOV DX,AHi 
     MOV BX,10           ; BX = penyebut 
     XOR CX,CX           ; CX = 0 
    Ulang : 
     
     DIV BX              ; Bagi angka yang akan dicetak dengan 10 
     PUSH DX             ; Simpan sisa bagi dalam stack
     XOR DX,DX           ; Cegah sisa bagi menjadi pembilang ! 

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
     
     XOR AX,AX
     MOV AX,BLo         ; AX = angka yang akan dicetak 
     MOV DX,BHi
     MOV BX,10           ; BX = penyebut 
     XOR CX,CX           ; CX = 0 
    Ulang1 : 
     
     DIV BX              ; Bagi angka yang akan dicetak dengan 10 
     PUSH DX             ; Simpan sisa bagi dalam stack
     XOR DX,DX           ; Cegah sisa bagi menjadi pembilang ! 

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
     
       
     MOV CX,ALo       ; BX = 5678h CF = 0 
     MOV DX,BLo       ; DX = DEF0h CF = 0 
     ADD CX,DX        ; CX =       CF = 1 
     MOV HslLo,CX     ; HslLo bernilai  
     
     MOV AX,AHi       ; AX = 0005h CF = 0 
     MOV BX,BHi       ; BX = 0001h CF = 0   
     ADC AX,BX        ; AX = AX+BX+CF = ACF1 
     MOV HslHi,AX     ; HslHi bernilai 
      
     XOR AX,AX
     MOV AX,HslLo         ; AX = angka yang akan dicetak 
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