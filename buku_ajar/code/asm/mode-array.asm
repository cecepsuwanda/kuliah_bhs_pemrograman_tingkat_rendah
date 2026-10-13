; ============================================================
; mode-array.asm
; Membandingkan tiga mode pengalamatan untuk mengakses elemen
; array satu dimensi yang sama:
;   (1) direct        : MOV AX, data1+4
;   (2) indexed       : MOV AX, data1[SI]
;   (3) base-relative : MOV AX, [BX+SI]
; Ketiga cara harus menghasilkan jumlah yang identik.
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL                ; satu segmen kode + satu segmen data
.STACK 100h                 ; 256 byte ruang stack

.DATA
    data1   DW  10, 20, 30, 40, 50      ; array 5 elemen word
    n       EQU 5                       ; banyaknya elemen array

    jumlah1 DW  ?                       ; hasil cara 1 (direct)
    jumlah2 DW  ?                       ; hasil cara 2 (indexed)
    jumlah3 DW  ?                       ; hasil cara 3 (base-relative)

    judul   DB  'Perbandingan tiga mode pengalamatan', 0Dh, 0Ah, '$'
    sama    DB  'Ketiga hasil identik.', 0Dh, 0Ah, '$'
    beda    DB  'Ada hasil yang berbeda!', 0Dh, 0Ah, '$'

.CODE
START:
    MOV AX, @DATA           ; alamat segmen .DATA
    MOV DS, AX              ; DS harus menunjuk ke .DATA

    ; ---------- cara 1: mode direct, offset berupa konstanta ----------
    MOV AX, data1+0         ; elemen ke-0
    ADD AX, data1+2         ; elemen ke-1
    ADD AX, data1+4         ; elemen ke-2
    ADD AX, data1+6         ; elemen ke-3
    ADD AX, data1+8         ; elemen ke-4
    MOV jumlah1, AX         ; simpan hasil cara 1

    ; ---------- cara 2: mode indexed [SI + disp] ----------
    MOV AX, 0               ; akumulator jumlah
    XOR SI, SI              ; SI = 0, menunjuk elemen ke-0 (segmen DS)
    MOV CX, n               ; pencacah = banyaknya elemen
C2:
    ADD AX, data1[SI]       ; baca memori pada DS:data1 + SI
    ADD SI, 2               ; maju satu elemen (word = 2 byte)
    LOOP C2                 ; ulangi sampai CX = 0
    MOV jumlah2, AX         ; simpan hasil cara 2

    ; ---------- cara 3: mode base-relative [BX + SI] ----------
    MOV AX, 0               ; akumulator jumlah
    LEA BX, data1           ; BX = offset awal array (basis)
    XOR SI, SI              ; SI = 0 (indeks)
    MOV CX, n               ; pencacah = banyaknya elemen
C3:
    ADD AX, [BX+SI]         ; baca memori pada DS:BX + SI
    ADD SI, 2               ; maju satu elemen
    LOOP C3                 ; ulangi sampai CX = 0
    MOV jumlah3, AX         ; simpan hasil cara 3

    ; ---------- bandingkan ketiga hasil ----------
    MOV AX, jumlah1         ; ambil hasil cara 1
    CMP AX, jumlah2         ; bandingkan dengan hasil cara 2
    JNE TIDAK_SAMA          ; lompat bila berbeda
    MOV AX, jumlah2         ; ambil hasil cara 2
    CMP AX, jumlah3         ; bandingkan dengan hasil cara 3
    JNE TIDAK_SAMA          ; lompat bila berbeda

    MOV AH, 09h             ; ketiga hasil sama
    LEA DX, judul
    INT 21h
    MOV AH, 09h
    LEA DX, sama
    INT 21h
    JMP SELESAI

TIDAK_SAMA:
    MOV AH, 09h             ; ada hasil yang tidak sama
    LEA DX, judul
    INT 21h
    MOV AH, 09h
    LEA DX, beda
    INT 21h

SELESAI:
    MOV AH, 4Ch             ; terminasi program
    MOV AL, 00h             ; kode keluar 0
    INT 21h

END START                   ; titik masuk program = label START
