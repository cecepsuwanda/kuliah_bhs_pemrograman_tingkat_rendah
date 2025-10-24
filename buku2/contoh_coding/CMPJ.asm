;/=========================================\; 
;     Program : CMPJ.ASM                    ; 
;     Author  : S?to                        ; 
;     Fungsi  : Mendemokan perintah lompat  ; 
;               yang mengikuti perintah CMP ; 
;                                           ; 
;\=========================================/; 
  .MODEL SMALL 
  .DATA
    
   BilA DB 67 
   BilB DB 66 
   Kal0 DB 'Bilangan A lebih kecil dari bilangan B $' 
   Kal1 DB 'Bilangan A sama dengan bilangan B $' 
   Kal2 DB 'Bilangan A lebih besar dari bilangan B $' 
  
  .CODE 
   ORG 100h 
 

Proses: 
      MOV AX, @data   ; Mengatur segment data
      MOV DS, AX      ; Memuat segment data ke DS
     
      MOV AL,BilA ; Masukkan bilangan A pada AL 
      CMP AL,BilB ; Bandingkan AL(BilA) dengan Bilangan B 
      JB AKecil ; Jika BilA < BilB, lompat ke AKecil 
      JE Sama ; Jika BilA = BilB, lompat ke Sama 
      JA ABesar ; Jika BilA > BilB, lompat ke ABesar 
  AKecil:
      LEA DX,Kal0 ; Ambil offset Kal0 
      JMP Cetak ; Lompat ke cetak 
  Sama: 
      LEA DX,Kal1 ; Ambil offset Kal1 
      JMP Cetak ; Lompat ke cetak 
  ABesar: 
      LEA DX,Kal2 ; Ambil offset Kal2 
  Cetak: 
      MOV AH,09 ; Servis untuk mencetak kalimat 
      INT 21h ; Cetak kalimat !! 
 EXIT: 
       MOV AH,4CH         ; Keluar dari program dengan kode 0
       MOV AL,0
       INT 21H            ; Memanggil interrupt untuk mengakhiri program 
END Proses