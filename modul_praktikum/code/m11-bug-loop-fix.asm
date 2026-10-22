; =========================================================
; m11-bug-loop-fix.asm
; Perbaikan m11-bug-loop.asm.
; Perbaikan: INC CX dihapus karena LOOP sudah mengurangi CX.
; Hasil penjumlahan 15 dicetak sebagai dua digit desimal.
; =========================================================
        .MODEL SMALL
        .STACK 100h

        .DATA
JUDUL   DB 'Jumlah 1..5 = $'

        .CODE
START:
        MOV AX, @DATA           ; alamat segmen data
        MOV DS, AX              ; pasang DS ke segmen data

        XOR AX, AX              ; AX = akumulator jumlah
        MOV CX, 5               ; CX = pencacah mula-mula

ULANG:
        ADD AX, CX              ; jumlahkan nilai pencacah
        LOOP ULANG              ; CX berkurang otomatis

        MOV BX, AX              ; BX = hasil penjumlahan (15)
        MOV AH, 09h             ; cetak judul
        MOV DX, OFFSET JUDUL
        INT 21h

        MOV AX, BX              ; AX = hasil yang akan dicetak
        MOV BL, 10              ; pembagi 10
        DIV BL                  ; AL = puluhan, AH = satuan
        MOV BH, AH              ; simpan satuan di BH
        MOV DL, AL              ; DL = digit puluhan
        ADD DL, '0'             ; ubah ke kode ASCII
        MOV AH, 02h
        INT 21h

        MOV DL, BH              ; DL = digit satuan
        ADD DL, '0'             ; ubah ke kode ASCII
        MOV AH, 02h
        INT 21h

        MOV AH, 4Ch             ; akhiri program
        MOV AL, 00h
        INT 21h
        END START
