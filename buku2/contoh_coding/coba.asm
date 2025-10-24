.MODEL SMALL
.STACK 100h
.DATA
    number_low  DW 5678h      ; Bagian bawah (lower 16-bit) dari bilangan 32-bit (12345678h)
    number_high DW 0123h      ; Bagian atas (higher 16-bit) dari bilangan 32-bit
    subtrahend DW 10          ; Bilangan pengurang (10)

.CODE
.STARTUP

; Muat bilangan 32-bit ke dalam register DX:AX
    MOV AX, number_low        ; Muat bagian bawah ke AX
    MOV CX, number_high       ; Muat bagian atas ke DX
    
    MOV DX,CX
    XOR CX,CX                ; Membersihkan SI (untuk menghitung sisa dari pengurangan)

; Loop pengurangan hingga DX habis dan AX hanya berisi satu digit (0-9)
reduce_to_single_digit:
    CMP DX, 0                 ; Periksa apakah DX sudah nol
    JE check_ax_digit         ; Jika DX nol, periksa apakah AX hanya 1 digit

reduce_ax:    
    ; Jika DX bukan nol, kurangi DX:AX dengan 10
    SUB AX, subtrahend        ; Kurangi AX dengan 10
    ADD CX, 1                 ; Tambahkan 1 untuk setiap pengurangan
    JNC no_borrow             ; Jika tidak ada borrow, lewati langkah berikutnya
    DEC DX                    ; Jika ada borrow, kurangi DX dengan 1

no_borrow:
    JMP reduce_to_single_digit ; Ulangi hingga DX habis

check_ax_digit:
    CMP AX, 10                ; Periksa apakah AX kurang dari 10
    JB done                   ; Jika AX < 10, selesai
    ; Jika AX >= 10, lanjutkan pengurangan pada AX
    JMP reduce_ax             ; Ulangi sampai AX < 10

done:
    ; Pada titik ini, DX habis dan AX berisi satu digit (0-9)

; (Jika Anda ingin menampilkan hasil atau memprosesnya lebih lanjut, tambahkan kode di sini)

.EXIT
END
