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
| Perkiraan frame per deck | 28–33 |
| Perkiraan total frame | ±424 |
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
| 1 | Pengantar pemrograman tingkat rendah: kedudukan bahasa assembly, sistem bilangan, bilangan bertanda dan tidak bertanda | Bab III | Pengantar Assembly dan Sistem Bilangan | 1.1 | CPMK01 |
| 2 | Arsitektur mikroprosesor 8086: BIU, EU, bus, *queue*, ALU, urutan pengambilan–eksekusi | Bab IV | Arsitektur Mikroprosesor 8086: BIU dan EU | 1.2 | CPMK01 |
| 3 | Register 8086: register umum, segmen, pointer/index, IP, dan *flag* | Bab V | Register 8086 dan Register Flag | 1.3 | CPMK01 |
| 4 | Organisasi memori: segmentasi 64 KB, alamat fisik, dan *overlapping* | Bab VI | Segmentasi Memori dan Alamat Fisik | 1.4 | CPMK01 |
| 5 | Memulai assembly: TASM, TLINK, program COM/EXE, direktif, label, komentar | Bab VII | Memulai Assembly: TASM, TLINK, COM, EXE, dan Direktif | 2.1 | CPMK02 |
| 6 | Instruksi transfer data: MOV, LEA, LDS/LES, XCHG, CMP, XLAT, CBW, CWD | Bab VIII | Instruksi Transfer Data | 2.2 | CPMK02 |
| 7 | Interupsi dan layanan BIOS/DOS: tabel vektor, INT 21h, INT 10h, INT 16h | Bab IX | Interupsi BIOS/DOS | 2.3 | CPMK02 |
| ~~8~~ | ~~Ujian Tengah Semester~~ | — | — | 1.1–2.3 | — |
| 9 | Operasi aritmatika: ADD, ADC, INC, SUB, SBB, DEC, MUL, DIV, dan *flag* | Bab X | Operasi Aritmatika | 3.1 | CPMK03 |
| 10 | Operasi logika dan manipulasi bit: NOT, AND, OR, XOR, TEST, SHL, SHR | Bab XI | Operasi Logika dan Shift | 3.2 | CPMK03 |
| 11 | Tujuh mode pengalamatan 8086 dan segmen *default* | Bab XII | Tujuh Mode Pengalamatan | 3.3 | CPMK03 |
| 12 | Percabangan dan perulangan: label, JMP, CMP, lompatan bersyarat, LOOP | Bab XIII | Percabangan dan Perulangan | 3.4 | CPMK03 |
| 13 | Stack, prosedur, dan macro: PUSH/POP, PROC/ENDP, CALL/RET, parameter | Bab XIV | Stack, Prosedur, dan Macro | 3.5 | CPMK03 |
| 14 | Array, string, dan pencetakan bilangan desimal/heksadesimal | Bab XV | Array, String, dan Pencetakan Bilangan | 3.6 | CPMK03 |
| 15 | Debugging level instruksi: *trace*, *dump*, analisis *hang* | Bab XVI | Debugging Level Instruksi | 4.1–4.3 | CPMK04 |
| ~~16~~ | ~~Ujian Akhir Semester~~ | — | — | 3.1–4.3 | — |

CPL yang didukung: **CPL02** (minggu 1–7) dan **CPL03** (minggu 9–15).

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

**PDF tidak disimpan di repositori.** Mengikuti konvensi repo ini (yang juga
mengabaikan `output/` dan `buku_ajar/chapters/*/chapter.pdf`), `ppt/*.pdf`
didaftarkan di `.gitignore`. Berkas PDF-nya tetap ada di disk dan dapat dibangun
ulang kapan saja dengan `compile_ppt.bat`; yang di-versi hanyalah sumbernya.

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
| 5 | **Inti** | 1 frame per subseksi (8–13 frame), menyaring definisi, tabel, dan diagram penting | `section-01..03.tex` |
| 6 | Ringkasan seksi ×3 | 1 frame penutup tiap seksi, 3–4 butir kunci | akhir tiap `section-*.tex` |
| 7 | Contoh Program | 1 frame per contoh program (1–2 frame), kode assembly dari buku + penjelasan singkat | `contoh.tex` |
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

Anggaran ini **dihitung ulang** pada 22 Oktober 2026 setelah buku ajar dan
RPS diselaraskan. Angka lama (29–37) tidak dipakai lagi karena angka itu
milik topik lama. Formula yang dipakai tetap:

> **Total frame ≈ 18 + jumlah subseksi + jumlah contoh program**
>
> (18 = 3 frame pembuka + 3 pemisah seksi + 3 ringkasan seksi + praktikum +
> latihan + rangkuman + cek pemahaman + penutup)

| Minggu | Bab | Subseksi | Contoh program | Target frame |
|---|---|---|---|---|
| 1 | III | 12 | 1 | 31 |
| 2 | IV | 12 | 2 | 32 |
| 3 | V | 10 | 2 | 30 |
| 4 | VI | 11 | 2 | 31 |
| 5 | VII | 13 | 2 | 33 |
| 6 | VIII | 10 | 2 | 30 |
| 7 | IX | 9 | 2 | 29 |
| 9 | X | 10 | 2 | 30 |
| 10 | XI | 8 | 2 | 28 |
| 11 | XII | 11 | 2 | 31 |
| 12 | XIII | 12 | 2 | 32 |
| 13 | XIV | 10 | 2 | 30 |
| 14 | XV | 8 | 2 | 28 |
| 15 | XVI | 9 | 2 | 29 |
| | | | **Total** | **±424** |

Jumlah subseksi dihitung dari `section-01.tex` sampai `section-03.tex`.
Jumlah contoh program dihitung dari `contoh.tex`: Bab III mempunyai satu
contoh berupa konversi bilangan tanpa program dan satu contoh program,
sedangkan bab lain mempunyai dua contoh program.

**Keputusan yang mengikat (ditetapkan pemilik proyek):**

1. **Seluruh contoh program dipertahankan** — tidak dipangkas demi mengejar
   jumlah frame kecil, karena contoh program adalah bagian paling berguna di
   kelas.
2. **Frame "Rangkuman Bagian" wajib ada tiga buah per deck** (satu di akhir
   tiap seksi), konsisten dengan butir 6 pada §5. Ketentuan ini berlaku untuk
   seluruh deck yang ditulis ulang tanpa pengecualian.

Angka pada tabel adalah target, bukan kewajiban: boleh bergeser **±3 frame**.
Untuk pertemuan 2 SKS (±100 menit), 28–33 frame berarti ±3 menit per frame —
wajar untuk kuliah yang disertai praktik.

Yang **tidak boleh** dikorbankan demi angka: contoh program, frame praktikum,
dan frame latihan. Yang boleh diringkas bila kelebihan: penggabungan dua
subseksi ringan ke dalam satu frame.

---

## 7. Rencana Rinci per Minggu

Setiap minggu memuat: seksi bab, `contoh.tex`, `praktikum.tex`, `latihan.tex`,
`rangkuman.tex`, dan `evaluasi.tex` dari bab yang bersangkutan.

### Minggu 1 — Bab III: Pengantar Assembly dan Sistem Bilangan
- **Sub-CPMK 1.1** · CPMK01 · CPL02
- Seksi: (1) Kedudukan dan Peran Bahasa Assembly; (2) Sistem Bilangan dan Konversi;
  (3) Bilangan Bertanda, Tak Bertanda, dan Data Karakter
- Contoh: Konversi Nilai 200 · Menyimpan Bilangan dalam Basis Berbeda
- Praktikum: konversi bilangan dan pemeriksaan data di memori
- Titik berat: konversi biner/desimal/oktal/heksadesimal, *two's complement*,
  dan hubungan kode ASCII dengan isi memori

### Minggu 2 — Bab IV: Arsitektur Mikroprosesor 8086: BIU dan EU
- **Sub-CPMK 1.2** · CPMK01 · CPL02
- Seksi: (1) Kedudukan 8086 dan Pembagian Unit Internal; (2) Bus Interface Unit:
  Bus, Queue, dan Alamat; (3) Execution Unit dan Urutan Pengambilan–Eksekusi
- Contoh: Menelusuri Program Pendek · Operand Register dan Operand Memori
- Praktikum: diagram blok 8086 dan penelusuran siklus instruksi
- Diagram: arsitektur BIU–EU dan alur *fetch–decode–execute* (digambar ulang
  dengan `tikz`, disederhanakan dari gambar pada bab)

### Minggu 3 — Bab V: Register 8086 dan Register Flag
- **Sub-CPMK 1.3** · CPMK01 · CPL02
- Seksi: (1) Register Umum dan Register Segmen; (2) Register Pointer, Index, dan
  Instruction Pointer; (3) Register Flag dan Pengaruhnya pada Keputusan
- Contoh: Memprediksi Flag Sebelum Menjalankan Program · Memilih Pesan Berdasarkan Flag
- Praktikum: pengamatan register dan *flag* dengan *single step*
- Titik berat: peta register dalam satu frame tabel + perilaku
  ZF/CF/SF/OF/PF/AF

### Minggu 4 — Bab VI: Segmentasi Memori dan Alamat Fisik
- **Sub-CPMK 1.4** · CPMK01 · CPL02
- Seksi: (1) Mengapa Segmentasi Diperlukan; (2) Paragraf 16 Byte, Segmen 64 KB,
  dan Overlapping; (3) Pembagian Memori 1 MB dan Verifikasi Alamat
- Contoh: Menampilkan Offset Variabel · Menghitung Alamat Fisik di Dalam Program
- Praktikum: menghitung dan memverifikasi alamat fisik dengan *debugger*
- Titik berat: perhitungan alamat fisik 20-bit
  (`segment × 16 + offset`) dengan contoh hitung bertahap di slide

### Minggu 5 — Bab VII: Memulai Assembly: TASM, TLINK, COM, EXE, dan Direktif
- **Sub-CPMK 2.1** · CPMK02 · CPL02
- Seksi: (1) Rantai Proses Pembuatan Program Assembly; (2) Struktur Program
  Assembly; (3) Direktif Data dan Alur Translasi
- Contoh: Program Pertama · Direktif Data
- Praktikum: menulis, meng-*assemble*, men-*link*, dan menjalankan program
  `.EXE` serta `.COM`
- Titik berat: diagram `.ASM → .OBJ → .EXE/.COM`, fungsi `.MODEL`, `ORG 100h`,
  `.CODE`, `.DATA`, serta direktif `DB`/`DW`/`DD`/`EQU`/`DUP`

### Minggu 6 — Bab VIII: Instruksi Transfer Data
- **Sub-CPMK 2.2** · CPMK02 · CPL02
- Seksi: (1) Instruksi MOV dan Aturan Operand; (2) LEA, LDS/LES, XCHG, dan CMP;
  (3) XLAT, CBW, dan CWD
- Contoh: Menelusuri Transfer Data · Memuat Far Pointer
- Praktikum: menelusuri instruksi transfer data dengan *single step*
- Titik berat: aturan operand `MOV`, perbedaan `LEA` dan `MOV`, *far pointer*,
  serta konversi ukuran dengan `CBW`/`CWD`

### Minggu 7 — Bab IX: Interupsi BIOS/DOS
- **Sub-CPMK 2.3** · CPMK02 · CPL02
- Seksi: (1) Konsep Interupsi dan Tabel Vektor; (2) Interupsi BIOS;
  (3) Interupsi DOS
- Contoh: Membaca Nama dengan `INT 21h` · Menulis Teks Berwarna dengan `INT 10h`
- Praktikum: menggunakan layanan BIOS/DOS dan memeriksa tabel vektor interupsi
- Titik berat: tabel layanan yang sering dipakai (`INT 21h` 09h/0Ah/4Ch,
  `INT 10h`, `INT 16h`) dan alur penyimpanan/pemulihan keadaan prosesor

### Minggu 9 — Bab X: Operasi Aritmatika
- **Sub-CPMK 3.1** · CPMK03 · CPL03
- Seksi: (1) Penjumlahan dan Pengurangan; (2) Perkalian dan Pembagian;
  (3) Flag, Tanda Bilangan, dan Verifikasi Hasil
- Contoh: Operasi Aritmatika Lengkap · MUL dan DIV 16 Bit
- Praktikum: menelusuri operasi aritmatika dan memeriksa hasilnya
- Titik berat: `ADD`/`ADC`/`INC`/`SUB`/`SBB`/`DEC`, pengaruh *flag*, aturan
  `MUL`/`DIV` (DX:AX), dan *divide overflow*

### Minggu 10 — Bab XI: Operasi Logika dan Shift
- **Sub-CPMK 3.2** · CPMK03 · CPL03
- Seksi: (1) Operasi Logika Dasar; (2) Mask dan Instruksi TEST;
  (3) Pergeseran SHL dan SHR
- Contoh: Memeriksa Paritas · XOR Cipher
- Praktikum: manipulasi bit dengan `SHR`, `TEST`, dan `XOR`
- Titik berat: tabel kebenaran `NOT`/`AND`/`OR`/`XOR`, penggunaan *mask*,
  perbedaan `TEST` dan `CMP`, serta pergeseran untuk perkalian/pembagian
  dengan pangkat dua

### Minggu 11 — Bab XII: Tujuh Mode Pengalamatan
- **Sub-CPMK 3.3** · CPMK03 · CPL03
- Seksi: (1) Operand dan Tiga Mode Dasar; (2) Mode Memori Berpenunjuk;
  (3) Segmen Default dan Penerapan
- Contoh: Tiga Mode untuk Array yang Sama · Tujuh Mode untuk Satu Elemen
- Praktikum: membandingkan mode pengalamatan pada akses array
- Titik berat: tabel tujuh mode, perhitungan alamat efektif, dan segmen
  *default* (`DS`/`SS`) sebagai satu frame rujukan

### Minggu 12 — Bab XIII: Percabangan dan Perulangan
- **Sub-CPMK 3.4** · CPMK03 · CPL03
- Seksi: (1) Label, JMP, dan CMP; (2) Lompatan Bersyarat dan Percabangan;
  (3) Perulangan
- Contoh: Mencari Nilai Maksimum · Pengurutan Gelembung
- Praktikum: menelusuri percabangan dan perulangan pada program array
- Titik berat: tabel `Jcc` untuk bilangan bertanda dan tidak bertanda,
  penerjemahan `if`/`while`/`for`, `LOOP`, dan perulangan bersarang

### Minggu 13 — Bab XIV: Stack, Prosedur, dan Macro
- **Sub-CPMK 3.5** · CPMK03 · CPL03
- Seksi: (1) Stack dan Instruksi PUSH/POP; (2) Prosedur dan Penyampaian Data;
  (3) Macro
- Contoh: Prosedur Berparameter melalui Stack · Macro dengan Parameter
- Praktikum: menelusuri stack, prosedur berparameter, dan macro
- Titik berat: sifat LIFO, `SS:SP`/`SS:BP`, `CALL`/`RET`, *stack frame*,
  dan perbedaan prosedur dengan macro

### Minggu 14 — Bab XV: Array, String, dan Pencetakan Bilangan
- **Sub-CPMK 3.6** · CPMK03 · CPL03
- Seksi: (1) Array Satu dan Multi Dimensi; (2) String; (3) Mencetak Bilangan
  Desimal dan Heksadesimal
- Contoh: Menjumlahkan Array dan Menyalin String · Mencetak Bilangan Desimal
  dan Heksadesimal
- Praktikum: mengolah array/string dan mencetak bilangan
- Titik berat: perhitungan offset elemen array, string sebagai array byte,
  konversi bilangan ke digit ASCII, dan pencetakan dengan layanan DOS

### Minggu 15 — Bab XVI: Debugging Level Instruksi
- **Sub-CPMK 4.1–4.3** · CPMK04 · CPL03
- Seksi: (1) Jenis Kesalahan dan Alat Debugging; (2) Menelusuri Program per
  Instruksi; (3) Memeriksa Memori, Stack, dan Memperbaiki Hang
- Contoh: Perulangan Tak Berujung · Stack Tidak Seimbang
- Praktikum: menemukan dan memperbaiki kesalahan dengan *single step* dan *dump*
- Titik berat: demonstrasi `T`/`P`/`G`/`D`/`R`, perbedaan kesalahan sintaks,
  kesalahan logika, dan *hang*, serta bukti perbaikan

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
| 2 | Deck minggu 9–12 (CPMK03: aritmatika, logika, mode pengalamatan, percabangan) | 4 deck |
| 3 | Deck minggu 13–15 (CPMK03 3.5–3.6 dan CPMK04 4.1–4.3: stack/prosedur/macro, array/string, debugging) | 3 deck |
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
2. `ppt/minggu-NN.pdf` terbentuk, dapat dibuka, dan jumlah frame sesuai anggaran §6 (±3).
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
| 4 | Kepadatan | **28–33 frame per deck** (§6), hasil hitung ulang dari bab yang sudah diselaraskan |

Dua hal berikut masih berada di luar lingkup perintah dan belum diputuskan:
apakah perlu dibuat **deck kisi-kisi UTS (minggu 8) dan UAS (minggu 16)**, dan
apakah perlu **deck untuk Bab I dan Bab II** (pengantar & landasan teori).

---

*Dokumen ini adalah rencana yang sudah disetujui. Pengerjaan dimulai dari Tahap 0
(pembuatan tema bersama dan deck minggu 1) untuk ditinjau sebelum dilanjutkan ke
13 deck berikutnya.*
