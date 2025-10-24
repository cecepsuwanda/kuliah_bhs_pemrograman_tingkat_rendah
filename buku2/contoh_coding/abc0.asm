;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
;   PROGRAM : ABC0.ASM          ; 
;   FUNGSI  : MENCETAK 16 BUAH  ; 
;             KARAKTER DENGAN   ; 
;             INT 21h SERVIS 02 ; 
;==========================S?to=; 
 .MODEL SMALL 
 .CODE 
 ORG 100h 
Proses : 
 MOV AH,02h ; Nilai servis 
 MOV DL,'A' ; DL=karakter 'A' atau DL=41h 
 MOV CX,10h ; Banyaknya pengulangan yang akan 
 
Ulang : 
 INT 21h ; Cetak karakter !! 
 INC DL ; Tambah DL dengan 1 
 LOOP Ulang ; Lompat ke Ulang 
 
 MOV AH,4CH         ; Keluar dari program dengan kode 0
 MOV AL,0
 INT 21H            ; Memanggil interrupt untuk mengakhiri program 
 END Proses