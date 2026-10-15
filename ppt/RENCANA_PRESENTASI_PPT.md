# RENCANA PEMBUATAN SLIDE PRESENTASI (BEAMER)
## Bahasa Pemrograman Tingkat Rendah (Assembly 8086)

**Program Studi Teknik Informatika — Fakultas Teknologi Informasi**
**Universitas Bale Bandung**
**Mata Kuliah:** Bahasa Pemrograman Tingkat Rendah (MWCA010, 3 SKS)
**Semester:** Ganjil
**Dosen Pengampu:** Cecep Suwanda, S.Si., M.Kom.
**Sumber materi:** `buku_ajar/` (Bab III–XVI) dan `rps_silabus/silabus.tex`
**Tujuan keluaran:** `ppt/src/minggu-NN.tex` (sumber) dan `ppt/minggu-NN.pdf` (hasil jadi)

---

## 1. Ringkasan

Dokumen ini adalah **rencana pembuatan slide presentasi** untuk 14 pertemuan
kuliah mata kuliah Bahasa Pemrograman Tingkat Rendah. Slide ditulis dengan
LaTeX (kelas `beamer`), **satu berkas per minggu**, dan disusun **bertahap
satu minggu per satu tahap** seperti penulisan buku ajar.

Isi setiap deck diturunkan **langsung dari bab buku yang bersesuaian**,
sehingga tidak ada materi baru yang tidak ada rujukannya di buku. Urutan
minggu mengikuti RPS: minggu 1–7 dan minggu 9–15, sedangkan minggu 8 (UTS)
dan minggu 16 (UAS) tidak dibuatkan deck materi.

| Item | Nilai |
|---|---|
| Jumlah deck | 14 (minggu 1–7 dan 9–15) |
| Sumber utama per deck | 1 bab buku (pemetaan 1:1) |
| Perkiraan frame per deck | 20–28 |
| Perkiraan total frame | ±340 |
| Rasio slide | 16:9 (`aspectratio=169`) |
| Mesin kompilasi | `pdflatex` (MiKTeX 24.1) |
| Bahasa | Indonesia (istilah teknis tetap Inggris) |

---

## 2. Ruang Lingkup

### 2.1 Termasuk

- 14 deck presentasi, masing-masing untuk satu pertemuan.
- Tema visual bersama yang selaras dengan identitas buku (warna OBE).
- Berkas tema/makro bersama agar 14 deck konsisten dan mudah dirawat.
- Skrip kompilasi dan pembersihan berkas antara.
- Deck judul memuat identitas mata kuliah yang baru (MWCA010, Semester Ganjil,
  Fakultas Teknologi Informasi, Universitas Bale Bandung).

### 2.2 Tidak termasuk

- **Minggu 8 (UTS) dan minggu 16 (UAS)** — bukan pertemuan materi. Deck kisi-kisi
  ujian dapat dibuat terpisah bila diminta.
- **Bab I, II, dan XVII** — tidak terikat satu pertemuan (Bab I dibaca sebelum
  kuliah, Bab II bekal konseptual, Bab XVII menjelang UAS). Ringkasan Bab II
  cukup muncul sebagai frame pengait di deck minggu 1.
- **Lampiran A–D** buku (rubrik, contoh tugas, glosarium, referensi).
- Animasi/transisi non-LaTeX (PowerPoint, video, dsb.).

---

## 3. Pemetaan Minggu → Bab → CPMK

Pemetaan mengikuti tabel "Kesepadanan pertemuan, Sub-CPMK, dan bab buku"
pada Bab I buku (`chapters/01/section-02.tex`) dan Bagian 5 silabus.

| Minggu | Materi pokok (silabus) | Bab buku | Judul bab | Sub-CPMK | CPMK |
|---|---|---|---|---|---|
| 1 | Pengenalan pemrograman tingkat rendah | Bab III | Pengenalan Pemrograman Tingkat Rendah dan Lingkungan Kerja | 1.1 | CPMK01 |
| 2 | Arsitektur mikroprosesor 8086 | Bab IV | Arsitektur Mikroprosesor 8086 | 1.1 | CPMK01 |
| 3 | Register 8086 | Bab V | Register 8086 dan Register Flag | 1.2 | CPMK01 |
| 4 | Segmentasi memori | Bab VI | Segmentasi Memori dan Alamat Fisik | 1.3 | CPMK01 |
| 5 | Format instruksi mesin | Bab VII | Format Instruksi Mesin | 2.1 | CPMK02 |
| 6 | Mode pengalamatan | Bab VIII | Mode Pengalamatan | 2.2 | CPMK02 |
| 7 | Direktif assembler dan translasi | Bab IX | Direktif Assembler dan Alur Translasi Program | 2.3 | CPMK02 |
| ~~8~~ | ~~Ujian Tengah Semester~~ | — | — | 1.1–2.3 | — |
| 9 | Transfer data dan aritmatika | Bab X | Instruksi Transfer Data dan Aritmatika | 3.1 | CPMK03 |
| 10 | Logika, pergeseran, dan rotasi | Bab XI | Operasi Logika, Pergeseran, dan Rotasi | 3.2 | CPMK03 |
| 11 | Struktur kontrol dan percabangan | Bab XII | Struktur Kontrol dan Percabangan | 3.3 | CPMK03 |
| 12 | Prosedur dan manajemen stack | Bab XIII | Prosedur dan Manajemen Stack | 3.4 | CPMK03 |
| 13 | Interupsi BIOS/DOS dan I/O | Bab XIV | Interupsi BIOS/DOS dan Operasi I/O | 2.4 | CPMK02 |
| 14 | Debugging level instruksi | Bab XV | Debugging pada Level Instruksi | 4.1, 4.2 | CPMK04 |
| 15 | Disassembly dan optimasi | Bab XVI | Analisis Kode Mesin, Disassembly, dan Optimasi | 4.3 | CPMK04 |
| ~~16~~ | ~~Ujian Akhir Semester~~ | — | — | 3.1–4.3 | — |

CPL yang didukung: **CPL02** (minggu 1–7, 13) dan **CPL03** (minggu 9–12, 14–15).

---

## 4. Keputusan Arsitektur

### 4.1 Struktur direktori

```text
ppt/
├── RENCANA_PRESENTASI_PPT.md     # dokumen ini
├── minggu-01.pdf                 # hasil jadi minggu 1
├── ...
├── minggu-15.pdf
├── compile_ppt.bat               # kompilasi semua deck + bersihkan berkas antara
└── src/
    ├── preamble-ppt.tex          # tema, warna, paket, makro (dipakai bersama)
    ├── listing-ppt.tex           # gaya penampil kode assembly
    ├── minggu-01.tex             # sumber deck minggu 1
    ├── ...
    └── minggu-15.tex
```

**Alasan pemisahan `src/` dari `ppt/`:** berkas antara kompilasi (`.aux`, `.nav`,
`.snm`, `.toc`, `.out`) tidak pernah ikut masuk ke `ppt/`, sehingga folder `ppt/`
hanya berisi **PDF siap pakai** dan dokumen rencana — sesuai perintah yang meminta
"slide yang sudah jadi" diletakkan di `ppt`. Deck memanggil tema dari direktori yang
sama (`\input{preamble-ppt}`), sedangkan skrip kompilasi menaruh PDF hasil ke
direktori induk (`..`), yaitu `ppt/`.

### 4.2 Berkas tema bersama

`preamble-ppt.tex` memuat seluruh keputusan tampilan agar 14 deck seragam dan
perubahan tema cukup dilakukan di satu tempat:

1. `\documentclass[aspectratio=169,11pt]{beamer}` — dipanggil dari masing-masing
   deck, bukan dari preamble.
2. Warna OBE disalin dari `buku_ajar/config/styles.tex` supaya identitas visual
   buku dan slide sama:
   `obeBlue #1F3864`, `obeTeal #0F6E6E`, `obeGray #4A4A4A`,
   `obeAmber #8A5A00`, `obeGreen #2E6B34`, `obeMaroon #7A2233`, dst.
3. Tema dasar beamer (`default`) yang diwarnai ulang lewat `\setbeamercolor`,
   `\setbeamerfont`, dan headline sederhana berbasis `tikz`.
4. Makro notasi yang **sama persis** dengan buku, agar mahasiswa melihat notasi
   konsisten: `\eng{}`, `\code{}`, `\asm{}`, `\flag{}`, `\file{}`, `\dir{}`,
   `\dec{}`, `\CPMK{}`, `\CPL{}`, `\SubCPMK{}`, `\term{}`.
5. Lingkungan pengganti kotak buku: `subcpmkbox`/`tujuanbox`/`materibox`/
   `infobox` pada buku berbasis `tcolorbox`; pada slide diganti
   `block`/`alertblock`/`exampleblock` bawaan beamer (lihat §9).

### 4.3 Penamaan dan penomoran

- Nama berkas: `minggu-NN` dengan **dua digit** (`minggu-01`, `minggu-09`,
  `minggu-15`) agar urutan berkas benar saat diurutkan.
- Label frame mengikuti pola `\label{fr:mgNN-<topik>}` bila diperlukan rujukan
  silang antar slide.
- Judul deck: `Pertemuan NN — <Judul Bab>`.

---

## 5. Struktur Baku Satu Deck

Setiap deck memakai kerangka yang sama. Kolom "Frame" adalah jumlah frame
standar; bagian inti menyesuaikan jumlah subseksi bab.

| # | Frame | Isi | Sumber di buku |
|---|---|---|---|
| 1 | Judul | Judul bab, "Pertemuan NN", mata kuliah + kode, dosen, prodi/fakultas/PT, semester | — |
| 2 | Capaian & Tujuan | Kotak Sub-CPMK, CPMK & CPL pendukung, lalu 4–5 tujuan pembelajaran | `subcpmkbox` + `tujuanbox` di `chapter.tex` |
| 3 | Peta Materi | Outline 3 seksi + kaitan ke Sub-CPMK | `materibox` di `chapter.tex` |
| 4 | Section divider ×3 | Satu frame pemisah per `\section` | `\section{...}` |
| 5 | **Inti** | 1 frame per subseksi (9–16 frame), menyaring definisi, tabel, dan diagram penting | `section-01..03.tex` |
| 6 | Ringkasan seksi ×3 | 1 frame penutup tiap seksi, 3–4 butir kunci | akhir tiap `section-*.tex` |
| 7 | Contoh Program | 1 frame per contoh (2–3 frame), kode assembly dari buku + penjelasan singkat | `contoh.tex` |
| 8 | Praktikum | Tujuan, alat & bahan, langkah kerja ringkas, hasil yang dikumpulkan | `praktikum.tex` |
| 9 | Latihan | Soal latihan terpilih dari buku | `latihan.tex` |
| 10 | Rangkuman | Poin kunci bab + checklist pemahaman | `rangkuman.tex` |
| 11 | Kuis singkat | 2–3 soal cepat (diambil dari `evaluasi.tex`) untuk cek pemahaman di kelas | `evaluasi.tex` |
| 12 | Penutup | Ajakan membaca bab terkait + materi minggu berikutnya | — |

**Aturan kepadatan:** maksimal **6 butir** atau **±40 kata** per frame; kode
program dipotong pada bagian yang relevan (maksimal ±15 baris per frame) dengan
penanda `...` bila dilewati. Detail panjang tetap diarahkan ke buku, bukan
disalin ke slide.

---

## 6. Anggaran Frame per Minggu

Anggaran ini **direvisi dua kali** setelah Tahap 0. Anggaran awal (12 frame
tetap + subseksi) kurang menghitung frame per seksi, frame per contoh program,
dan frame ringkasan seksi. Formula yang cocok dengan kenyataan di lapangan:

> **Total frame ≈ 18 + jumlah subseksi + jumlah contoh program**
>
> (18 = 3 frame pembuka + 3 pemisah seksi + 3 ringkasan seksi + praktikum +
> latihan + rangkuman + cek pemahaman + penutup)

| Minggu | Bab | Subseksi | Contoh | Target frame |
|---|---|---|---|---|
| 1 | III | 11 | 3 | 32 |
| 2 | IV | 13 | 2 | 33 |
| 3 | V | 12 | 3 | 33 |
| 4 | VI | 11 | 2 | 31 |
| 5 | VII | 15 | 2 | 35 |
| 6 | VIII | 15 | 2 | 35 |
| 7 | IX | 9 | 2 | 29 |
| 9 | X | 16 | 3 | 37 |
| 10 | XI | 13 | 3 | 34 |
| 11 | XII | 15 | 2 | 35 |
| 12 | XIII | 14 | 2 | 34 |
| 13 | XIV | 16 | 2 | 36 |
| 14 | XV | 16 | 2 | 36 |
| 15 | XVI | 15 | 3 | 36 |
| | | | **Total** | **±476** |

**Keputusan yang mengikat (ditetapkan pemilik proyek):**

1. **Seluruh contoh program dipertahankan** — tidak dipangkas demi mengejar
   jumlah frame kecil, karena contoh program adalah bagian paling berguna di
   kelas.
2. **Frame "Rangkuman Bagian" wajib ada tiga buah per deck** (satu di akhir
   tiap seksi), konsisten dengan butir 6 pada §5. Deck minggu 3 sudah
   memilikinya; minggu 1 dan 4 disesuaikan; deck berikutnya wajib memuatnya.

Angka pada tabel adalah target, bukan kewajiban: boleh bergeser **±3 frame**.
Untuk pertemuan 2 SKS (±100 menit), 29–37 frame berarti ±3 menit per frame —
wajar untuk kuliah yang disertai praktik.

Yang **tidak boleh** dikorbankan demi angka: contoh program, frame praktikum,
dan frame latihan. Yang boleh diringkas bila kelebihan: penggabungan dua
subseksi ringan ke dalam satu frame.

---

## 7. Rencana Rinci per Minggu

Setiap minggu memuat: seksi bab, `contoh.tex`, `praktikum.tex`, `latihan.tex`,
`rangkuman.tex`, dan `evaluasi.tex` dari bab yang bersangkutan.

### Minggu 1 — Bab III: Pengenalan Pemrograman Tingkat Rendah dan Lingkungan Kerja
- **Sub-CPMK 1.1** · CPMK01 · CPL02
- Seksi: (1) Tingkat Abstraksi Bahasa Pemrograman; (2) Rantai Proses Pembuatan
  Program Assembly; (3) Lingkungan Kerja dan Struktur Program Assembly Minimal
- Contoh: Mencetak Teks dengan Layanan DOS · Program `.COM` dengan `ORG 100h` ·
  Menampilkan Karakter Satu per Satu
- Praktikum: memasang Emu8086 / GUI Turbo Assembler / DOSBox, merakit program pertama
- Titik berat: mahasiswa dapat merakit dan menjalankan satu program hari itu juga

### Minggu 2 — Bab IV: Arsitektur Mikroprosesor 8086
- **Sub-CPMK 1.1** · CPMK01 · CPL02
- Seksi: (1) Evolusi Mikroprosesor dan Kedudukan 8086; (2) Bus Interface Unit dan
  Execution Unit; (3) Bus Eksternal dan Siklus Instruksi
- Contoh: Menelusuri Siklus Instruksi sebuah Program · Dua Cara Menjumlahkan Dua Bilangan
- Diagram: arsitektur BIU–EU dan alur *fetch–decode–execute* (digambar ulang
  dengan `tikz`, disederhanakan dari gambar pada buku)

### Minggu 3 — Bab V: Register 8086 dan Register Flag
- **Sub-CPMK 1.2** · CPMK01 · CPL02
- Seksi: (1) Register Umum dan Register Segmen; (2) Register Pointer, Index, dan
  Instruction Pointer; (3) Register Flag
- Contoh: Memprediksi Flag Sebelum Menjalankan Program · Memilih Pesan Berdasarkan
  Flag · Akses Byte Rendah dan Byte Tinggi
- Titik berat: peta register dalam satu frame tabel + perilaku flag ZF/CF/SF/OF/PF/AF

### Minggu 4 — Bab VI: Segmentasi Memori dan Alamat Fisik
- **Sub-CPMK 1.3** · CPMK01 · CPL02
- Seksi: (1) Masalah Pengalamatan Memori dan Lahirnya Segmentasi; (2) Paragraf
  16-Byte, Struktur Segmen, dan Overlapping; (3) Peta Memori 1 MB dan Kasus Batas Alamat
- Contoh: Menampilkan Offset Variabel · Membaca Nilai Segmen dan Menghitung Alamat
- Titik berat: perhitungan alamat fisik 20-bit (`segment × 16 + offset`) dengan
  contoh hitung bertahap di slide

### Minggu 5 — Bab VII: Format Instruksi Mesin
- **Sub-CPMK 2.1** · CPMK02 · CPL02
- Seksi: (1) Dari Mnemonic ke Kode Mesin; (2) Byte ModR/M, Displacement, dan
  Immediate; (3) Encoding Manual dan Disassembler
- Contoh: Membongkar Program dengan Perintah `U` · Dua Bentuk Penulisan, Ukuran Berbeda
- Titik berat: membedah satu instruksi menjadi opcode + ModR/M + displacement

### Minggu 6 — Bab VIII: Mode Pengalamatan
- **Sub-CPMK 2.2** · CPMK02 · CPL02
- Seksi: (1) Operand dan Tiga Mode Pengalamatan Dasar; (2) Mode Memori Berpenunjuk
  dan Segmen Default; (3) Perbandingan Efisiensi dan Studi Kasus
- Contoh: Membandingkan Tiga Mode pada Array · Membaca Parameter dengan `[BP+disp]`
- Titik berat: tabel mode pengalamatan + segmen default (DS/SS) sebagai satu frame rujukan

### Minggu 7 — Bab IX: Direktif Assembler dan Alur Translasi Program
- **Sub-CPMK 2.3** · CPMK02 · CPL02
- Seksi: (1) Instruksi Mesin, Direktif Assembler, dan Direktif Data;
  (2) Direktif Simbol, Lokasi, dan Struktur Program; (3) Peran Assembler dan Linker
  dalam Alur Translasi
- Contoh: Mendemonstrasikan Semua Direktif Data · Konstanta `EQU`
- Praktikum: menyusun dan meng-*assemble* program pertama secara utuh
- Titik berat: diagram `.asm → .obj → .exe` dan peran assembler vs linker

### Minggu 9 — Bab X: Instruksi Transfer Data dan Aritmatika
- **Sub-CPMK 3.1** · CPMK03 · CPL03
- Seksi: (1) Instruksi Transfer Data; (2) Instruksi Aritmatika Dasar dan Pengaruhnya
  pada Flag; (3) Perkalian, Pembagian, dan Aritmatika Bertingkat
- Contoh: Kalkulator Penjumlahan dan Pengurangan · Perkalian, Pembagian, dan
  *Divide Overflow* · Penjumlahan 32 Bit dengan `ADC`
- Titik berat: tabel instruksi + efek flag; jebakan `DIV`/`IDIV` (DX:AX)

### Minggu 10 — Bab XI: Operasi Logika, Pergeseran, dan Rotasi
- **Sub-CPMK 3.2** · CPMK03 · CPL03
- Seksi: (1) Operasi Logika pada Level Bit; (2) Pergeseran dan Rotasi;
  (3) Studi Kasus Manipulasi Bit
- Contoh: Memeriksa Paritas Byte · Enkripsi dan Dekripsi dengan *XOR Cipher* ·
  Memanipulasi Bidang Bit Status
- Titik berat: tabel SHL/SHR/SAL/SAR/ROL/ROR dan beda *arithmetic* vs *logical shift*

### Minggu 11 — Bab XII: Struktur Kontrol dan Percabangan
- **Sub-CPMK 3.3** · CPMK03 · CPL03
- Seksi: (1) Flag sebagai Dasar Pengambilan Keputusan; (2) Lompatan Bersyarat dan
  Perulangan; (3) Penerjemahan Pola Bahasa Tingkat Tinggi ke Assembly
- Contoh: Mencari Nilai Maksimum Larik · Pengurutan Gelembung
- Titik berat: tabel `Jcc` (JE/JNE/JG/JL/JA/JB) + penerjemahan `if`/`while`/`for`

### Minggu 12 — Bab XIII: Prosedur dan Manajemen Stack
- **Sub-CPMK 3.4** · CPMK03 · CPL03
- Seksi: (1) Prosedur, Pemanggilan, dan Pengembalian; (2) Stack dan Operasi Stack;
  (3) Stack Frame, Konvensi Pemanggilan, dan Rekursi
- Contoh: Prosedur `HitungLuas` · Faktorial Rekursif
- Titik berat: gambar *stack frame* dan penelusuran `CALL`/`RET` langkah demi langkah

### Minggu 13 — Bab XIV: Interupsi BIOS/DOS dan Operasi I/O
- **Sub-CPMK 2.4** · CPMK02 · CPL02
- Seksi: (1) Konsep Interupsi dan Tabel Vektor; (2) Interupsi BIOS: Video, Keyboard,
  dan Printer; (3) Interupsi DOS dan Penangan Buatan Sendiri
- Contoh: Menyapa Pengguna dengan `INT 21h` · Teks Berwarna dengan `INT 10h`
- Titik berat: tabel layanan sering dipakai (`INT 21h` 09h/02h/0Ah, `INT 10h` 09h/13h)

### Minggu 14 — Bab XV: Debugging pada Level Instruksi
- **Sub-CPMK 4.1, 4.2** · CPMK04 · CPL03
- Seksi: (1) Taksonomi Kesalahan Program dan Alat Debugging; (2) Menelusuri Program
  dengan Perintah DEBUG; (3) Analisis Memori dan Stack serta Metodologi Debugging
- Contoh: Perulangan Tak Berujung · Stack yang Tidak Seimbang
- Titik berat: demonstrasi `T`/`P`/`G`/`D`/`R` — deck ini paling banyak memuat
  tangkapan layar/luaran teks

### Minggu 15 — Bab XVI: Analisis Kode Mesin, Disassembly, dan Optimasi
- **Sub-CPMK 4.3** · CPMK04 · CPL03
- Seksi: (1) Disassembly: Mengembalikan Kode Mesin ke Mnemonic; (2) Mengenali Pola
  Hasil Disassembly dan Metrik Optimasi; (3) Strategi Optimasi pada Level Instruksi
- Contoh: Versi Naif · Versi Teroptimasi · Versi Teroptimasi dengan *Loop Unrolling*
- Titik berat: perbandingan "sebelum vs sesudah" optimasi (ukuran byte, jumlah instruksi)

---

## 8. Spesifikasi Teknis

### 8.1 Kelas dan konfigurasi dokumen

```latex
\documentclass[aspectratio=169,11pt]{beamer}
\usefonttheme{professionalfonts}
```

- **Rasio 16:9** agar cocok dengan proyektor ruang kelas saat ini.
- **`11pt`** karena slide memuat banyak istilah teknis dan kode.
- Deck memuat `\input{preamble-ppt}` sehingga tema terpusat di satu berkas.

### 8.2 Tema dan warna

- Tema dasar: **`default`** yang diwarnai ulang (bukan tema siap pakai seperti
  `Madrid`/`metropolis`) supaya tampilan slide benar-benar mengikuti identitas buku.
- Palet diambil dari `buku_ajar/config/styles.tex`: biru `obeBlue` untuk judul dan
  bingkai, teal `obeTeal` untuk penekanan, abu `obeGray` untuk teks sekunder,
  amber/hijau/maroon untuk kotak peringatan–contoh–peringatan bahaya.
- Headline minimal: garis tipis `obeBlue` + judul seksi kecil + nomor frame.
- Footer: mata kuliah, kode MK, pertemuan ke-berapa, nomor slide.

### 8.3 Paket

`inputenc`, `fontenc[T1]`, `babel[indonesian]`, `lmodern`, `tikz`, `listings`,
`booktabs`, `array`, `amsmath`, `amsfonts`, `xcolor` (tanpa opsi `table`),
`ulem`, `hyperref` (untuk tautan daftar isi antar frame di dalam deck).

### 8.4 Penampil kode assembly

`listing-ppt.tex` menyalin gaya `buku_ajar/config/listings.tex` (latar `codeBack`,
bingkai `codeFrame`, nomor baris) lalu disesuaikan untuk slide: ukuran
`\footnotesize`, maksimal ±15 baris per frame, penyorotan baris penting dengan
`escapeinside` bila perlu. Gaya penyorotan komentar `;` dan penekanan sintaks
dibuat konsisten dengan buku.

### 8.5 Makro dan istilah

Seluruh makro notasi buku dipakai ulang apa adanya (`\eng`, `\code`, `\asm`,
`\flag`, `\file`, `\dir`, `\dec`, `\CPMK`, `\CPL`, `\SubCPMK`). Dengan begitu
penulisan "`\asm{MOV AX, BX}`" di slide identik dengan di buku, dan perubahan
gaya notasi cukup diubah di satu tempat.

---

## 9. Aturan Teknis Wajib dan Jebakan

Bagian ini mengikat karena lima kendala berikut sudah terbukti menggagalkan
kompilasi pada mesin ini (MiKTeX 24.1, LaTeX2e 2023-11-01):

1. **`colortbl` rusak — dilarang memakai `\rowcolor`/`\cellcolor`.** Paket
   `colortbl` terpasang menuntut makro `\insert@pcolumn` yang belum ada di
   `array.sty` bawaan, sehingga tabel `p{}` bergaya warna gagal dirakit. Karena
   itu **semua tabel di slide memakai `booktabs` polos**; penekanan baris
   dilakukan dengan teks tebal atau block beamer, bukan warna baris.
2. **Hindari `tcolorbox` `breakable` + `enumitem`.** Bila daftar berada dalam
   kotak yang terpotong antar halaman, `\end{enumerate}` pada potongan kedua
   gagal karena `\enit@after` bersifat lokal. Karena itu kotak pada slide
   memakai `block`/`alertblock`/`exampleblock` beamer, bukan `tcolorbox`.
3. **Selalu kompilasi dengan `--enable-installer` dan `timeout`.** MiKTeX dapat
   memunculkan dialog instalasi paket yang membuat `pdflatex` menggantung.
4. **`-output-directory` tidak membaca `.aux` dari direktori keluaran.** Untuk
   keperluan slide hal ini tidak menjadi masalah karena tiap deck berdiri
   sendiri dan tidak memakai sitasi bibliografi; bila kelak ditambahkan, set
   `TEXINPUTS` dengan direktori keluaran lebih dahulu dan hapus `.aux` lama di
   direktori sumber.

5. **`breaklines=true` + `postbreak=...` merusak listing di beamer.**
   Ditemukan saat Tahap 0. Kombinasi kedua opsi ini membuat `pdflatex`
   memuntahkan puluhan galat `Missing number, treated as zero <to be read
   again> \kern`, walaupun masing-masing opsi aman bila dipakai sendiri.
   Karena `\lstset{style=asmslide}` bersifat global, opsi `postbreak` juga
   bocor ke gaya lain (mis. `outslide`/`keluaran`) dan ikut merusaknya.
   Karena itu **`postbreak` dilarang di slide**; `breaklines=true` tetap
   dipakai. Di buku ajar (kelas `book`) justru sebaliknya — `postbreak` aman
   dan dipakai — jadi larangan ini khusus untuk slide.

**Catatan tentang tabel (hasil uji Tahap 0).** Kekhawatiran awal bahwa
`beamer` menyeret `colortbl` ternyata **tidak terbukti**: `beamer` tidak
memuat `colortbl`, dan tabel `p{}` dengan `booktabs` (`\toprule`,
`\midrule`, `\addlinespace`) **berhasil dirakit normal di dalam slide**.
Larangan `\rowcolor`/`\cellcolor` pada butir 1 tetap berlaku, tetapi tabel
`p{}` boleh dipakai bebas. Tabel pada slide memakai `booktabs` polos.

Tambahan:

- Setiap deck **tidak memuat bibliografi** — rujukan cukup ditulis sebagai teks
  kecil "Sumber: Bab NN, hal. xx" pada frame yang relevan (buku tidak memakai
  nomor halaman tetap, jadi cukup "Sumber: Bab NN").
- Setiap deck harus dapat dikompilasi **berdiri sendiri** tanpa deck lain.
- Berkas antara (`.aux`, `.nav`, `.snm`, `.toc`, `.out`, `.log`) dibersihkan
  setelah kompilasi oleh `compile_ppt.bat`.

---

## 10. Tahapan Pengerjaan (Bertahap per Minggu)

| Tahap | Pekerjaan | Keluaran |
|---|---|---|
| 0 | Tema bersama: `preamble-ppt.tex`, `listing-ppt.tex`, dan **deck contoh minggu 1** | 2 berkas tema + `src/minggu-01.tex` + `minggu-01.pdf` |
| 1 | Deck minggu 2–7 (Bagian pertama: CPMK01–CPMK02) | 6 deck |
| 2 | Deck minggu 9–12 (CPMK03: aritmatika, logika, kontrol, prosedur) | 4 deck |
| 3 | Deck minggu 13–15 (CPMK02 2.4 dan CPMK04: interupsi, debugging, optimasi) | 3 deck |
| 4 | `compile_ppt.bat`, kompilasi seluruh deck, pemeriksaan akhir | 14 PDF + skrip |

Tahap 0 dikerjakan lebih dahulu dan **ditinjau sebelum lanjut**, karena tema di
tahap inilah yang menentukan tampilan 13 deck berikutnya — mengubahnya setelah
semua deck jadi berarti mengulang seluruh pekerjaan.

Setiap deck selesai ditulis langsung dikompilasi untuk memastikan tidak ada
galat, bukan dikompilasi bersama-sama di akhir.

---

## 11. Kriteria Selesai (Definition of Done)

Sebuah deck dinyatakan selesai bila seluruh butir berikut terpenuhi:

1. `ppt/src/minggu-NN.tex` ada dan **berhasil dikompilasi tanpa galat**
   (`pdflatex` keluar dengan kode 0, tanpa "Undefined control sequence").
2. `ppt/minggu-NN.pdf` terbentuk, dapat dibuka, dan jumlah frame sesuai anggaran §6 (±2).
3. Deck memuat frame: judul, capaian & tujuan, peta materi, bagian inti,
   contoh program, praktikum, latihan, rangkuman, kuis, penutup.
4. Sub-CPMK, CPMK, dan CPL yang tercantum **cocok** dengan tabel §3 dan silabus.
5. Materi **tidak menyimpang** dari bab buku yang bersangkutan; istilah dan notasi
   memakai makro yang sama dengan buku.
6. Identitas di frame judul benar: Bahasa Pemrograman Tingkat Rendah (MWCA010),
   Semester Ganjil, Prodi Teknik Informatika, Fakultas Teknologi Informasi,
   Universitas Bale Bandung, Cecep Suwanda, S.Si., M.Kom.
7. Tidak ada galat *overfull box* yang membuat teks terpotong keluar frame
   (peringatan kecil masih dapat ditoleransi, teks terpotong tidak).
8. Tidak memakai `\rowcolor`/`\cellcolor` maupun `tcolorbox` `breakable`.

Kriteria tingkat proyek: **14 deck lengkap** (minggu 1–7 dan 9–15), seluruhnya
dapat dikompilasi ulang dari sumber oleh `compile_ppt.bat`, dan berkas antara
sudah bersih.

---

## 12. Risiko dan Mitigasi

| Risiko | Dampak | Mitigasi |
|---|---|---|
| Bab terlalu padat (±1.000–1.650 baris) sehingga slide jadi terlalu banyak teks | Slide tidak terbaca dari belakang kelas | Batas 6 butir / ±40 kata per frame; sisanya diarahkan ke buku |
| Diagram buku berupa `tikzpicture` kompleks | Gambar rusak atau meluber saat disalin ke slide | Sederhanakan diagram untuk slide; simpan versi lengkap hanya di buku |
| Kode assembly panjang melebihi tinggi frame | Teks terpotong | Potong maksimal ±15 baris + penanda `...`; pecah jadi 2 frame bila perlu |
| `colortbl`/`tcolorbox` merusak kompilasi | Deck gagal dirakit | Larangan pada §9, ditulis sebagai aturan wajib |
| Tema diubah setelah 14 deck jadi | Pekerjaan ulang besar | Tahap 0 ditinjau lebih dahulu sebelum deck lain ditulis |
| Istilah Indonesia–Inggris tidak konsisten antar deck | Mahasiswa bingung | Istilah mengikuti glosarium Lampiran C buku; makro `\eng{}` dipakai konsisten |
| Deck menyimpang dari RPS | Materi ujian tidak selaras | Pemetaan §3 dikunci ke silabus dan tabel Bab I buku |

---

## 13. Keputusan yang Sudah Ditetapkan

Empat hal berikut sudah diputuskan dan mengikat seluruh 14 deck:

| # | Hal | Keputusan |
|---|---|---|
| 1 | Tema visual | **Kustom berwarna OBE**, selaras buku (§8.2) |
| 2 | Rasio slide | **16:9** (`aspectratio=169`) |
| 3 | Penempatan berkas | **Sumber di `ppt/src/`**, PDF hasil jadi di `ppt/` (§4.1) |
| 4 | Kepadatan | **20–28 frame per deck** (§6) — belum ditetapkan lain, jadi usulan ini yang dipakai |

Dua hal berikut masih berada di luar lingkup perintah dan belum diputuskan:
apakah perlu dibuat **deck kisi-kisi UTS (minggu 8) dan UAS (minggu 16)**, dan
apakah perlu **deck untuk Bab I dan Bab II** (pengantar & landasan teori).

---

*Dokumen ini adalah rencana yang sudah disetujui. Pengerjaan dimulai dari Tahap 0
(pembuatan tema bersama dan deck minggu 1) untuk ditinjau sebelum dilanjutkan ke
13 deck berikutnya.*
