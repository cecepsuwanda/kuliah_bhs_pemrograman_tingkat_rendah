;/================================\; 
; PROGRAM : BRA1.ASM               ; 
; Fungsi  : Mencetak String        ; 
;           dengan Int 21 servis 2 ; 
;\================================/; 
 .MODEL SMALL 
 .DATA

  Kalimat DB 'DIBELAKANG TANDA $ TIDAK BISA DICETAK'   ; 37 karakter  
 
 .CODE 
 ORG 100h 
 
Proses: 
    MOV AX, @data   ; Mengatur segment data
    MOV DS, AX      ; Memuat segment data ke DS
 
    XOR BX,BX       ; BX=0 Untuk penunjuk Offset 
    MOV CX,25h       ; Counter LOOP 
Ulang : 
 MOV DL,Kalimat[BX] ; Ambil karakter yang ke BX 
 MOV AH,02          ; Servis untuk cetak karakter 
 INT 21h            ; Cetak Karakter 
 INC BX             ; BX:=BX+1 
 LOOP Ulang         ; Lompat ke Ulang sampai CX=0
 
 MOV AH,4CH         ; Keluar dari program dengan kode 0
 MOV AL,0
 INT 21H            ; Memanggil interrupt untuk mengakhiri program
 
 END Proses