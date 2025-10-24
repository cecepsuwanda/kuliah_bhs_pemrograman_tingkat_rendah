;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
;   PROGRAM : A0.ASM            ; 
;   FUNGSI  : MENCETAK KARATER  ; 
;             'A' DENGAN INT 21 ; 
;==========================S?to=; 
         .MODEL SMALL 
         .CODE 
         ORG 100h 
Proses :  
         MOV  AH,02h   ; Nilai servis ntuk mencetak karakter 
         MOV  DL,'A'   ; DL = Karakter ASCII yang akan dicetak 
         INT  21h      ; Cetak karakter !! 
         
END      Proses 