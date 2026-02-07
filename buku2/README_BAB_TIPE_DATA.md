# Penambahan Bab 4: Tipe Data dalam Bahasa Assembly

## Perubahan yang Dilakukan

### 1. File Baru yang Dibuat
- `chapters/ch04_tipe_data.tex` - Bab baru tentang tipe data dalam bahasa assembly

### 2. File yang Dimodifikasi
- `main.tex` - Diperbarui untuk memasukkan bab baru dan menggeser urutan bab yang ada

## Struktur Bab Baru

Bab 4 "Tipe Data dalam Bahasa Assembly" mencakup:

### Materi Utama:
1. **Konsep Dasar Tipe Data dalam Assembly**
   - Perbedaan dengan bahasa tingkat tinggi
   - Ukuran data dan register Intel 8086

2. **Tipe Data Dasar**
   - Byte (8-bit): rentang nilai, deklarasi, contoh
   - Word (16-bit): rentang nilai, deklarasi, contoh
   - Double Word (32-bit): rentang nilai, deklarasi, contoh

3. **Direktif Data Definition**
   - DB (Define Byte): sintaks dan penggunaan
   - DW (Define Word): sintaks dan penggunaan
   - DD (Define Double Word): sintaks dan penggunaan

4. **Tipe Data Karakter dan String**
   - Deklarasi karakter
   - Deklarasi string dengan null terminator

5. **Konstanta dan Simbol**
   - Direktif EQU
   - Direktif = (Equal)

6. **Data Bertanda vs Tak Bertanda**
   - Konsep interpretasi data
   - Contoh penggunaan

7. **Memory Layout dan Pengalamatan**
   - Konsep segmen data
   - Layout memori
   - Pengalamatan data

8. **Contoh Program Lengkap**
   - Program demonstrasi tipe data

### Bagian Pembelajaran:
- **Tujuan Pembelajaran**: 6 tujuan yang spesifik
- **Contoh Soal dan Pembahasan**: 3 soal dengan pembahasan lengkap
- **Latihan**: 4 latihan praktik
- **Tugas**: Tugas utama, pendukung, dan dokumentasi
- **Referensi**: Sumber dari internet dan buku

## Urutan Bab yang Diperbarui

### Sebelum:
1. Bab 1: Pengenalan Bahasa Rakitan dan Sistem Bilangan
2. Bab 2: Arsitektur Mikroprosesor Intel 8086
3. Bab 3: Lingkungan Pengembangan (GTASM)
4. Bab 4: Instruksi Dasar (Perpindahan Data dan Aritmatika)
5. Bab 5: Instruksi Logika dan Operasi Bit
6. ... (dan seterusnya)

### Sesudah:
1. Bab 1: Pengenalan Bahasa Rakitan dan Sistem Bilangan
2. Bab 2: Arsitektur Mikroprosesor Intel 8086
3. Bab 3: Lingkungan Pengembangan (GTASM)
4. **Bab 4: Tipe Data dalam Bahasa Assembly** ← BARU
5. Bab 5: Instruksi Dasar (Perpindahan Data dan Aritmatika) ← bergeser
6. Bab 6: Instruksi Logika dan Operasi Bit ← bergeser
7. ... (dan seterusnya)

## Prinsip Pembelajaran Progresif

Penambahan bab ini mengikuti prinsip pembelajaran progresif yang ketat:

- **Setelah Bab 3**: Mahasiswa sudah memahami lingkungan pengembangan
- **Sebelum Bab 5**: Konsep tipe data harus dipahami sebelum mempelajari instruksi dasar
- **Mengikuti Urutan Logis**: Konsep dasar → Tipe data → Instruksi dasar → Instruksi lanjutan

## Sumber Materi

Materi dalam bab ini dikumpulkan dari berbagai sumber terbuka di internet, termasuk:

- Tutorial assembly language data types
- Intel 8086 programming guides
- Assembly language references
- Open source documentation

## Kompatibilitas

Bab baru ini:
- Menggunakan struktur LaTeX yang sama dengan bab lainnya
- Mengikuti template yang sudah ada
- Kompatibel dengan konfigurasi `main.tex`
- Menggunakan syntax highlighting yang sama
- Mengikuti format referensi yang sudah ada

## Cara Kompilasi

Untuk mengkompilasi buku dengan bab baru:

```bash
# Kompilasi normal
pdflatex main.tex
biber main
pdflatex main.tex
pdflatex main.tex

# Atau gunakan script yang ada
compile_book.bat
```

## Catatan Penting

1. **Penomoran Otomatis**: LaTeX akan menangani penomoran bab secara otomatis
2. **Daftar Isi**: Akan terupdate otomatis dengan bab baru
3. **Referensi Silang**: Dapat menggunakan label yang sudah didefinisikan
4. **Konsistensi**: Mengikuti gaya penulisan yang sama dengan bab lainnya

## Validasi

File telah divalidasi dan tidak ada error LaTeX yang ditemukan. Struktur dan format mengikuti standar yang sudah ada dalam buku.
