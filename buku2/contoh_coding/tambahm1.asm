;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
; PROGRAM : TAMBAHM1.ASM           ; 
; FUNGSI  : MELIHAT PENAMBAHAN   ; 
;           YANG DILAKUKAN       ; 
;           OLEH BERBAGAI        ; 
;           PERINTAH             ; 
;===========================S?to=; 
 INCLUDE pustaka.inc
 .MODEL SMALL 
 .DATA
    
    bil_ctk DW 0
    opr_ctk DW ?
    
 .CODE 
 ORG 100h 
 Proses : 
     MOV AX, @data   ; Mengatur segment data
     MOV DS, AX      ; Memuat segment data ke DS
     
     MOV bil_ctk,2000d ;bil_ctk:=15h
     Cetak_Bil bil_ctk ; Panggil Cetak_Bil
     
     MOV opr_ctk,'+'
     Cetak_Opr opr_ctk ; Panggil Cetak_Opr
     
     MOV bil_ctk,100d ;bil_ctk:=4
     Cetak_Bil bil_ctk ; Panggil Cetak_Bil
     
     MOV opr_ctk,'='
     Cetak_Opr opr_ctk ; Panggil Cetak_Opr
     
     MOV bil_ctk,2000d    ; bil1:=15h
     MOV AX,bil_ctk
     MOV bil_ctk,100d     ; bil2:=4
     ADD AX,bil_ctk
     
     MOV bil_ctk,AX
     Cetak_Bil bil_ctk ; Panggil Cetak_Bil
     
     MOV AH,4CH         ; Keluar dari program dengan kode 0
     MOV AL,0
     INT 21H            ; Memanggil interrupt untuk mengakhiri program
 
END Proses 