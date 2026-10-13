; ============================================================
; warna-layar.asm
; Menampilkan teks berwarna dengan layanan video BIOS:
;   INT 10h fungsi 00h - menetapkan mode teks 80x25 berwarna
;   INT 10h fungsi 13h - menulis string beserta atribut warnanya
;   INT 10h fungsi 02h - memindahkan posisi kursor
;   INT 10h fungsi 09h - menulis satu karakter berulang
; Prosesor  : Intel 8086 (mode real, 16-bit)
; Assembler : MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    judul   DB  'Bahasa Assembly - Interupsi BIOS/DOS'
    panjang EQU $ - judul                       ; panjang judul = 36 karakter
    garis   DB  '===================================='  ; 36 tanda '='

.CODE
START:
    ; ---------- 1. inisialisasi register segmen ----------
    MOV AX, @DATA
    MOV DS, AX                          ; DS menunjuk segmen .DATA
    MOV ES, AX                          ; ES = DS, untuk alamat ES:BP

    ; ---------- 2. tetapkan mode video 03h ----------
    MOV AH, 00h                         ; fungsi 00h: set mode video
    MOV AL, 03h                         ; 03h = teks 80x25 berwarna
    INT 10h                             ; layar dibersihkan dan diatur

    ; ---------- 3. tulis judul berwarna pada baris 5 ----------
    MOV AH, 13h                         ; fungsi 13h: tulis string
    MOV AL, 01h                         ; mode 01h: kursor maju sesudah menulis
    MOV BH, 00h                         ; halaman tampilan 0
    MOV BL, 0Eh                         ; atribut 0Eh = kuning pada hitam
    MOV CX, panjang                     ; CX = jumlah karakter yang ditulis
    MOV DH, 05h                         ; DH = baris 5
    MOV DL, 0Ah                         ; DL = kolom 10
    LEA BP, judul                       ; BP = offset string judul
    INT 10h                             ; ES:BP menunjuk string yang ditulis

    ; ---------- 4. pindahkan kursor ke baris 7 ----------
    MOV AH, 02h                         ; fungsi 02h: set posisi kursor
    MOV BH, 00h                         ; halaman 0
    MOV DH, 07h                         ; baris 7
    MOV DL, 0Ah                         ; kolom 10
    INT 10h

    ; ---------- 5. tulis garis '=' berwarna merah ----------
    MOV AH, 09h                         ; fungsi 09h: tulis karakter berulang
    MOV AL, '='                         ; AL = karakter yang ditulis
    MOV BH, 00h                         ; halaman 0
    MOV BL, 0Ch                         ; atribut 0Ch = merah terang pada hitam
    MOV CX, panjang                     ; tulis sebanyak panjang judul (35)
    INT 10h                             ; fungsi 09h tidak menggeser kursor

    ; ---------- 6. kembalikan mode teks lalu keluar ----------
    MOV AH, 4Ch                         ; fungsi 4Ch: terminasi program
    MOV AL, 00h
    INT 21h

END START
