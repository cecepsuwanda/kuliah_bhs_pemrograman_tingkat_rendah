# RENCANA PENULISAN BUKU AJAR
## Pemrograman Bahasa Tingkat Rendah (Assembly 8086)

**Program Studi Teknik Informatika — Fakultas Teknik**
**Mata Kuliah:** Pemrograman Bahasa Tingkat Rendah (TIF-201, 3 SKS)
**Edisi:** Pertama
**Tahun:** 2026
**Basis:** RPS berbasis *Outcome-Based Education* (OBE) — `rps_silabus/silabus.tex`

---

## 1. Ringkasan

Dokumen ini adalah **rencana penulisan per-bab** buku ajar Pemrograman Bahasa
Tingkat Rendah. Penulisan dilakukan **bertahap, satu bab per satu tahap**,
dengan setiap bab merupakan modul LaTeX mandiri yang dapat dikompilasi
sendiri maupun sebagai bagian dari buku utuh.

| Item | Nilai |
|---|---|
| Jumlah bab inti (unit materi) | 15 bab (Bab III–Bab XVII) |
| Jumlah bab pengikat | 2 bab (Bab I Pendahuluan, Bab II Landasan Teori) |
| Bab penutup | 1 bab (Bab XVIII Evaluasi & Integrasi Kompetensi) |
| Lampiran | 4 lampiran (A–D) |
| Total unit ditulis | 18 bab + 4 lampiran |
| CPL didukung | CPL02, CPL03 |
| CPMK didukung | CPMK01, CPMK02, CPMK03, CPMK04 |
| Sub-CPMK didukung | 1.1–1.3, 2.1–2.4, 3.1–3.4, 4.1–4.3 (14 Sub-CPMK) |
| Bahasa | Indonesia (istilah teknis dipertahankan dalam bahasa Inggris) |
| Target prosesor | Intel 8086 (mode real, 16-bit) |
| Assembler acuan | MASM/TASM (*Turbo Assembler*) & Emu8086 |

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
├── chapters/NN/             # KONTEN bab (NN = 01..18)
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

### 2.2 Aturan teknis wajib

1. Bab memakai `\include{chapters/NN/chapter}` dari `main.tex`.
2. Section mandiri memakai `\subfile{section-NN}`.
3. Potongan kecil memakai `\input{...}` (`contoh`, `praktikum`, `latihan`,
   `rangkuman`, `evaluasi`).
4. **Tidak ada** `\usepackage` di dalam `chapter.tex` maupun section —
   seluruh package di `config/packages.tex`.
5. Setiap bab **harus dapat dikompilasi sendiri**:
   `latexmk -pdf chapters/NN/chapter.tex`.
6. Label konsisten: `chap:`, `sec:`, `fig:`, `tab:`, `eq:`, `lst:`.
7. Nomor direktori bab dua digit (`01`, `02`, …, `18`).
8. Sitasi memakai `\cite{}`/`\citep{}` ke `references.bib` bersama.

### 2.3 Gaya penulisan

- Bahasa Indonesia baku, kalimat aktif, sasaran pembaca mahasiswa semester 2.
- Setiap konsep diikuti **contoh kode assembly lengkap** yang dapat dirakit
  dengan Emu8086/GUI TASM.
- Kode assembly disimpan di `code/asm/` dan dimasukkan dengan
  `\lstinputlisting` bila panjang (> 25 baris); kode pendek ditulis langsung
  dengan environment `lstlisting`.
- Setiap bab memuat elemen OBE: Sub-CPMK, materi, contoh, praktikum,
  latihan, rangkuman, evaluasi, checklist pencapaian kompetensi, refleksi,
  dan daftar rujukan bab.

---

## 3. Pemetaan Silabus → Bab Buku

### 3.1 Pemetaan CPL – CPMK – Sub-CPMK

```text
CPL02 ──┬── CPMK01 (arsitektur register & manajemen memori)
        │      ├── Sub-CPMK 1.1  arsitektur 8086 & siklus instruksi
        │      ├── Sub-CPMK 1.2  register umum/segmen/pointer/flag
        │      └── Sub-CPMK 1.3  segmentasi memori & alamat fisik 20-bit
        │
        └── CPMK02 (hubungan instruksi mesin dengan hardware)
               ├── Sub-CPMK 2.1  format instruksi mesin (opcode, ModR/M)
               ├── Sub-CPMK 2.2  mode pengalamatan & segmen default
               ├── Sub-CPMK 2.3  direktif assembler & alur translasi
               └── Sub-CPMK 2.4  interupsi BIOS/DOS sebagai jembatan I/O

CPL03 ──┬── CPMK03 (menulis kode Assembly aritmatika & logika)
        │      ├── Sub-CPMK 3.1  instruksi transfer data & aritmatika
        │      ├── Sub-CPMK 3.2  operasi logika, geser, rotasi
        │      ├── Sub-CPMK 3.3  struktur kontrol (CMP/Jcc/LOOP/CALL)
        │      └── Sub-CPMK 3.4  prosedur, parameter passing, stack frame
        │
        └── CPMK04 (debugging level instruksi memori)
               ├── Sub-CPMK 4.1  single-step, breakpoint, pantau register/flag
               ├── Sub-CPMK 4.2  dump memori & stack, analisis kesalahan
               └── Sub-CPMK 4.3  disassembly & optimasi level instruksi
```

### 3.2 Tabel pemetaan bab

| Bab | Judul Bab | Pertemuan | Sub-CPMK | CPMK | CPL |
|:---:|---|:---:|:---:|:---:|:---:|
| I | Pendahuluan dan Orientasi Buku | — | — | — | CPL02, CPL03 |
| II | Landasan Teori dan Konsep Dasar | — | — | — | CPL02, CPL03 |
| III | Pengenalan Pemrograman Tingkat Rendah dan Lingkungan Kerja | 1 | 1.1 | CPMK01 | CPL02 |
| IV | Arsitektur Mikroprosesor 8086 | 2 | 1.1 | CPMK01 | CPL02 |
| V | Register 8086 dan Register Flag | 3 | 1.2 | CPMK01 | CPL02 |
| VI | Segmentasi Memori dan Alamat Fisik | 4 | 1.3 | CPMK01 | CPL02 |
| VII | Format Instruksi Mesin | 5 | 2.1 | CPMK02 | CPL02 |
| VIII | Mode Pengalamatan | 6 | 2.2 | CPMK02 | CPL02 |
| IX | Direktif Assembler dan Alur Translasi Program | 7 | 2.3 | CPMK02 | CPL02 |
| — | *UTS (Minggu 8)* | 8 | 1.1–2.3 | CPMK01–02 | CPL02 |
| X | Instruksi Transfer Data dan Aritmatika | 9 | 3.1 | CPMK03 | CPL03 |
| XI | Operasi Logika, Pergeseran, dan Rotasi | 10 | 3.2 | CPMK03 | CPL03 |
| XII | Struktur Kontrol dan Percabangan | 11 | 3.3 | CPMK03 | CPL03 |
| XIII | Prosedur dan Manajemen Stack | 12 | 3.4 | CPMK03 | CPL03 |
| XIV | Interupsi BIOS/DOS dan Operasi I/O | 13 | 2.4 | CPMK02 | CPL02 |
| XV | Debugging pada Level Instruksi | 14 | 4.1, 4.2 | CPMK04 | CPL03 |
| XVI | Analisis Kode Mesin, Disassembly, dan Optimasi | 15 | 4.3 | CPMK04 | CPL03 |
| — | *UAS (Minggu 16)* | 16 | 3.1–4.3 | CPMK03–04 | CPL03 |
| XVII | Evaluasi, Refleksi, dan Integrasi Kompetensi | — | Semua | Semua | CPL02, CPL03 |
| XVIII | *(cadangan/unit tambahan bila diperlukan)* | — | — | — | — |

> **Catatan penomoran:** Bab I dan Bab II adalah bab pengikat (bukan unit materi
> inti), sehingga unit materi inti menempati Bab III–Bab XVII sesuai pola
> `struktur_bab_buku_ajar_OBE.text`. Bab XVII adalah bab penutup evaluasi.
> Bab XVIII disediakan sebagai slot cadangan dan tidak diisi pada edisi ini.

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
| XVIII | `chapters/18/` | *(cadangan, tidak diisi)* |

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
1. Tujuan buku ajar dan *learning outcomes* buku (CPL02, CPL03).
2. Keterkaitan buku dengan RPS berbasis OBE: CPL → CPMK → Sub-CPMK → materi.
3. Cara menggunakan buku ajar: alur belajar per bab, peran praktikum, peran
   jurnal refleksi.
4. Ringkasan konteks kurikulum OBE dan posisi mata kuliah dalam kurikulum.
5. Peta perjalanan belajar 16 pertemuan.

**Aktivitas:** orientasi kelas, pembacaan peta konsep buku, penyusunan target
belajar pribadi.

**Asesmen:** kuis diagnostik awal (tanpa nilai) + lembar target belajar.

**Checklist:** memahami struktur buku, mampu menjelaskan jalur CPL→Sub-CPMK,
mengetahui perangkat lunak yang akan dipakai.

---

### Bab II — Landasan Teori dan Konsep Dasar
**Folder:** `chapters/02/` · **Pertemuan:** — · **Sub-CPMK:** —

**Tujuan bab:** mahasiswa memiliki fondasi konseptual tentang hierarki bahasa
pemrograman, mesin von Neumann, dan representasi data pada level mesin.

**Materi pokok:**
1. Hierarki bahasa pemrograman: mesin → assembly → tingkat tinggi.
2. Konsep dan definisi kunci: *instruction set architecture*, *opcode*,
   *operand*, *register*, *memory-mapped I/O*, *siklus instruksi*.
3. Teori mesin von Neumann dan model *stored-program*.
4. Representasi data: biner, heksadesimal, *two's complement*, BCD, ASCII.
5. Peta konsep (bagan struktur materi) seluruh buku.
6. Bahasa assembly vs *machine code*: mengapa assembly masih relevan.

**Aktivitas:** latihan konversi bilangan, pembacaan peta konsep, diskusi
mengapa debugging level rendah penting.

**Asesmen:** kuis konversi bilangan biner/heksadesimal/*two's complement*.

**Checklist:** mampu mengonversi bilangan, menjelaskan siklus instruksi,
membaca peta konsep buku.

---

### Bab III — Pengenalan Pemrograman Tingkat Rendah dan Lingkungan Kerja
**Folder:** `chapters/03/` · **Pertemuan:** 1 · **Sub-CPMK:** 1.1 · **CPMK01**

**Outcome khusus:** mahasiswa mampu menjelaskan perbedaan bahasa tingkat
tinggi dan tingkat rendah, peran bahasa assembly, serta menyiapkan lingkungan
kerja (Emu8086 / GUI TASM / DOSBox).

**Materi pokok (section):**
1. Perbandingan bahasa tingkat tinggi vs tingkat rendah (abstraksi,
   portabilitas, kendali perangkat keras, produktivitas).
2. Peran bahasa assembly: *one-to-one* dengan instruksi mesin; kapan dipakai.
3. Gambaran *toolchain*: editor → assembler (TASM/MASM) → linker (TLINK) →
   *executable*; alternatif Emu8086.
4. Instalasi & konfigurasi: Emu8086, GUI Turbo Assembler, DOSBox.
5. Struktur program assembly minimal: `SEGMENT`, `ASSUME`, `ORG 100h`,
   `INT 20h`/`INT 21h`.
6. Alur kerja pertama: menulis, merakit, menjalankan "Hello, World".

**Contoh:** program `hello.asm` mencetak teks dengan INT 21h fungsi 09h.
**Praktikum:** instalasi *tools* + menjalankan program pertama.
**Latihan:** 5 soal (konseptual + menjalankan program).
**Evaluasi:** kuis lisan/tertulis + bukti *screenshot* program berjalan.

**Checklist:** *tools* terpasang, program pertama berjalan, mampu menjelaskan
tahapan *toolchain*.

---

### Bab IV — Arsitektur Mikroprosesor 8086
**Folder:** `chapters/04/` · **Pertemuan:** 2 · **Sub-CPMK:** 1.1 · **CPMK01**

**Outcome khusus:** mahasiswa mampu menjelaskan arsitektur internal 8086
(BIU & EU), bus alamat/data/kontrol, dan siklus instruksi *fetch–decode–execute*.

**Materi pokok:**
1. Evolusi mikroprosesor: 8086 sebagai dasar arsitektur x86.
2. Diagram blok 8086: *Bus Interface Unit* (BIU) dan *Execution Unit* (EU).
3. Fungsi BIU: mengambil instruksi, *instruction queue* 6 byte, segmentasi.
4. Fungsi EU: mendekode & mengeksekusi, ALU, register.
5. *Pipelining* instruksi dan dampaknya pada kinerja.
6. Bus alamat (20-bit), bus data (16-bit), bus kontrol; *multiplexing* AD0–AD15.
7. Siklus instruksi: *fetch–decode–execute–store*; contoh penelusuran.
8. Pin dan sinyal penting (MN/MX, READY, RESET, ALE, M/IO).

**Contoh:** penelusuran siklus instruksi `MOV AX, 1234h` pada diagram.
**Praktikum:** menggambar alur *fetch–decode–execute*; identifikasi bagian
register memori saat satu langkah *single-step*.
**Latihan:** 6 soal analisis arsitektur.
**Evaluasi:** kuis diagram + tes tertulis.

**Checklist:** mampu menggambar blok BIU/EU, menjelaskan peran *instruction
queue*, menyebutkan lebar bus 8086.

---

### Bab V — Register 8086 dan Register Flag
**Folder:** `chapters/05/` · **Pertemuan:** 3 · **Sub-CPMK:** 1.2 · **CPMK01**

**Outcome khusus:** mahasiswa mampu mengidentifikasi dan menggunakan seluruh
register 8086 serta menjelaskan pengaruh *flag* terhadap eksekusi program.

**Materi pokok:**
1. Register umum: AX, BX, CX, DX dan akses *low/high byte* (AL, AH, …).
2. Peran khusus tiap register (akumulator, basis, *counter*, data).
3. Register segmen: CS, DS, SS, ES.
4. Register *pointer* & *index*: SP, BP, SI, DI.
5. Register *pointer* instruksi: IP.
6. Register *flag*: CF, PF, AF, ZF, SF, TF, IF, DF, OF; makna & kapan berubah.
7. Contoh pengaruh *flag* terhadap lompatan bersyarat.
8. Latihan membaca/mengubah register di Emu8086 dan DEBUG.

**Contoh:** tabel perubahan flag pada `ADD AL, BL` untuk beberapa nilai.
**Praktikum:** mengamati register & flag dengan Emu8086 *single-step*.
**Latihan:** 8 soal (identifikasi register, prediksi flag, analisis hasil).
**Evaluasi:** Tugas 1 (laporan observasi register/flag) + kuis.

**Checklist:** mampu memetakan register dan fungsinya, memprediksi nilai flag
setelah operasi sederhana.

---

### Bab VI — Segmentasi Memori dan Alamat Fisik
**Folder:** `chapters/06/` · **Pertemuan:** 4 · **Sub-CPMK:** 1.3 · **CPMK01**

**Outcome khusus:** mahasiswa mampu menghitung alamat fisik 20-bit dari
pasangan `segment:offset` dan menjelaskan skema pengalamatan memori 1 MB.

**Materi pokok:**
1. Mengapa segmentasi: keterbatasan register 16-bit vs bus alamat 20-bit.
2. Alamat logis (`segment:offset`) vs alamat fisik.
3. Rumus alamat fisik: `Physical = Segment × 10h + Offset`.
4. Paragraf 16-byte dan struktur alamat segmen.
5. *Overlapping segment*: banyak pasangan → satu alamat fisik.
6. Peta memori 1 MB (*conventional memory*, area video, ROM BIOS, *vector table*).
7. Contoh perhitungan alamat fisik (tabel kasus).
8. Verifikasi alamat dengan DEBUG/Emu8086.

**Contoh:** 6 perhitungan alamat fisik bertingkat, termasuk *carry/overflow*.
**Praktikum:** menghitung & memverifikasi alamat dengan debugger. **Kuis 1.**
**Latihan:** 10 soal perhitungan alamat.
**Evaluasi:** Kuis 1 + soal esai analisis peta memori.

**Checklist:** mampu menghitung alamat fisik, menjelaskan *overlapping*,
menyebutkan peta memori 1 MB.

---

### Bab VII — Format Instruksi Mesin
**Folder:** `chapters/07/` · **Pertemuan:** 5 · **Sub-CPMK:** 2.1 · **CPMK02**

**Outcome khusus:** mahasiswa mampu menjelaskan format instruksi mesin
(`opcode`, byte `ModR/M`, *displacement*, *immediate*) dan mengaitkannya
dengan operasi perangkat keras.

**Materi pokok:**
1. Instruksi mesin vs bahasa assembly (mnemonic ↔ *opcode*).
2. Format umum instruksi 8086: awalan, *opcode* 1–2 byte, `ModR/M`,
   *displacement*, *immediate*.
3. Struktur byte `ModR/M`: field `mod`, `reg/opcode`, `r/m`.
4. Peran *displacement* dan *immediate*.
5. Pengaruh format instruksi terhadap ukuran & kecepatan eksekusi.
6. Contoh *encoding* manual beberapa instruksi (`MOV`, `ADD`, `INT`).
7. *Disassembler*: membaca kembali instruksi mesin menjadi mnemonic.
8. Tabel ringkas *opcode* instruksi umum 8086.

**Contoh:** *encoding* `MOV AX, BX`, `MOV AL, 5`, `ADD AX, [SI+4]` dengan tabel.
**Praktikum:** analisis *opcode* manual dan dengan *disassembler*. **Tugas 2.**
**Latihan:** 6 soal *encoding/decoding*.
**Evaluasi:** Tugas 2 (lembar kerja *opcode*) + kuis.

**Checklist:** mampu menguraikan byte `ModR/M`, meng-*encode* instruksi
sederhana, membaca hasil *disassembly*.

---

### Bab VIII — Mode Pengalamatan
**Folder:** `chapters/08/` · **Pertemuan:** 6 · **Sub-CPMK:** 2.2 · **CPMK02**

**Outcome khusus:** mahasiswa mampu menganalisis dan menerapkan seluruh mode
pengalamatan 8086 serta menentukan segmen *default* yang digunakan.

**Materi pokok:**
1. Konsep *operand* dan mode pengalamatan.
2. Mode *immediate*, *register*, *direct*.
3. Mode *register indirect* (`[BX]`, `[SI]`, `[DI]`, `[BP]`).
4. Mode *indexed* (`[SI+disp]`), *base-relative* (`[BX+disp]`),
   *based-indexed* (`[BX+SI+disp]`).
5. Kombinasi `base`+`index` yang legal dan ilegal.
6. Segmen *default* per mode & *segment override prefix* (`CS:`, `DS:`, `SS:`, `ES:`).
7. Perbandingan efisiensi antar mode pengalamatan.
8. Studi kasus: mengakses *array* dan *record* dengan mode berbeda.

**Contoh:** satu operasi yang sama ditulis dalam 6 mode pengalamatan.
**Praktikum:** *tracing* mode pengalamatan dengan debugger. **Kuis 2.**
**Latihan:** 8 soal penentuan mode & alamat efektif.
**Evaluasi:** Kuis 2 + tugas analisis segmen *default*.

**Checklist:** mengenali mode dari penulisan operand, menghitung alamat
efektif, menentukan segmen *default*.

---

### Bab IX — Direktif Assembler dan Alur Translasi Program
**Folder:** `chapters/09/` · **Pertemuan:** 7 · **Sub-CPMK:** 2.3 · **CPMK02**

**Outcome khusus:** mahasiswa mampu menggunakan direktif assembler dan
menjelaskan alur translasi *source* → *object* → *executable*.

**Materi pokok:**
1. Perbedaan instruksi mesin vs direktif assembler.
2. Direktif data: `DB`, `DW`, `DD`, `DT`; *string literal*.
3. Direktif simbol/konstanta: `EQU`, `=`; perbedaan keduanya.
4. Direktif lokasi & struktur: `ORG`, `SEGMENT`/`ENDS`, `ASSUME`, `END`.
5. Model memori (`.MODEL SMALL`) dan `PROC`/`ENDP`.
6. Peran assembler (TASM/MASM) dan linker (TLINK): tabel, *relocation*,
   resolusi simbol eksternal.
7. Alur lengkap: `.asm` → `.obj` → `.exe` → dijalankan; peran `.map` & `.lst`.
8. Kesalahan umum saat perakitan dan cara membacanya.

**Contoh:** program data terdefinisi (`DB`/`DW`/`EQU`) + cara perakitan.
**Praktikum:** menyusun & merakit program pertama dengan TASM. **Tugas 3.**
**Latihan:** 6 soal direktif + 1 tugas perakitan bertahap.
**Evaluasi:** Tugas 3 (portofolio perakitan `.asm`→`.exe`).

**Checklist:** membedakan direktif & instruksi, merakit program menjadi `.exe`,
membaca pesan kesalahan assembler.

---

### Bab X — Instruksi Transfer Data dan Aritmatika
**Folder:** `chapters/10/` · **Pertemuan:** 9 · **Sub-CPMK:** 3.1 · **CPMK03**

**Outcome khusus:** mahasiswa mampu menulis program assembly menggunakan
instruksi transfer data dan aritmatika, serta menganalisis pengaruhnya pada *flag*.

**Materi pokok:**
1. Instruksi transfer: `MOV`, `XCHG`, `LEA`, `LDS`/`LES`, `PUSH`/`POP`.
2. Aturan legalitas `MOV` (ukuran operand, memori–memori, segmen).
3. Instruksi aritmatika: `ADD`, `ADC`, `SUB`, `SBB`, `INC`, `DEC`, `NEG`, `CMP`.
4. Perkalian & pembagian: `MUL`, `IMUL`, `DIV`, `IDIV` dan aturan operandnya.
5. Operasi *signed* vs *unsigned* dan pengaruhnya pada *flag*.
6. Aritmatika bertingkat: penjumlahan bilangan besar dengan `ADC`.
7. Konversi & pencetakan bilangan (*binary-to-decimal*).
8. Studi kasus: kalkulator empat operasi sederhana.

**Contoh:** program kalkulator penjumlahan/pengurangan + program `MUL`/`DIV`.
**Praktikum:** membangun kalkulator sederhana (input–proses–output). **Tugas 4.**
**Latihan:** 8 soal (prediksi hasil, tulis program).
**Evaluasi:** Tugas 4 + tes *coding* terbatas.

**Checklist:** menulis program aritmatika benar, menjelaskan efek *flag*,
menangani *overflow*.

---

### Bab XI — Operasi Logika, Pergeseran, dan Rotasi
**Folder:** `chapters/11/` · **Pertemuan:** 10 · **Sub-CPMK:** 3.2 · **CPMK03**

**Outcome khusus:** mahasiswa mampu menerapkan operasi *bitwise* dan
pergeseran/rotasi untuk manipulasi bit.

**Materi pokok:**
1. Operasi logika: `AND`, `OR`, `XOR`, `NOT`, `TEST`.
2. Penerapan: *masking*, *setting*, *clearing*, *toggling* bit.
3. `TEST` vs `CMP`: perbedaan & pemakaian.
4. Pergeseran logis: `SHL`, `SHR`; pergeseran aritmetika: `SAL`, `SAR`.
5. Rotasi: `ROL`, `ROR`, `RCL`, `RCR` (termasuk *carry*).
6. Perkalian/pembagian cepat dengan pergeseran.
7. Studi kasus: cek paritas, *packing/unpacking* BCD, pencetakan angka dengan `SHR`.
8. Pengantar manipulasi bit untuk enkripsi XOR sederhana.

**Contoh:** program cek paritas, program XOR cipher, tabel hasil pergeseran.
**Praktikum:** manipulasi bit (paritas, *packing*). **Kuis 3.**
**Latihan:** 8 soal logika bitwise + 2 tugas program.
**Evaluasi:** Kuis 3 + tugas program manipulasi bit.

**Checklist:** menghitung hasil operasi bitwise, memilih instruksi geser yang
tepat, menerapkan *masking*.

---

### Bab XII — Struktur Kontrol dan Percabangan
**Folder:** `chapters/12/` · **Pertemuan:** 11 · **Sub-CPMK:** 3.3 · **CPMK03**

**Outcome khusus:** mahasiswa mampu mengimplementasikan struktur kontrol
(`CMP`, `TEST`, `Jcc`, `LOOP`, `CALL`/`RET`) dalam program assembly.

**Materi pokok:**
1. Konsep *flag* sebagai dasar pengambilan keputusan.
2. `CMP` dan `TEST` sebagai penyiap *flag*.
3. Lompatan tak bersyarat `JMP` (*short*, *near*, *far*).
4. Lompatan bersyarat `Jcc`: `JE/JZ`, `JNE/JNZ`, `JG`, `JGE`, `JL`, `JLE`,
   `JA`, `JAE`, `JB`, `JBE`, `JC`, `JS`, `JO`, `JP` ; *signed* vs *unsigned*.
5. Perulangan: `LOOP`, `LOOPE`/`LOOPZ`, `LOOPNE`/`LOOPNZ`; `LOOP` vs `DEC`+`JNZ`.
6. Pola penerjemahan `if`, `if–else`, `while`, `for`, `switch` ke assembly.
7. Studi kasus: pencarian nilai maksimum, pengurutan gelembung, pencarian biner.

**Contoh:** penerjemahan pseudocode `if–else` dan loop ke assembly.
**Praktikum:** pencarian maksimum & pengurutan sederhana. **Tugas 5.**
**Latihan:** 8 soal (penerjemahan pseudocode, prediksi alur).
**Evaluasi:** Tugas 5 + uji *tracing* alur program.

**Checklist:** memilih `Jcc` yang benar untuk *signed*/*unsigned*,
menerjemahkan pseudocode, menghindari *infinite loop*.

---

### Bab XIII — Prosedur dan Manajemen Stack
**Folder:** `chapters/13/` · **Pertemuan:** 12 · **Sub-CPMK:** 3.4 · **CPMK03**

**Outcome khusus:** mahasiswa mampu mengembangkan prosedur/subrutin dengan
*parameter passing* dan mengelola *stack frame*.

**Materi pokok:**
1. Mengapa prosedur: modularitas, *reusability*, abstraksi.
2. Instruksi `CALL` dan `RET`; isi stack saat pemanggilan.
3. Operasi stack: `PUSH`, `POP`, register `SP`/`BP`, arah tumbuh stack.
4. *Stack frame* standar: *prologue* (`PUSH BP; MOV BP, SP`), *epilogue*.
5. Konvensi pemanggilan: `cdecl`-style, *caller/callee saved*.
6. *Parameter passing*: lewat register, lewat stack, lewat *global variable*.
7. Nilai balik prosedur (`RET n`, register `AX`).
8. Rekursi pada assembly (faktorial, Fibonacci) dan kedalaman stack.
9. Kesalahan umum: stack tidak seimbang, `RET` salah alamat.

**Contoh:** prosedur `HitungLuas` dengan parameter stack + rekursi faktorial.
**Praktikum:** prosedur berparameter dan bernilai balik. **Tugas 6.**
**Latihan:** 6 soal (analisis stack, tulis prosedur).
**Evaluasi:** Tugas 6 + asesmen kinerja prosedur.

**Checklist:** menggambar isi stack saat `CALL`, menulis prosedur berparameter,
menjelaskan *prologue*/*epilogue*.

---

### Bab XIV — Interupsi BIOS/DOS dan Operasi I/O
**Folder:** `chapters/14/` · **Pertemuan:** 13 · **Sub-CPMK:** 2.4 · **CPMK02**

**Outcome khusus:** mahasiswa mampu menjelaskan mekanisme interupsi dan
menggunakannya untuk operasi I/O.

**Materi pokok:**
1. Konsep interupsi: *hardware*, *software* (`INT n`), *exception*.
2. *Interrupt vector table* (0000h–03FFh) dan alamat vektor.
3. Mekanisme `INT` dan `IRET`; penyimpanan `FLAGS`, `CS`, `IP`.
4. Interupsi BIOS: `INT 10h` (video: set mode, kursor, tulis karakter),
   `INT 16h` (keyboard), `INT 17h` (printer).
5. Interupsi DOS `INT 21h`: fungsi 01h/02h/09h/0Ah/4Ch (input, output, keluar).
6. `INT 20h` vs `INT 21h` fungsi 4Ch.
7. Membuat *interrupt handler* sendiri (*hook* vektor) dan risikonya.
8. Studi kasus: program input nama & salam (string I/O).

**Contoh:** program input–output nama pengguna dengan INT 21h, tampilan berwarna INT 10h.
**Praktikum:** program input–output dengan INT 21h. **Tugas 7.**
**Latihan:** 6 soal (peta fungsi interupsi, tulis program).
**Evaluasi:** Tugas 7 + asesmen kinerja program I/O.

**Checklist:** menyebutkan fungsi interupsi utama, menulis program I/O,
menjelaskan *interrupt vector table*.

---

### Bab XV — Debugging pada Level Instruksi
**Folder:** `chapters/15/` · **Pertemuan:** 14 · **Sub-CPMK:** 4.1, 4.2 · **CPMK04**

**Outcome khusus:** mahasiswa mampu melakukan penelusuran program pada level
instruksi dan menganalisis memori/stack untuk menemukan kesalahan.

**Materi pokok:**
1. Jenis kesalahan: *syntax*, *runtime*, *logic*, kesalahan segmentasi, *overflow*.
2. Alat debugging: DEBUG (MS-DEBUG/DOSBox), *integrated debugger* Emu8086/GUI TASM.
3. Perintah DEBUG: `R`, `U`, `T`, `P`, `G`, `D`, `E`, `A`, `N`, `L`, `W`.
4. *Single-step* (`T`) vs *proceed* (`P`) dan perbedaan saat `CALL`/`INT`.
5. *Breakpoint* dan eksekusi sampai alamat (`G alamat`).
6. Memantau register & *flag* per langkah; tabel *trace*.
7. *Dump* memori & stack; membaca *stack frame*.
8. Metodologi debugging sistematis (reproduksi → isolasi → hipotesis → uji).
9. Studi kasus: menemukan *infinite loop*, *off-by-one*, dan *stack imbalance*.

**Contoh:** sesi *trace* tabel per langkah untuk program penjumlahan yang salah.
**Praktikum:** debugging terpandu (3 kasus bug). **Asesmen kinerja.**
**Latihan:** 3 kasus bug untuk di-debug + laporan.
**Evaluasi:** Asesmen kinerja debugging (rubrik) + laporan *trace*.

**Checklist:** mampu memakai perintah DEBUG, membaca *dump*, menemukan
kesalahan logika dalam batas waktu.

---

### Bab XVI — Analisis Kode Mesin, Disassembly, dan Optimasi
**Folder:** `chapters/16/` · **Pertemuan:** 15 · **Sub-CPMK:** 4.3 · **CPMK04**

**Outcome khusus:** mahasiswa mampu menganalisis kode mesin hasil
*disassembly* dan menerapkan strategi optimasi level instruksi.

**Materi pokok:**
1. Membaca hasil *disassembly* (DEBUG `U`, objdump).
2. Mengenali pola kompilasi/assembly umum: pembandingan, loop, prosedur.
3. Metrik optimasi: jumlah instruksi, siklus, ukuran kode, akses memori.
4. Teknik optimasi: pilih register vs memori, hindari instruksi mahal
   (`MUL`/`DIV` → geser), gunakan `LOOP`/`LEA`, kurangi *jump*, *unroll loop*.
5. *Strength reduction* & optimasi aritmatika.
6. Optimasi ukuran vs optimasi kecepatan.
7. *Benchmark* sederhana dan pengukuran waktu (penghitung iterasi/`INT 15h`).
8. Etika & batas optimasi: keterbacaan vs kinerja.

**Contoh:** dua versi program (naif vs teroptimasi) + tabel perbandingan.
**Praktikum:** menganalisis & mengoptimasi program. **Studi kasus + presentasi
proyek akhir.**
**Latihan:** 4 soal analisis *disassembly* + 1 tugas optimasi.
**Evaluasi:** presentasi proyek akhir (rubrik) + laporan optimasi.

**Checklist:** membaca *disassembly*, mengidentifikasi inefisiensi, membuktikan
perbaikan kinerja dengan data.

---

### Bab XVII — Evaluasi, Refleksi, dan Integrasi Kompetensi
**Folder:** `chapters/17/` · **Pertemuan:** — · **Sub-CPMK:** Semua

**Tujuan bab:** mahasiswa mengukur pencapaian kompetensi secara menyeluruh
dan merencanakan tindak lanjut.

**Materi pokok:**
1. Rekapitulasi CPL–CPMK–Sub-CPMK dan peta ketercapaian.
2. Kumpulan asesmen akhir: kisi-kisi UTS (CPMK01–02), kisi-kisi UAS
   (CPMK03–04), dan proyek akhir.
3. Rubrik penilaian komprehensif berbasis OBE (UTS, UAS, proyek, praktikum,
   tugas, kuis) dengan bobot sesuai RPS.
4. Pedoman proyek akhir: 4 pilihan proyek (kalkulator, pengolah string,
   manipulasi bit/enkripsi, *utility* memori–register) + rubrik.
5. Tinjauan pencapaian kompetensi: *self-assessment* dan *peer assessment*.
6. Portfolio & jurnal refleksi: format dan rubrik.
7. Rekomendasi tindak lanjut: topik lanjutan (x86 32/64-bit, NASM, sistem
   operasi, arsitektur komputer, *reverse engineering* etis).
8. Penutup buku.

**Aktivitas:** pengerjaan proyek akhir, presentasi, *self-assessment*,
penyusunan rencana belajar lanjutan.

**Asesmen:** UAS, proyek akhir, portofolio, rubrik refleksi.

**Checklist:** seluruh CPMK terbukti tercapai, portofolio lengkap, rencana
tindak lanjut tersusun.

---

## 5. Lampiran yang Direncanakan

| Lampiran | Isi | File |
|---|---|---|
| A | Rubrik penilaian lengkap terhubung ke CPMK (tugas, praktikum, kuis, UTS, UAS, proyek akhir) | `appendices/appendix-a.tex` |
| B | Contoh tugas, portofolio, dan rubrik refleksi | `appendices/appendix-b.tex` |
| C | Glosarium istilah (Indonesia–Inggris) | `appendices/appendix-c.tex` |
| D | Referensi tambahan & sumber belajar eksternal | `appendices/appendix-d.tex` |

---

## 6. Tahapan Penulisan (Bertahap per Bab)

| Tahap | Lingkup | Keluaran | Status |
|:---:|---|---|:---:|
| 0 | Rencana penulisan (dokumen ini) | `RENCANA_PENULISAN_BUKU_AJAR.md` | ✅ |
| 1 | Infrastruktur: `main.tex`, `preamble.tex`, `metadata.tex`, `config/`, `references.bib`, `frontmatter/`, `scripts/` | kerangka buku dapat dikompilasi | ✅ |
| 2 | Bab I & Bab II (bab pengikat) | `chapters/01`, `chapters/02` | ✅ |
| 3 | Bab III–VI (CPMK01: Sub-CPMK 1.1–1.3) | `chapters/03`–`06` | ✅ |
| 4 | Bab VII–IX (CPMK02: Sub-CPMK 2.1–2.3) | `chapters/07`–`09` | ✅ |
| 5 | Bab X–XIII (CPMK03: Sub-CPMK 3.1–3.4) | `chapters/10`–`13` | ✅ |
| 6 | Bab XIV (CPMK02: Sub-CPMK 2.4) | `chapters/14` | ✅ |
| 7 | Bab XV–XVI (CPMK04: Sub-CPMK 4.1–4.3) | `chapters/15`–`16` | ✅ |
| 8 | Bab XVII + Lampiran A–D | `chapters/17`, `appendices/` | ✅ |
| 9 | Kompilasi buku utuh & pemeriksaan menyeluruh | `output/main.pdf` | ✅ |

---

## 7. Kriteria Selesai (Definition of Done)

Sebuah bab dinyatakan selesai apabila:

- [x] `chapter.tex` ada dan memakai `\documentclass[../../main.tex]{subfiles}`.
- [x] Memuat Sub-CPMK, materi, contoh, praktikum, latihan, rangkuman,
      evaluasi, checklist kompetensi, dan refleksi.
- [x] Memuat minimal satu tabel dan/atau gambar/diagram yang relevan.
- [x] Memuat minimal satu *listing* kode assembly yang benar dan dapat dirakit.
- [x] Seluruh label unik dan seluruh `\ref`/`\cite` valid.
- [x] Tidak ada `\usepackage` di luar `config/`.
- [x] `latexmk -pdf chapters/NN/chapter.tex` berhasil tanpa error.
- [x] Muncul dengan benar pada kompilasi `main.tex`.

---

## 8. Konvensi Kode Assembly

- Prosesor: **Intel 8086**, mode real, 16-bit.
- Sintaks: **MASM/TASM** (kompatibel Emu8086).
- Program `.COM` sederhana memakai `ORG 100h`; program `.EXE` memakai
  `SEGMENT`/`ASSUME` dan `.MODEL`.
- Keluar program: `INT 20h` (`.COM`) atau `MOV AX, 4C00h / INT 21h`.
- Cetak string: `INT 21h` fungsi `09h` (string berakhir `$`).
- Cetak karakter: `INT 21h` fungsi `02h`.
- Semua berkas contoh: `code/asm/*.asm`.
- Komentar berbahasa Indonesia, satu baris `;` per instruksi penting.

---

## 9. Risiko dan Mitigasi

| Risiko | Mitigasi |
|---|---|
| Inkosistensi istilah antar-bab | glosarium Lampiran C + review silang |
| Perbedaan sintaks TASM vs MASM vs Emu8086 | standar MASM/TASM + catatan perbedaan di praktikum |
| Bab gagal dikompilasi mandiri | setiap bab diuji `latexmk -pdf chapter.tex` |
| Tautan referensi mati | referensi dari RPS (open access) + arsip alternatif |
| Ketergantungan package MiKTeX | package umum & auto-install MiKTeX |

---

*Dokumen ini menjadi acuan tunggal penulisan bab dan diperbarui setiap tahap
penulisan selesai.*
