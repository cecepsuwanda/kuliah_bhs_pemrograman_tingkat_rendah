;/============================================\; 
; Program : cd_angka.ASM                       ;
; Fungsi  : Mencetak angka yang bernilai       ; 
;           antara 0 sampai 65535 dalam        ; 
;           format desimal                     ; 
;\============================================/; 
 .MODEL SMALL 
 .DATA
 
  Test_Angka DW 65535 ; Angka yang akan dicetak 
 
 .CODE 
 ORG 100h  
  
  
Proses: 
 MOV AX, @data   ; Mengatur segment data
 MOV DS, AX      ; Memuat segment data ke DS
 
 MOV AX,Test_Angka   ; AX = angka yang akan dicetak 
 MOV BX,10           ; BX = penyebut 
 XOR CX,CX           ; CX = 0 
Ulang : 
 XOR DX,DX           ; Cegah sisa bagi menjadi pembilang ! 
 DIV BX              ; Bagi angka yang akan dicetak dengan 10 
 PUSH DX             ; Simpan sisa bagi dalam stack

 INC CX              ; CX ditambah 1 
 CMP AX,0            ; Apakah hasil bagi sudah habis ? 
 JNE Ulang           ; Jika belum, ulangi lagi ! 
Cetak : 
 POP DX              ; Ambil 1 angka yang disimpan 
 ADD DL,'0'          ; Ubah angka tersebut dalam kode ASCII 
 MOV AH,02           ; 
 INT 21h             ; Cetak angka tersebut 
 LOOP Cetak          ; ulangi 
  
 MOV AH,4CH         ; Keluar dari program dengan kode 0
 MOV AL,0
 INT 21H            ; Memanggil interrupt untuk mengakhiri program
 
 END Proses 