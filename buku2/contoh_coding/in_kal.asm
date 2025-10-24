;/=========================================================\; 
;              Program : IN-KAL.ASM                         ; 
;              Fungsi  : Input Kalimat dari                 ; 
;                        keyboard.                          ; 
;===========================================================; 
;                   INTERUPSI 21h                           ; 
;===========================================================; 
;  Input:                                                          ; 
;  AH = 0Ah                                                        ; 
;  DS:DX = Penampung dengan spesifikasi:                           ; 
;          Byte 1        = Maksimum karakter yang dapat dimasukkan ; 
;          Byte 2        = Akan dijadikan Indikator banyaknya      ; 
;                          karakter yang dimasukkan                ; 
;          Byte 3 keatas = Tempat hasil masukan ditampung          ; 
;\=========================================================/; 
 .MODEL SMALL 
 .DATA
 
    T_Enter EQU 0Dh 
    Kal0 DB 'Ketikkan satu Kalimat : $' 
    Kal1 DB 13,10,'Kalimat pada buffer : $' 
    Buffer DB 23,?,23 DUP(?)
 
 .CODE 
 ORG 100h 
Proses :

 MOV AX, @data   ; Mengatur segment data
 MOV DS, AX      ; Memuat segment data ke DS 
 
 MOV AH,09 
 LEA DX,Kal0 
 INT 21h         ; Cetak kalimat Kal0 
 MOV AH,0Ah      ; Servis Input kalimat 
 LEA DX,Buffer   ; DX menunjuk pada offset Buffer 
 INT 21h         ; Input kalimat ! 
 MOV AH,09 
 LEA DX,Kal1 
 INT 21h         ; Cetak kalimat Kal1 
 LEA BX,Buffer+2 ; BX menunjuk byte ke 3 Buffer 
 Ulang: 
    CMP BYTE PTR [BX],T_Enter ; Apakah karakter Enter? 
    JE EXIT                   ; Ya! Lompat ke Exit 
    MOV DL,[BX]               ; Masukkan karakter pada DL 
    MOV AH,02                 ; Servis cetak karakter 
    INT 21h                   ; Cetak karakter 
    INC BX                    ; BX := BX+1 
    JMP Ulang                 ; Lompat ke Ulang 
 EXIT: 
    MOV AH,4CH         ; Keluar dari program dengan kode 0
    MOV AL,0
    INT 21H            ; Memanggil interrupt untuk mengakhiri program
 END Proses