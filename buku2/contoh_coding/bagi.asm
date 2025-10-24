;================================;
; PROGRAM : BAGI.ASM             ; 
; FUNGSI  : MEMBAGI BILANGAN     ; 
;           16 BIT, HASIL        ; 
;           PADA DX:AX           ; 
;================================; 
 .MODEL SMALL 
 .DATA
   A DW 01EFh 
   B DW 2 
   Kal DB ' DIV $'
   Hsl DW ? 
   Sisa DW ? 
 .CODE 
 ORG 100h 
Proses: 
 MOV AX, @data   ; Mengatur segment data
 MOV DS, AX      ; Memuat segment data ke DS
 
     XOR AX,AX
     MOV AX,A         ; AX = angka yang akan dicetak 
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
 
     MOV AH,09h         ; Servis ke 9
     LEA DX,Kal        ; Ambil Alamat Offset Kal0 
     INT 21h            ; Cetak perkarakter sampai tanda $  
     
     XOR AX,AX
     MOV AX,B         ; AX = angka yang akan dicetak 
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
     
 SUB DX,DX       ; Jadikan DX=0 
 MOV AX,A        ; AX=1EF 
 DIV B           ; Bagi 1EF:2 
 MOV Hsl,AX      ; AX bernilai 00F7 sehingga Hsl=00F7 
 MOV Sisa,DX     ; DX berisi 0001 sehingga Sisa=0001
 
     XOR AX,AX
     MOV AX,Hsl         ; AX = angka yang akan dicetak 
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