; ============================================================
; hello.asm
; Program assembly pertama: mencetak teks ke layar.
; Prosesor : Intel 8086 (mode real, 16-bit)
; Assembler: MASM / TASM / Emu8086
; ============================================================

.MODEL SMALL                ; model memori: satu segmen kode + satu segmen data
.STACK 100h                 ; sediakan 256 byte ruang stack

.DATA
    pesan   DB  'Halo, dunia!', 0Dh, 0Ah, '$'   ; string diakhiri '$'
    panjang EQU $ - pesan                       ; panjang string (byte)

.CODE
START:
    ; --- 1. inisialisasi register segmen data ---
    MOV AX, @DATA           ; alamat segmen .DATA
    MOV DS, AX              ; DS harus menunjuk ke .DATA

    ; --- 2. cetak string dengan layanan DOS INT 21h fungsi 09h ---
    MOV AH, 09h             ; AH = 09h : cetak string berakhir '$'
    LEA DX, pesan           ; DX = offset string
    INT 21h                 ; panggil layanan DOS

    ; --- 3. keluar dari program, kembalikan kendali ke DOS ---
    MOV AH, 4Ch             ; AH = 4Ch : terminasi program
    MOV AL, 00h             ; AL = kode keluar (0 = sukses)
    INT 21h

END START                   ; titik masuk program = label START
