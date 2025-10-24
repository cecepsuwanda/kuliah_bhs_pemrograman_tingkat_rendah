;================================; 
; PROGRAM : KALIM1.ASM           ; 
; FUNGSI  : MENGALIKAN BILANGAN  ; 
;           16 BIT, HASIL        ; 
;           PADA DX:AX           ; 
;================================; 
 INCLUDE pustaka.inc
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
 
     Cetak_Bil A ; Panggil Cetak_Bil
     Cetak_Opr 'x' ; Panggil Cetak_Opr
     Cetak_Bil B ; Panggil Cetak_Bi
     Cetak_Opr '=' ; Panggil Cetak_Opr  
 
     XOR AX,AX
     XOR DX,DX
     MOV AX,A     ; AX=1EF 
     MUL B        ; Kalikan 1FH*2FE 
     MOV HslLo,AX ; AX bernilai C922 sehingga HslLo=C922 
     MOV HslHi,DX ; DX bernilai 0005 sehingga HslHi=0005
     
     Cetak_Bil_1 HslLo,HslHi ; Panggil Cetak_Bil_1
 
 MOV AH,4CH         ; Keluar dari program dengan kode 0
 MOV AL,0
 INT 21H            ; Memanggil interrupt untuk mengakhiri program
 
 END Proses 