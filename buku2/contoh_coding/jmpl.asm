;/================================================\; 
;    Program : JMPL.ASM                            ; 
;    Author : S?to                                 ;
;    Fungsi : Mencetak kalimat secara perkarakter  ; 
;             sampai ditemui karakter '*'          ; 
;                                                  ; 
;\================================================/; 
 .MODEL SMALL
 .DATA

  Kal DB ' Lucky Luck menembak ',13,10 
      DB 'Lebih cepat dari bayangannya !! ',7,7,'*' 
 
 .CODE 
 ORG 100h 
Proses: 
 MOV AX, @data   ; Mengatur segment data
 MOV DS, AX      ; Memuat segment data ke DS
 
 XOR BX,BX ; BX=0 
 MOV AH,02h ; Servis Untuk Cetak Karakter 
 Ulang: 
    CMP Kal[BX],'*' ; Bandingkan dengan '*' 
    JE Exit ; Jika Sama Lompat ke Exit 
    MOV DL,Kal[BX] ; Masukkan karakter ke BX menuju DL 
    INT 21h ; Cetak karakter 
    INC BX ; Tambah 1 pada BX 
    JMP Ulang ; Lompat Ke Ulang 
 Exit : 
       MOV AH,4CH         ; Keluar dari program dengan kode 0
       MOV AL,0
       INT 21H            ; Memanggil interrupt untuk mengakhiri program 
END Proses 