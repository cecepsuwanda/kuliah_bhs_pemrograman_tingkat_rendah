;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
; Program: kal0.asm                   ; 
; Fungsi : Mencetak String            ; 
;          dengan Int 21 servis 9     ; 
;=====================================; 
 .MODEL SMALL 
 
 .DATA
  
  Kal0 DB 'PROSES PENCETAKAN STRING ',13,10,'$' 
  Kal1 DB 'DIBELAKANG TANDA $ TIDAK BISA DICETAK'  
 
 .CODE 
 ORG 100h 
 
Proses:

 MOV AX, @data      ; Mengatur segment data
 MOV DS, AX         ; Memuat segment data ke DS 

 MOV AH,09h         ; Servis ke 9 
 MOV DX,OFFSET Kal0 ; Ambil Alamat Offset Kal0 
 INT 21h            ; Cetak perkarakter sampai tanda $ 
 LEA DX,Kal0        ; Ambil Alamat Offset Kal0 
 INT 21h            ; Cetak perkarakter sampai tanda $ 
 LEA DX,Kal0+7      ; Ambil Alamat Offset KAl0+7 
 INT 21h            ; Cetak perkarakter sampai tanda $ 
 LEA DX,Kal1        ; Ambil Offset kal1 
 INT 21h            ; Cetak perkarakter sampai ketemu $ 
 
 MOV AH,4CH         ; Keluar dari program dengan kode 0
 MOV AL,0
 INT 21H            ; Memanggil interrupt untuk mengakhiri program 
 
 END Proses 