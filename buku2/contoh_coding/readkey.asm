;/========================================\; 
; Program : READKEY.ASM                    ; 
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
 .MODEL SMALL 
 .DATA
 
  kal DB 'Tekan sembarang Tombol (tekan q untuk berhenti) : $'
  T_ASCII DB 'Anda menekan tombol ASCII : $' 
  T_Extended DB 'Anda menekan tombol Extended $' 
  T_Enter DB 13,10,'$'
  
 .CODE 
 ORG 100h 
 
 Proses : 
    MOV AX, @data   ; Mengatur segment data
    MOV DS, AX      ; Memuat segment data ke DS
    
    LEA DX,kal     ; Ambil alamat efektif kal 
    MOV AH,09      ; Servis cetak kalimat 
    INT 21h        ; Cetak kalimat !
    MOV AH,0     ; Servis Input satu karakter 
    INT 16h      ; Laksanakan 
    PUSH AX      ; Simpan hasil pembacaan pada stack 
    CMP AL,00    ; Apakah ini karakter extended ? 
    JE Extended  ; Ya !, Lompat ke Extended 
 ASCII: 
    LEA DX,T_Enter ; Ambil alamat efektif T_Enter 
    MOV AH,09      ; Servis cetak kalimat 
    INT 21h        ; Cetak kalimat !
    LEA DX,T_ASCII ; Ambil alamat efektif T_ASCII 
    MOV AH,09      ; Servis cetak kalimat 
    INT 21h        ; Cetak kalimat ! 
    POP AX         ; Ambil kembali nilai AX pada stack 
    MOV DL,AL      ; Ambil kode ASCII yang ditekan 
    MOV AH,2       ; Servis cetak karakter 
    INT 21h        ; Cetak karakter !
    LEA DX,T_Enter ; Ambil alamat efektif T_Enter 
    MOV AH,09      ; Servis cetak kalimat 
    INT 21h        ; Cetak kalimat !
    CMP AL,'Q'     ; Apakah yang ditekan huruf 'Q' ? 
    JE exit        ; Ya !, lompat ke Exit 
    CMP AL,'q'     ; Apakah yang ditekan huruf 'q' ? 
    JE exit        ; Ya !, lompat ke Exit 
    JMP Proses     ; Lompat ke Proses 
 Extended: 
    LEA DX,T_Enter ; Ambil alamat efektif T_Enter 
    MOV AH,09      ; Servis cetak kalimat 
    INT 21h        ; Cetak kalimat !
    LEA DX,T_Extended ; Ambil alamat efektif T_Extended 
    MOV AH,09         ; Servis cetak kalimat 
    INT 21h           ; Cetak kalimat !
    LEA DX,T_Enter ; Ambil alamat efektif T_Enter 
    MOV AH,09      ; Servis cetak kalimat 
    INT 21h        ; Cetak kalimat !
    JMP Proses        ; Lompat ke Proses 
 exit: 
      MOV AH,4CH         ; Keluar dari program dengan kode 0
      MOV AL,0
      INT 21H            ; Memanggil interrupt untuk mengakhiri program
 END Proses