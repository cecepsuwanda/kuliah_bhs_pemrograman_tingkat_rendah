;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~; 
; PROGRAM : TAMBAHP.ASM           ; 
; FUNGSI  : MELIHAT PENAMBAHAN   ; 
;           YANG DILAKUKAN       ; 
;           OLEH BERBAGAI        ; 
;           PERINTAH             ; 
;===========================S?to=; 
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
     CALL Cetak_Bil ; Panggil Cetak_Bil
     
     MOV opr_ctk,'+'
     CALL Cetak_Opr ; Panggil Cetak_Opr
     
     MOV bil_ctk,100d ;bil_ctk:=4
     CALL Cetak_Bil ; Panggil Cetak_Bil
     
     MOV opr_ctk,'='
     CALL Cetak_Opr ; Panggil Cetak_Opr
     
     MOV bil_ctk,2000d    ; bil1:=15h
     MOV AX,bil_ctk
     MOV bil_ctk,100d     ; bil2:=4
     ADD AX,bil_ctk
     
     MOV bil_ctk,AX
     CALL Cetak_Bil ; Panggil Cetak_Bil
     
     MOV AH,4CH         ; Keluar dari program dengan kode 0
     MOV AL,0
     INT 21H            ; Memanggil interrupt untuk mengakhiri program
     
Cetak_Bil PROC NEAR
          XOR AX,AX
          MOV AX,bil_ctk      ; AX = angka yang akan dicetak 
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
             LOOP Cetak
          RET
Cetak_Bil ENDP

Cetak_Opr PROC NEAR
          XOR DX,DX
          MOV DX,opr_ctk      ; Ubah angka tersebut dalam kode ASCII 
          MOV AH,02           ; 
          INT 21h             ; Cetak angka tersebut
          RET
Cetak_Opr ENDP      
 
END Proses 