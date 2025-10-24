;================================;
; PROGRAM : BAGIM1.ASM           ; 
; FUNGSI  : MEMBAGI BILANGAN     ; 
;           16 BIT, HASIL        ; 
;           PADA DX:AX           ; 
;================================; 
 INCLUDE pustaka.inc
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
 
     Cetak_Bil A ; Panggil Cetak_Bil
     Cetak_Kal Kal ; Panggil Cetak_Kal
     Cetak_Bil B ; Panggil Cetak_Bil
     Cetak_Opr '=' ; Panggil Cetak_Opr
     
     SUB DX,DX       ; Jadikan DX=0 
     MOV AX,A        ; AX=1EF 
     DIV B           ; Bagi 1EF:2 
     MOV Hsl,AX      ; AX bernilai 00F7 sehingga Hsl=00F7 
     MOV Sisa,DX     ; DX berisi 0001 sehingga Sisa=0001
 
     Cetak_Bil Hsl ; Panggil Cetak_Bil
 
 MOV AH,4CH         ; Keluar dari program dengan kode 0
 MOV AL,0
 INT 21H            ; Memanggil interrupt untuk mengakhiri program
 
 END Proses