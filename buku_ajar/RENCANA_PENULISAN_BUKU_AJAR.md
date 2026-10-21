# RENCANA PENULISAN BUKU AJAR
## Bahasa Pemrograman Tingkat Rendah (Assembly 8086)

**Program Studi Teknik Informatika — Fakultas Teknologi Informasi**
**Universitas Bale Bandung**
**Mata Kuliah:** Bahasa Pemrograman Tingkat Rendah (MWCA010, 3 SKS)
**Edisi:** Pertama
**Tahun:** 2026
**Basis:** RPS berbasis *Outcome-Based Education* (OBE) — `rps_silabus/silabus.tex`

---

## 1. Ringkasan

Dokumen ini adalah **rencana penulisan per-bab** buku ajar Bahasa Pemrograman
Tingkat Rendah. Penulisan dilakukan **bertahap, satu bab per satu tahap**,
dengan setiap bab merupakan modul LaTeX mandiri yang dapat dikompilasi
sendiri maupun sebagai bagian dari buku utuh.

| Item | Nilai |
|---|---|
| Jumlah bab inti (unit materi) | 14 bab (Bab III–Bab XVI) |
| Jumlah bab pengikat | 2 bab (Bab I Pendahuluan, Bab II Landasan Teori) |
| Bab penutup | 1 bab (Bab XVII Evaluasi dan Integrasi Kompetensi) |
| Lampiran | 4 lampiran (A–D) |
| Total unit ditulis | 17 bab + 4 lampiran |
| CPL didukung | CPL02, CPL03 |
| CPMK didukung | CPMK01, CPMK02, CPMK03, CPMK04 |
| Sub-CPMK didukung | 1.1–1.4, 2.1–2.3, 3.1–3.6, 4.1–4.3 (16 Sub-CPMK) |
| Bahasa | Indonesia (istilah teknis dipertahankan dalam bahasa Inggris) |
| Target prosesor | Intel 8086 (mode real, 16-bit) |
| Perangkat praktik | TASM, TLINK, DEBUG, emu8086, DOSBox, Turbo Debugger |
| Sumber isi | Dua buku lokal: [1] Indra Gunawan (2019); [2] S'to (2001) |

---

## 2. Keputusan Arsitektur Penulisan

Rencana ini mengikuti `Arsitektur_Buku_Ajar.md` dan
`struktur_bab_buku_ajar_OBE.text`.

### 2.1 Struktur direktori

```text
buku_ajar/
├── main.tex                 # master document
├── preamble.tex             # penghubung konfigurasi
├── metadata.tex             # metadata buku
├── references.bib           # bibliografi bersama
├── RENCANA_PENULISAN_BUKU_AJAR.md   # dokumen ini
│
├── config/                  # KONFIGURASI TEKNIS (tanpa materi)
│   ├── packages.tex
│   ├── commands.tex
│   ├── environments.tex
│   ├── styles.tex
│   └── listings.tex
│
├── frontmatter/             # KONTEN depan
│   ├── cover.tex
│   ├── copyright.tex
│   ├── preface.tex
│   ├── acknowledgements.tex
│   └── learning-outcomes.tex
│
├── chapters/NN/             # KONTEN bab (NN = 01..17)
│   ├── chapter.tex          # \documentclass[../../main.tex]{subfiles}
│   ├── section-01.tex       # \subfile
│   ├── section-02.tex       # \subfile
│   ├── section-03.tex       # \subfile
│   ├── contoh.tex           # \input
│   ├── praktikum.tex        # \input
│   ├── latihan.tex          # \input
│   ├── rangkuman.tex        # \input
│   ├── evaluasi.tex         # \input
│   └── figures/
│
├── appendices/              # KONTEN lampiran
├── assets/                  # RESOURCES visual
├── code/asm/                # RESOURCES source code assembly
├── build/
└── scripts/                 # skrip kompilasi
```

Jumlah folder bab **tetap 17**, yaitu `chapters/01` sampai `chapters/17`.
Tidak ada penambahan atau penghapusan folder.

### 2.2 Aturan teknis wajib

1. Bab dimuat dengan `\subfile{chapters/NN/chapter}` dari `main.tex`.
2. Section mandiri memakai `\subfile{section-NN}`.
3. Potongan kecil memakai `\input{...}` (`contoh`, `praktikum`, `latihan`,
   `rangkuman`, `evaluasi`).
4. **Tidak ada** `\usepackage` di dalam `chapter.tex` maupun section —
   seluruh package di `config/packages.tex`.
5. Setiap bab **harus dapat dikompilasi sendiri** dari dalam foldernya:
   `pdflatex -interaction=nonstopmode chapter.tex`.
6. Label konsisten: `chap:`, `sec:`, `fig:`, `tab:`, `eq:`, `lst:`.
7. Nomor direktori bab dua digit (`01`, `02`, …, `17`).
8. Sitasi memakai `\cite{}`/`\citep{}` ke `references.bib` bersama.
9. Tidak memakai `colortbl`, `\rowcolor`, atau `\cellcolor`.
10. Tabel memakai `booktabs`; diagram memakai TikZ; label unik.

### 2.3 Gaya penulisan

- Bahasa Indonesia baku, kalimat aktif, sasaran pembaca mahasiswa semester 2.
- Setiap konsep diikuti **contoh kode assembly lengkap** yang dapat dirakit
  dengan TASM atau emu8086.
- Kode assembly panjang (> 25 baris) disimpan di `code/asm/` dan dimasukkan
  dengan `\lstinputlisting`; kode pendek ditulis langsung dengan
  `lstlisting`.
- Setiap bab memuat elemen OBE: Sub-CPMK, materi, contoh, praktikum,
  latihan, rangkuman, evaluasi, checklist pencapaian kompetensi, refleksi,
  dan daftar rujukan bab.
- Isi diparafrase dari dua buku sumber. Bab dan halaman sumber disebut pada
  setiap bab.

---

## 3. Pemetaan Silabus → Bab Buku

### 3.1 Pemetaan CPL – CPMK – Sub-CPMK

```text
CPL02 ──┬── CPMK01 (arsitektur register & manajemen memori)
        │      ├── Sub-CPMK 1.1  pengantar assembly & sistem bilangan
        │      ├── Sub-CPMK 1.2  arsitektur 8086: BIU & EU
        │      ├── Sub-CPMK 1.3  register & flag
        │      └── Sub-CPMK 1.4  segmentasi memori & alamat fisik
        │
        └── CPMK02 (hubungan instruksi mesin dengan hardware)
               ├── Sub-CPMK 2.1  memulai assembly, TASM/TLINK, COM/EXE
               ├── Sub-CPMK 2.2  instruksi transfer data
               └── Sub-CPMK 2.3  interupsi BIOS/DOS

CPL03 ──┬── CPMK03 (menulis kode Assembly aritmatika & logika)
        │      ├── Sub-CPMK 3.1  operasi aritmatika
        │      ├── Sub-CPMK 3.2  operasi logika & shift
        │      ├── Sub-CPMK 3.3  tujuh mode pengalamatan
        │      ├── Sub-CPMK 3.4  percabangan & perulangan
        │      ├── Sub-CPMK 3.5  stack, prosedur, & macro
        │      └── Sub-CPMK 3.6  array, string, & pencetakan bilangan
        │
        └── CPMK04 (debugging level instruksi memori)
               ├── Sub-CPMK 4.1  penelusuran per instruksi
               ├── Sub-CPMK 4.2  pemeriksaan memori & stack
               └── Sub-CPMK 4.3  analisis & perbaikan kesalahan
```

### 3.2 Tabel pemetaan bab

| Bab | Judul Bab | Pertemuan | Sub-CPMK | CPMK | CPL |
|:---:|---|:---:|:---:|:---:|:---:|
| I | Pendahuluan dan Orientasi Buku | — | — | — | CPL02, CPL03 |
| II | Landasan Teori dan Konsep Dasar | — | — | — | CPL02, CPL03 |
| III | Pengantar Assembly dan Sistem Bilangan | 1 | 1.1 | CPMK01 | CPL02 |
| IV | Arsitektur Mikroprosesor 8086: BIU dan EU | 2 | 1.2 | CPMK01 | CPL02 |
| V | Register 8086 dan Register Flag | 3 | 1.3 | CPMK01 | CPL02 |
| VI | Segmentasi Memori dan Alamat Fisik | 4 | 1.4 | CPMK01 | CPL02 |
| VII | Memulai Assembly: TASM, TLINK, COM, EXE, dan Direktif | 5 | 2.1 | CPMK02 | CPL02 |
| VIII | Instruksi Transfer Data | 6 | 2.2 | CPMK02 | CPL02 |
| IX | Interupsi BIOS/DOS | 7 | 2.3 | CPMK02 | CPL02 |
| — | *UTS (Minggu 8)* | 8 | 1.1–2.3 | CPMK01–CPMK02 | CPL02 |
| X | Operasi Aritmatika | 9 | 3.1 | CPMK03 | CPL03 |
| XI | Operasi Logika dan Shift | 10 | 3.2 | CPMK03 | CPL03 |
| XII | Tujuh Mode Pengalamatan | 11 | 3.3 | CPMK03 | CPL03 |
| XIII | Percabangan dan Perulangan | 12 | 3.4 | CPMK03 | CPL03 |
| XIV | Stack, Prosedur, dan Macro | 13 | 3.5 | CPMK03 | CPL03 |
| XV | Array, String, dan Pencetakan Bilangan | 14 | 3.6 | CPMK03 | CPL03 |
| XVI | Debugging Level Instruksi | 15 | 4.1–4.3 | CPMK04 | CPL03 |
| — | *UAS (Minggu 16)* | 16 | 3.1–4.3 | CPMK03–CPMK04 | CPL03 |
| XVII | Evaluasi, Refleksi, dan Integrasi Kompetensi | — | Semua | Semua | CPL02, CPL03 |

### 3.3 Peta bab → folder

| Bab | Folder | Pertemuan |
|:---:|---|---|
| I | `chapters/01/` | — |
| II | `chapters/02/` | — |
| III | `chapters/03/` | 1 |
| IV | `chapters/04/` | 2 |
| V | `chapters/05/` | 3 |
| VI | `chapters/06/` | 4 |
| VII | `chapters/07/` | 5 |
| VIII | `chapters/08/` | 6 |
| IX | `chapters/09/` | 7 |
| X | `chapters/10/` | 9 |
| XI | `chapters/11/` | 10 |
| XII | `chapters/12/` | 11 |
| XIII | `chapters/13/` | 12 |
| XIV | `chapters/14/` | 13 |
| XV | `chapters/15/` | 14 |
| XVI | `chapters/16/` | 15 |
| XVII | `chapters/17/` | — |

---

## 4. Rencana Rinci per Bab

Setiap bab mengikuti kerangka OBE:

1. **Judul Bab**
2. **Outcome Pembelajaran Khusus Bab (Sub-CPMK)**
3. **Materi Pokok** — rinci dengan contoh, ilustrasi, grafik, kasus
4. **Aktivitas Pembelajaran yang Direkomendasikan**
5. **Soal Latihan & Refleksi**
6. **Asesmen (Evaluasi Kinerja)**
7. **Checklist Pencapaian Kompetensi**

---

### Bab I — Pendahuluan dan Orientasi Buku
**Folder:** `chapters/01/` · **Pertemuan:** — · **Sub-CPMK:** —

**Tujuan bab:** mahasiswa memahami tujuan buku, keterkaitannya dengan RPS
berbasis OBE, dan cara menggunakan buku secara efektif.

**Materi pokok:**
1. Tujuan buku ajar dan capaian pembelajaran buku (CPL02, CPL03).
2. Keterkaitan buku dengan RPS: CPL → CPMK → Sub-CPMK → materi.
3. Cara menggunakan buku: alur belajar per bab, peran praktikum, dan
   jurnal refleksi.
4. Peta perjalanan belajar 16 pertemuan, termasuk UTS dan UAS.
5. Perangkat praktik: TASM, TLINK, DEBUG, emu8086, DOSBox, dan Turbo
   Debugger.
6. Etika laboratorium dan penyimpanan berkas `.ASM`, `.OBJ`, `.EXE`, `.COM`.

**Sumber:** [1] Bagian 4, hlm. 26–34; [2] BAB V, hlm. 21–24.

**Aktivitas:** orientasi kelas, pembacaan peta konsep buku, penyusunan target
belajar pribadi.

**Asesmen:** kuis diagnostik awal (tanpa nilai) dan lembar target belajar.

**Checklist:** memahami struktur buku, mampu menjelaskan jalur CPL→Sub-CPMK,
mengetahui perangkat lunak yang akan dipakai.

---

### Bab II — Landasan Teori dan Konsep Dasar
**Folder:** `chapters/02/` · **Pertemuan:** — · **Sub-CPMK:** —

**Tujuan bab:** mahasiswa memiliki fondasi konseptual tentang hierarki bahasa
pemrograman, mesin penyimpan program, dan representasi data pada level mesin.

**Materi pokok:**
1. Hierarki bahasa pemrograman: mesin → assembly → tingkat tinggi.
2. Konsep kunci: *instruction set architecture*, instruksi, operand,
   register, memori, dan siklus instruksi.
3. Model mesin penyimpan program (*stored-program*).
4. Representasi data: biner, oktal, desimal, heksadesimal, bilangan
   bertanda, BCD, dan ASCII.
5. Peran register dan memori dalam eksekusi instruksi.
6. Peran interupsi sebagai penghubung program dengan perangkat keras.
7. Peta konsep seluruh buku: 14 unit materi, UTS, dan UAS.

**Sumber:** [1] Bagian 1–2, hlm. 10–18; [2] BAB I–II, hlm. 6–13; BAB IV,
hlm. 17–20.

**Aktivitas:** latihan konversi bilangan, pembacaan peta konsep, diskusi
mengapa pemahaman level mesin penting.

**Asesmen:** kuis konversi bilangan dan istilah dasar.

**Checklist:** mampu mengonversi bilangan, menjelaskan siklus instruksi,
membaca peta konsep buku.

---

### Bab III — Pengantar Assembly dan Sistem Bilangan
**Folder:** `chapters/03/` · **Pertemuan:** 1 · **Sub-CPMK:** 1.1 · **CPMK01**

**Sub-CPMK (disalin dari RPS):**
> Menjelaskan peran bahasa assembly serta mengonversi bilangan biner,
> desimal, oktal, dan heksadesimal, termasuk membedakan bilangan bertanda
> dan tidak bertanda.

**Materi pokok:**
1. Kedudukan bahasa assembly di antara bahasa mesin dan bahasa tingkat
   tinggi.
2. Peran bahasa assembly dalam kendali perangkat keras dan efisiensi ukuran
   program.
3. Jenis bilangan: biner, oktal, desimal, dan heksadesimal.
4. Konversi antarjenis bilangan dan penulisan literal bilangan pada
   assembler (akhiran `B`, `D`, `H`, atau tanpa akhiran).
5. Bilangan bertanda dan tidak bertanda; konsep *two's complement*.
6. Kode ASCII dan hubungannya dengan pencetakan karakter.
7. Contoh penerapan: menuliskan data bilangan pada `.DATA` dan memeriksa
   hasilnya di DEBUG.

**Sumber:** [1] Bagian 1, hlm. 10–11; [2] BAB I, hlm. 6–8.

**Contoh:** konversi bilangan dan penulisan literal pada program data.

**Praktikum:** latihan konversi bilangan, penulisan data, dan pemeriksaan
isi memori dengan DEBUG.

**Latihan:** 8 soal konversi dan analisis bilangan bertanda/tidak bertanda.

**Evaluasi:** kuis tertulis dan soal uraian konversi.

**Checklist:** mampu mengonversi bilangan, menuliskan literal yang diterima
assembler, dan menjelaskan perbedaan bilangan bertanda/tidak bertanda.

---

### Bab IV — Arsitektur Mikroprosesor 8086: BIU dan EU
**Folder:** `chapters/04/` · **Pertemuan:** 2 · **Sub-CPMK:** 1.2 · **CPMK01**

**Sub-CPMK (disalin dari RPS):**
> Menjelaskan pembagian *Bus Interface Unit* dan *Execution Unit*, peran bus,
> *queue* instruksi, dan ALU, serta urutan pengambilan dan eksekusi instruksi
> pada 8086.

**Materi pokok:**
1. Evolusi mikroprosesor dan kedudukan 8086 sebagai dasar arsitektur
   prosesor berikutnya.
2. Pembagian internal 8086: *Bus Interface Unit* (BIU) dan *Execution Unit*
   (EU).
3. Tugas BIU: pengalamatan, pengambilan instruksi, dan transfer data.
4. Bus alamat, bus data, dan bus kontrol.
5. *Instruction queue* 6 byte dan pengaruhnya terhadap pengambilan
   instruksi.
6. Tugas EU: dekode, eksekusi, ALU, dan pemberitahuan alamat operand.
7. Operand, instruksi, dan peran *instruction decoder and control*.
8. Urutan pengambilan dan eksekusi instruksi (*fetch–decode–execute*).

**Sumber:** [1] Bagian 2, hlm. 12–18; [2] BAB II, hlm. 9–10.

**Contoh:** diagram alur pengambilan dan eksekusi `MOV AX, 1234h`.

**Praktikum:** menggambar diagram BIU/EU dan menelusuri satu instruksi
dengan *single step*.

**Latihan:** 8 soal analisis arsitektur dan alur instruksi.

**Evaluasi:** kuis diagram dan tes tertulis.

**Checklist:** mampu menggambar blok BIU/EU, menjelaskan peran *queue*,
menyebutkan lebar bus 8086.

---

### Bab V — Register 8086 dan Register Flag
**Folder:** `chapters/05/` · **Pertemuan:** 3 · **Sub-CPMK:** 1.3 · **CPMK01**

**Sub-CPMK (disalin dari RPS):**
> Mengidentifikasi register umum (AX–DX), register segmen (CS, DS, SS, ES),
> register *pointer*/*index* (SP, BP, SI, DI), IP, dan *flag* beserta pengaruh
> *flag* terhadap keputusan program.

**Materi pokok:**
1. Register umum AX, BX, CX, DX dan akses *low/high byte* (AL, AH, dan
   seterusnya).
2. Peran khusus tiap register umum.
3. Register segmen CS, DS, SS, dan ES.
4. Register *pointer* dan *index*: SP, BP, SI, dan DI.
5. Register *instruction pointer* (IP) dan pasangan CS:IP.
6. Register *flag*: CF, PF, AF, ZF, SF, OF, DF, IF, dan TF.
7. Makna setiap *flag* dan kapan nilainya berubah.
8. Pengaruh *flag* terhadap pengambilan keputusan dan lompatan bersyarat.

**Sumber:** [1] Bagian 2, hlm. 13–18; [2] BAB IV, hlm. 17–20.

**Contoh:** tabel perubahan *flag* setelah `ADD AL, BL` untuk beberapa nilai.

**Praktikum:** mengamati register dan *flag* dengan emu8086 serta DEBUG.

**Latihan:** 8 soal identifikasi register, prediksi *flag*, dan analisis hasil.

**Evaluasi:** tugas laporan observasi register/*flag* dan kuis.

**Checklist:** mampu memetakan register dan fungsinya, memprediksi nilai
*flag* setelah operasi sederhana.

---

### Bab VI — Segmentasi Memori dan Alamat Fisik
**Folder:** `chapters/06/` · **Pertemuan:** 4 · **Sub-CPMK:** 1.4 · **CPMK01**

**Sub-CPMK (disalin dari RPS):**
> Menghitung alamat fisik dari pasangan *segment:offset* serta menjelaskan
> pembagian memori 1 MB dan *overlapping* segmen.

**Materi pokok:**
1. Mengapa segmentasi diperlukan: register 16-bit dan bus alamat 20-bit.
2. Pembagian blok memori PC.
3. Alamat logis (*segment:offset*) dan alamat fisik.
4. Perhitungan alamat fisik: segmen × 10h + offset.
5. Paragraf 16-byte dan struktur segmen 64 KB.
6. *Overlapping* segmen dan banyaknya pasangan alamat untuk satu lokasi.
7. Peta memori 1 MB: *conventional memory*, area video, ROM BIOS, dan tabel
   vektor interupsi.
8. Verifikasi alamat dengan DEBUG.

**Sumber:** [2] BAB II, hlm. 9–13; [1] Bagian 2.1.1, hlm. 13–15.

**Contoh:** enam perhitungan alamat fisik bertingkat, termasuk kasus
*overlapping*.

**Praktikum:** menghitung dan memverifikasi alamat dengan DEBUG.

**Latihan:** 10 soal perhitungan alamat dan analisis peta memori.

**Evaluasi:** kuis perhitungan alamat dan soal esai.

**Checklist:** mampu menghitung alamat fisik, menjelaskan *overlapping*, dan
menyebutkan pembagian memori 1 MB.

---

### Bab VII — Memulai Assembly: TASM, TLINK, COM, EXE, dan Direktif
**Folder:** `chapters/07/` · **Pertemuan:** 5 · **Sub-CPMK:** 2.1 · **CPMK02**

**Sub-CPMK (disalin dari RPS):**
> Menjelaskan struktur program assembly (`.MODEL`, `ORG 100h`, `.CODE`,
> `.DATA`, label, komentar) dan alur translasi `.ASM` → `.OBJ` →
> `.EXE`/`.COM`.

**Materi pokok:**
1. Editor teks dan penyimpanan berkas `.ASM`.
2. Peran assembler TASM dan linker TLINK.
3. Perbedaan program COM dan EXE: jumlah segmen, ukuran, dan kecepatan.
4. Direktif `.MODEL` dan pilihan model memori.
5. `ORG 100h` dan *Program Segment Prefix* pada program COM.
6. Direktif `.CODE` dan `.DATA`.
7. Aturan penulisan label dan komentar.
8. Struktur program minimal dan cara mengakhiri program (`INT 20h` atau
   `INT 21h` fungsi `4Ch`).
9. Alur kerja: menulis → meng-assemble → men-link → menjalankan.

**Sumber:** [1] Bagian 4, hlm. 26–34; [2] BAB V–VI, hlm. 21–26.

**Contoh:** program COM pertama yang mencetak satu karakter dan program
EXE minimal.

**Praktikum:** menulis, meng-assemble dengan TASM, men-link dengan TLINK,
dan menjalankan program COM/EXE.

**Latihan:** 8 soal direktif, struktur program, dan pembacaan pesan
kesalahan assembler.

**Evaluasi:** tugas portofolio `.ASM` → `.OBJ` → `.EXE`/`.COM` dan kuis.

**Checklist:** mampu membedakan direktif dan instruksi, merakit program,
menjelaskan perbedaan COM dan EXE.

---

### Bab VIII — Instruksi Transfer Data
**Folder:** `chapters/08/` · **Pertemuan:** 6 · **Sub-CPMK:** 2.2 · **CPMK02**

**Sub-CPMK (disalin dari RPS):**
> Menerapkan instruksi transfer data (MOV, LEA, LDS/LES, XCHG, CMP, XLAT,
> CBW, CWD) untuk memindahkan data antar register, memori, dan segmen.

**Materi pokok:**
1. Aturan operand pada instruksi transfer data.
2. `MOV` antarregister dan antara register–memori.
3. `LEA` untuk mengambil alamat efektif.
4. `LDS` dan `LES` untuk memuat register segmen.
5. `XCHG` untuk menukar isi operand.
6. `CMP` untuk membandingkan operand dan memperbarui *flag*.
7. `XLAT` untuk menerjemahkan isi tabel ke AL.
8. `CBW` dan `CWD` untuk konversi ukuran operand.
9. Studi kasus: menyalin data dan menukar isi register/memori.

**Sumber:** [1] Bagian 5, hlm. 35–44; [2] BAB V, hlm. 21–24.

**Contoh:** program penyalinan data antarregister dan ke memori, serta
pertukaran isi register.

**Praktikum:** menelusuri perpindahan data dengan DEBUG dan emu8086.

**Latihan:** 8 soal prediksi isi register/memori dan penulisan program.

**Evaluasi:** tugas program transfer data dan kuis.

**Checklist:** mampu memilih instruksi transfer yang tepat, menjelaskan
perubahan *flag* oleh `CMP`, dan memakai `LEA`/`XLAT`.

---

### Bab IX — Interupsi BIOS/DOS
**Folder:** `chapters/09/` · **Pertemuan:** 7 · **Sub-CPMK:** 2.3 · **CPMK02**

**Sub-CPMK (disalin dari RPS):**
> Menjelaskan mekanisme interupsi dan tabel vektor interupsi serta
> menggunakan layanan BIOS/DOS (INT 21h, INT 10h, INT 16h) untuk operasi
> masukan dan keluaran.

**Materi pokok:**
1. Konsep *hardware interrupt* dan *software interrupt*.
2. Tabel vektor interupsi 1 KB pada alamat 0000h–03FFh.
3. Mekanisme `INT` dan `IRET`; penyimpanan `FLAGS`, `CS`, dan `IP`.
4. BIOS interrupt: `INT 10h` untuk layanan video dan `INT 16h` untuk
   *keyboard*.
5. DOS interrupt `INT 21h`: fungsi `01h`, `02h`, `09h`, `0Ah`, dan `4Ch`.
6. `INT 20h` dan cara mengakhiri program.
7. Operasi keluaran: mencetak karakter dan kalimat.
8. Operasi masukan: membaca karakter dan kalimat dari *keyboard*.

**Sumber:** [1] Bagian 3, hlm. 19–25; Bagian 18, hlm. 179–204; [2] BAB III,
hlm. 14–16; BAB VII, hlm. 27–31; BAB XII, hlm. 63–67; BAB XV, hlm. 78–84;
BAB XVIII, hlm. 93–109.

**Contoh:** program mencetak kalimat dengan `INT 21h` fungsi `09h` dan
program membaca masukan *keyboard*.

**Praktikum:** mencetak karakter/kalimat, mengatur posisi kursor, dan membaca
masukan dengan layanan BIOS/DOS.

**Latihan:** 8 soal peta fungsi interupsi dan penulisan program I/O.

**Evaluasi:** tugas program I/O dan kuis.

**Checklist:** mampu menyebutkan fungsi interupsi utama, menulis program
masukan/keluaran, dan menjelaskan tabel vektor interupsi.

---

### Bab X — Operasi Aritmatika
**Folder:** `chapters/10/` · **Pertemuan:** 9 · **Sub-CPMK:** 3.1 · **CPMK03**

**Sub-CPMK (disalin dari RPS):**
> Menulis program dengan instruksi ADD, ADC, INC, SUB, SBB, DEC, MUL, dan DIV
> serta menjelaskan pengaruhnya terhadap *flag*.

**Materi pokok:**
1. Penulisan bilangan desimal, biner, oktal, dan heksadesimal pada program.
2. Penjumlahan: `ADD`, `ADC`, dan `INC`.
3. Pengurangan: `SUB`, `SBB`, dan `DEC`.
4. Perkalian: `MUL` dan aturan operand 8-bit/16-bit.
5. Pembagian: `DIV` dan aturan operand 8-bit/16-bit.
6. Pengaruh operasi aritmatika terhadap CF, OF, ZF, SF, PF, dan AF.
7. Bilangan bertanda dan tidak bertanda pada operasi aritmatika.
8. Pencetakan hasil operasi ke layar.

**Sumber:** [1] Bagian 14, hlm. 127–142; [2] BAB VIII, hlm. 32–40.

**Contoh:** program penjumlahan, pengurangan, perkalian, dan pembagian
bilangan 8-bit/16-bit.

**Praktikum:** membuat program kalkulator sederhana dan menelusuri *flag*
dengan DEBUG.

**Latihan:** 8 soal prediksi hasil, analisis *flag*, dan penulisan program.

**Evaluasi:** tugas program aritmatika dan tes *coding* terbatas.

**Checklist:** mampu menulis program aritmatika, menjelaskan efek *flag*, dan
menangani *overflow*.

---

### Bab XI — Operasi Logika dan Shift
**Folder:** `chapters/11/` · **Pertemuan:** 10 · **Sub-CPMK:** 3.2 · **CPMK03**

**Sub-CPMK (disalin dari RPS):**
> Menerapkan operasi NOT, AND, OR, XOR, TEST, SHL, dan SHR untuk manipulasi
> bit.

**Materi pokok:**
1. Operasi logika: `NOT`, `AND`, `OR`, dan `XOR`.
2. Penerapan *masking*, *setting*, *clearing*, dan *toggling* bit.
3. `TEST` dan perbedaannya dengan `CMP`.
4. Pergeseran logis: `SHL` dan `SHR`.
5. Pengaruh pergeseran terhadap *flag* CF, ZF, SF, dan PF.
6. Pemeriksaan paritas dan manipulasi bit tertentu.
7. Penerapan `XOR` untuk mengosongkan register.
8. Studi kasus: pengemasan dan pembacaan bit data.

**Sumber:** [1] Bagian 7, hlm. 68–73; [2] BAB X, hlm. 47–51.

**Contoh:** program *masking* bit, pemeriksaan paritas, dan pengosongan
register dengan `XOR`.

**Praktikum:** manipulasi bit dan pemeriksaan hasil dengan DEBUG.

**Latihan:** 8 soal operasi bitwise dan penulisan program.

**Evaluasi:** kuis operasi logika dan tugas program manipulasi bit.

**Checklist:** mampu menghitung hasil operasi bitwise, memilih `SHL`/`SHR`
yang tepat, dan menerapkan *masking*.

---

### Bab XII — Tujuh Mode Pengalamatan
**Folder:** `chapters/12/` · **Pertemuan:** 11 · **Sub-CPMK:** 3.3 · **CPMK03**

**Sub-CPMK (disalin dari RPS):**
> Menerapkan tujuh mode pengalamatan 8086 (*register*, *immediate*, *direct
> memory*, *indirect memory*, *base relative*, *direct index*, *based
> indexed*) pada instruksi transfer dan aritmatika.

**Materi pokok:**
1. Konsep operand dan mode pengalamatan.
2. *Register addressing* dan *immediate addressing*.
3. *Direct memory addressing*.
4. *Indirect memory addressing* dengan `[BX]`, `[SI]`, `[DI]`, dan `[BP]`.
5. *Base relative addressing* dan *direct index addressing*.
6. *Based indexed addressing* dan kombinasi register yang legal.
7. Segmen *default* dan pengaruh pasangan register terhadap segmen.
8. Perhitungan alamat efektif dan verifikasi dengan DEBUG.

**Sumber:** [1] Bagian 9, hlm. 78–92; [2] BAB XI, hlm. 52–62.

**Contoh:** satu operasi yang sama ditulis dalam tujuh mode pengalamatan.

**Praktikum:** menelusuri alamat efektif dan isi memori dengan DEBUG.

**Latihan:** 8 soal penentuan mode, alamat efektif, dan segmen *default*.

**Evaluasi:** tugas analisis mode pengalamatan dan kuis.

**Checklist:** mampu mengenali mode dari penulisan operand, menghitung alamat
efektif, dan menentukan segmen *default*.

---

### Bab XIII — Percabangan dan Perulangan
**Folder:** `chapters/13/` · **Pertemuan:** 12 · **Sub-CPMK:** 3.4 · **CPMK03**

**Sub-CPMK (disalin dari RPS):**
> Menyusun percabangan dan perulangan dengan label, JMP, CMP, lompatan
> bersyarat, dan LOOP.

**Materi pokok:**
1. Aturan penulisan label.
2. Lompatan tanpa syarat `JMP`.
3. `CMP` sebagai penyiap *flag*.
4. Lompatan bersyarat untuk bilangan bertanda dan tidak bertanda.
5. Perulangan dengan `LOOP`.
6. Pola penerjemahan `if`, `if–else`, `while`, dan `for` ke assembly.
7. Penghindaran perulangan tanpa akhir.
8. Studi kasus: percabangan bersyarat dan pencetakan berulang.

**Sumber:** [1] Bagian 11, hlm. 101–114; [2] BAB XIII, hlm. 68–72.

**Contoh:** penerjemahan pseudocode `if–else` dan perulangan ke assembly.

**Praktikum:** membuat program bercabang dan berulang dengan `LOOP`.

**Latihan:** 8 soal penerjemahan pseudocode dan prediksi alur program.

**Evaluasi:** tugas program percabangan/perulangan dan uji *tracing*.

**Checklist:** mampu memilih lompatan bersyarat yang benar, menerjemahkan
pseudocode, dan menghindari *infinite loop*.

---

### Bab XIV — Stack, Prosedur, dan Macro
**Folder:** `chapters/14/` · **Pertemuan:** 13 · **Sub-CPMK:** 3.5 · **CPMK03**

**Sub-CPMK (disalin dari RPS):**
> Menggunakan stack (PUSH/POP), prosedur (PROC/ENDP, CALL/RET), dan macro
> dalam program yang modular.

**Materi pokok:**
1. Fungsi stack sebagai penyimpan sementara.
2. Sifat LIFO dan pasangan register SS:SP.
3. Instruksi `PUSH` dan `POP`.
4. Prosedur dengan `PROC`/`ENDP` dan pemanggilan `CALL`/`RET`.
5. Penyampaian data ke prosedur melalui register, stack, dan variabel.
6. Perbedaan prosedur dan macro.
7. Penulisan macro dan penggunaannya.
8. Kesalahan umum: stack tidak seimbang dan urutan `PUSH`/`POP` terbalik.

**Sumber:** [1] Bagian 12–13, hlm. 115–126; [2] BAB XIV, hlm. 73–77;
BAB XVI–XVII, hlm. 85–92.

**Contoh:** prosedur mencetak kalimat, prosedur berparameter melalui
register/stack, dan macro sederhana.

**Praktikum:** membuat prosedur dan macro, lalu memeriksa isi stack dengan
DEBUG.

**Latihan:** 8 soal analisis stack dan penulisan prosedur/macro.

**Evaluasi:** tugas program modular dan asesmen kinerja.

**Checklist:** mampu menggambar isi stack saat `CALL`, menulis prosedur
berparameter, dan membuat macro.

---

### Bab XV — Array, String, dan Pencetakan Bilangan
**Folder:** `chapters/15/` · **Pertemuan:** 14 · **Sub-CPMK:** 3.6 · **CPMK03**

**Sub-CPMK (disalin dari RPS):**
> Mengolah array dan string serta mencetak bilangan desimal dan heksadesimal
> ke layar.

**Materi pokok:**
1. Array satu dimensi dan penempatannya di memori.
2. Array multi dimensi dan penyimpanan satu dimensi.
3. Pengaksesan array dengan register *index* dan perulangan.
4. Operasi string: penyalinan, perbandingan, dan pencarian.
5. Konversi bilangan ke kode ASCII.
6. Pencetakan bilangan desimal dengan pembagian dan stack.
7. Pencetakan bilangan heksadesimal dengan pergeseran dan *masking*.
8. Studi kasus: mencetak daftar data dan hasil perhitungan.

**Sumber:** [1] Bagian 10, hlm. 93–100; Bagian 14.1, hlm. 127–131;
Bagian 16, hlm. 154–158; [2] BAB IX, hlm. 41–46; BAB XIX–XX, hlm. 110–121.

**Contoh:** program mencetak isi array, menyalin string, dan mencetak
bilangan desimal/heksadesimal.

**Praktikum:** mengolah array/string dan mencetak bilangan.

**Latihan:** 8 soal analisis array/string dan penulisan program.

**Evaluasi:** tugas program pengolahan data dan kuis.

**Checklist:** mampu mengakses array, mengolah string, dan mencetak bilangan
desimal/heksadesimal.

---

### Bab XVI — Debugging Level Instruksi
**Folder:** `chapters/16/` · **Pertemuan:** 15 · **Sub-CPMK:** 4.1–4.3 · **CPMK04**

**Sub-CPMK (disalin dari RPS):**
> 4.1 Melakukan penelusuran program per instruksi (*single step*/*trace*) dan
> memantau perubahan register serta *flag*.
>
> 4.2 Memeriksa isi memori dan stack (*dump*) untuk menemukan kesalahan
> sintaks dan kesalahan logika.
>
> 4.3 Menganalisis penyebab program berhenti (*hang*) dan memperbaiki
> kesalahan berdasarkan hasil penelusuran.

**Materi pokok:**
1. Jenis kesalahan: sintaks dan logika.
2. Alat debugging: DEBUG pada DOSBox, emu8086, dan Turbo Debugger.
3. Perintah DEBUG untuk memeriksa register, memori, dan eksekusi.
4. Penelusuran per instruksi (*single step*/*trace*).
5. Pemantauan register dan *flag* pada setiap langkah.
6. Pemeriksaan isi memori dan stack (*dump*).
7. Analisis penyebab program berhenti (*hang*).
8. Metodologi debugging: reproduksi → isolasi → hipotesis → uji → perbaikan.

**Sumber:** [1] Bagian 4.2–4.3, hlm. 29–32; [2] BAB XXVII, hlm. 194–202.

**Contoh:** sesi *trace* tabel per langkah untuk program yang mengandung
kesalahan logika.

**Praktikum:** debugging terpandu pada beberapa kasus kesalahan sintaks dan
logika.

**Latihan:** 8 soal analisis *trace* dan perbaikan program.

**Evaluasi:** asesmen kinerja debugging dengan rubrik dan laporan *trace*.

**Checklist:** mampu memakai DEBUG/emu8086/Turbo Debugger, membaca *dump*,
dan menemukan kesalahan logika.

---

### Bab XVII — Evaluasi, Refleksi, dan Integrasi Kompetensi
**Folder:** `chapters/17/` · **Pertemuan:** — · **Sub-CPMK:** Semua

**Tujuan bab:** mahasiswa mengukur pencapaian kompetensi secara menyeluruh
dan merencanakan tindak lanjut.

**Materi pokok:**
1. Rekapitulasi CPL–CPMK–Sub-CPMK dan peta ketercapaian.
2. Kisi-kisi UTS (CPMK01–CPMK02) dan UAS (CPMK03–CPMK04).
3. Rubrik penilaian komprehensif berbasis OBE dengan bobot sesuai RPS.
4. Pedoman proyek akhir: kalkulator, pengolah array/string, konversi dan
   pencetakan bilangan, atau menu teks dengan interupsi BIOS/DOS.
5. Tinjauan pencapaian kompetensi: *self-assessment* dan *peer assessment*.
6. Portofolio dan jurnal refleksi: format dan rubrik.
7. Rekomendasi tindak lanjut dalam lingkup 8086: memperdalam layanan
   BIOS/DOS, prosedur/macro, dan pengolahan data.
8. Penutup buku.

**Sumber:** [1] Bagian 1–18; [2] BAB I–XXVII.

**Aktivitas:** pengerjaan proyek akhir, presentasi, *self-assessment*, dan
penyusunan rencana belajar lanjutan.

**Asesmen:** UAS, proyek akhir, portofolio, dan rubrik refleksi.

**Checklist:** seluruh CPMK terbukti tercapai, portofolio lengkap, dan
rencana tindak lanjut tersusun.

---

## 5. Lampiran yang Direncanakan

| Lampiran | Isi | File |
|---|---|---|
| A | Rubrik penilaian lengkap terhubung ke CPMK (tugas, praktikum, kuis, UTS, UAS, proyek akhir) | `appendices/appendix-a.tex` |
| B | Contoh tugas, portofolio, dan rubrik refleksi | `appendices/appendix-b.tex` |
| C | Glosarium istilah (Indonesia–Inggris) | `appendices/appendix-c.tex` |
| D | Referensi dan sumber belajar (dua buku sumber) | `appendices/appendix-d.tex` |

---

## 6. Tahapan Penulisan (Bertahap per Bab)

| Tahap | Lingkup | Keluaran | Status |
|:---:|---|---|:---:|
| 0 | Rencana penulisan (dokumen ini) | `RENCANA_PENULISAN_BUKU_AJAR.md` | ✅ |
| 1 | Penyelarasan ringkasan: `README.md`, `learning-outcomes.tex`, `references.bib`, `appendix-d.tex` | dokumen ringkasan sesuai RPS baru | ✅ |
| 2 | Penulisan ulang Bab III–XVI, satu bab per giliran | `chapters/03`–`16` | ✅ |
| 3 | Penulisan ulang Bab I, Bab II, dan Bab XVII | `chapters/01`, `02`, `17` | ✅ |
| 4 | Penyesuaian Lampiran A–C bila rubrik/tugas/glosarium tidak sesuai | `appendices/` | ✅ |
| 5 | Kompilasi buku utuh dan perbaikan error | `output/main.pdf` | ✅ |

Urutan penulisan ulang bab: **03, 04, 05, 06, 07, 08, 09, 10, 11, 12, 13,
14, 15, 16, lalu 01, 02, 17**. Setiap giliran diakhiri kompilasi bab dari
dalam foldernya. Bab berikutnya tidak dimulai sebelum bab yang sedang
dikerjakan lolos kompilasi.

---

## 7. Kriteria Selesai (Definition of Done)

Sebuah bab dinyatakan selesai apabila:

- [ ] `chapter.tex` ada dan memakai `\documentclass[../../main.tex]{subfiles}`.
- [ ] Memuat Sub-CPMK yang disalin dari bagian 4 RPS, materi, contoh,
      praktikum, latihan, rangkuman, evaluasi, checklist kompetensi, dan
      refleksi.
- [ ] Memuat minimal satu diagram TikZ dan dua tabel ber-label.
- [ ] Memuat minimal dua contoh program; berkas `code/asm/` dibuat bila perlu.
- [ ] Seluruh label unik dan seluruh `\ref`/`\cite` valid.
- [ ] Tidak ada `\usepackage`, `\rowcolor`, atau `\cellcolor`.
- [ ] `pdflatex -interaction=nonstopmode chapter.tex` berhasil tanpa error.
- [ ] Muncul dengan benar pada kompilasi `main.tex`.

---

## 8. Konvensi Kode Assembly

- Prosesor: **Intel 8086**, mode real, 16-bit.
- Sintaks: **MASM/TASM** (kompatibel emu8086).
- Program `.COM` sederhana memakai `ORG 100h`; program `.EXE` memakai
  `.MODEL` dan inisialisasi segmen.
- Keluar program: `INT 20h` (`.COM`) atau `MOV AX, 4C00h` / `INT 21h`.
- Cetak string: `INT 21h` fungsi `09h` (string berakhir `$`).
- Cetak karakter: `INT 21h` fungsi `02h`.
- Semua berkas contoh: `code/asm/*.asm`.
- Komentar berbahasa Indonesia, satu baris `;` per instruksi penting.

---

## 9. Risiko dan Mitigasi

| Risiko | Mitigasi |
|---|---|
| Inkosistensi istilah antar-bab | glosarium Lampiran C dan review silang |
| Perbedaan sintaks TASM dan emu8086 | standar MASM/TASM dan catatan perbedaan di praktikum |
| Bab gagal dikompilasi mandiri | setiap bab diuji `pdflatex chapter.tex` dari foldernya |
| Isi keluar dari dua buku sumber | setiap bab menyebut bab/halaman sumber dan diverifikasi terhadap RPS |
| Ketergantungan package MiKTeX | package umum dan auto-install MiKTeX |

---

*Dokumen ini menjadi acuan tunggal penulisan bab dan diperbarui setiap tahap
penulisan selesai.*
