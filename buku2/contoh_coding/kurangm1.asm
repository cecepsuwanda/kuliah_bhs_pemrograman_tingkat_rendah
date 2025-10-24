;================================; 
; PROGRAM   : KURANGM1.ASM       ; 
; FUNGSI    : MENGURANGKAN ANGKA ; 
;             122EFFF-0FEFFFF    ; 
;================================; 
 INCLUDE pustaka.inc
 .MODEL SMALL
 .DATA
   ALo EQU 200d 
   AHi EQU 0 
   BLo EQU 150d 
   BHi EQU 0 
   HslLo DW ? 
   HslHi DW ? 
 .CODE 
 ORG 100h 
Proses : 
     MOV AX, @data   ; Mengatur segment data
     MOV DS, AX      ; Memuat segment data ke DS
 
     Cetak_Bil_1 ALo,AHi ; Panggil Cetak_Bil_1
     Cetak_Opr '-' ; Panggil Cetak_Opr
     Cetak_Bil_1 BLo,BHi ; Panggil Cetak_Bil_1
     Cetak_Opr '=' ; Panggil Cetak_Opr
     
     MOV AX,ALo          ; AX=EFFFh 
     SUB AX,BLo          ; Kurangkan EFFF-FFFF, jadi AX=F000 
  
     MOV HslLo,AX        ; HslLo bernilai F000 
     MOV AX,AHi          ; AX=00005h 
     SBB AX,BHi          ; Kurangkan 00005h-FE-Carry, AX=
     MOV HslHi,AX        ; HslHi bernilai 
    
     Cetak_Bil_1 HslLo,HslHi ; Panggil Cetak_Bil_1
  
     MOV AH,4CH         ; Keluar dari program dengan kode 0
     MOV AL,0
     INT 21H            ; Memanggil interrupt untuk mengakhiri program
 
 
 END Proses