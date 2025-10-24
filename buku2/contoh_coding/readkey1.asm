;/========================================\; 
; Program : READKEY1.ASM                  ; 
; Fungsi  : Input satu karakter            ; 
;           dari keyboard.                 ; 
;==========================================; 
;             INTERUPSI 16h                ; 
;==========================================; 
;      Input:        OutPut:               ; 
;      AH = 0    Jika tombol biasa, maka:  ; 
;                AL = ASCII                ; 
;                AH = SCAN                 ; 
;                                          ; 
;                Jika Tombol khusus, maka  ; 
;                AL = 00                   ; 
;                AH = Extended             ; 
;                                          ; 
;\========================================/; 
 INCLUDE pustaka.inc 
 .MODEL SMALL 
 .DATA
 
  Kal DB 'Tekan sembarang Tombol (tekan q untuk berhenti) : $'
  T_ASCII DB 'Anda menekan tombol ASCII : $' 
  T_Extended DB 'Anda menekan tombol Extended $' 
  T_Enter DB 13,10,'$'
  
 .CODE 
 ORG 100h 
 
 Proses : 
    MOV AX, @data   ; Mengatur segment data
    MOV DS, AX      ; Memuat segment data ke DS
    
    Cetak_Kal Kal ; Panggil Cetak_Kal
    MOV AH,0     ; Servis Input satu karakter 
    INT 16h      ; Laksanakan 
    PUSH AX      ; Simpan hasil pembacaan pada stack 
    CMP AL,00    ; Apakah ini karakter extended ? 
    JE Extended  ; Ya !, Lompat ke Extended 
 ASCII: 
    Cetak_Kal T_Enter ; Panggil Cetak_Kal
    Cetak_Kal T_ASCII ; Panggil Cetak_Kal
    POP AX         ; Ambil kembali nilai AX pada stack 
    MOV DL,AL      ; Ambil kode ASCII yang ditekan 
    MOV AH,2       ; Servis cetak karakter 
    INT 21h        ; Cetak karakter !
    Cetak_Kal T_Enter ; Panggil Cetak_Kal
    CMP AL,'Q'     ; Apakah yang ditekan huruf 'Q' ? 
    JE exit        ; Ya !, lompat ke Exit 
    CMP AL,'q'     ; Apakah yang ditekan huruf 'q' ? 
    JE exit        ; Ya !, lompat ke Exit 
    JMP Proses     ; Lompat ke Proses 
 Extended: 
    Cetak_Kal T_Enter ; Panggil Cetak_Kal
    Cetak_Kal T_Extended ; Panggil Cetak_Kal
    Cetak_Kal T_Enter ; Panggil Cetak_Kal
    JMP Proses        ; Lompat ke Proses 
 exit: 
      MOV AH,4CH         ; Keluar dari program dengan kode 0
      MOV AL,0
      INT 21H            ; Memanggil interrupt untuk mengakhiri program
 END Proses