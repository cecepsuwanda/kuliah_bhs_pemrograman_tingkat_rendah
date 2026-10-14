# Buku Ajar — Bahasa Pemrograman Tingkat Rendah

Buku ajar berbasis *Outcome-Based Education* (OBE) untuk mata kuliah
**Bahasa Pemrograman Tingkat Rendah** (MWCA010, 3 SKS), Program Studi
Teknik Informatika, Fakultas Teknologi Informasi, Universitas Bale Bandung.

Buku dibangun dengan LaTeX menggunakan arsitektur modular: setiap bab
merupakan modul mandiri yang dapat dikompilasi sendiri maupun sebagai
bagian dari buku utuh. Arsitektur lengkapnya dijelaskan pada
`../Arsitektur_Buku_Ajar.md`.

---

## Ringkasan Isi

| Bagian | Keterangan |
|---|---|
| Bab I | Pendahuluan dan Orientasi Buku |
| Bab II | Landasan Teori dan Konsep Dasar |
| Bab III--IX | Unit materi CPMK01--CPMK02 (Sub-CPMK 1.1--2.3) |
| Bab X--XIII | Unit materi CPMK03 (Sub-CPMK 3.1--3.4) |
| Bab XIV | Interupsi BIOS/DOS (Sub-CPMK 2.4) |
| Bab XV--XVI | Unit materi CPMK04 (Sub-CPMK 4.1--4.3) |
| Bab XVII | Evaluasi, Refleksi, dan Integrasi Kompetensi |
| Lampiran A--D | Rubrik, contoh tugas, glosarium, referensi tambahan |

Dokumen perencanaan:

- `RENCANA_PENULISAN_BUKU_AJAR.md` — rencana penulisan per bab,
  pemetaan silabus ke bab, dan kriteria selesai.
- `PANDUAN_PENULISAN_BAB.md` — acuan teknis dan gaya penulisan bab.

---

## Struktur Direktori

```text
buku_ajar/
├── main.tex              # master document
├── preamble.tex          # penghubung konfigurasi + resolusi path
├── metadata.tex          # metadata buku
├── references.bib        # bibliografi bersama
│
├── config/               # KONFIGURASI (tanpa materi)
│   ├── packages.tex      commands.tex     environments.tex
│   ├── styles.tex        listings.tex
│
├── frontmatter/          # cover, copyright, preface,
│                         # acknowledgements, learning-outcomes
├── chapters/NN/          # 17 bab; setiap bab 9 berkas + figures/
├── appendices/           # appendix-a.tex .. appendix-d.tex
├── code/asm/             # 30 berkas contoh program assembly
├── assets/               # images, diagrams, logos
├── build/                # keluaran build (opsional)
└── scripts/              # build-all.bat, build-chapter.bat, clean.bat
```

Kerangka setiap bab:

```text
chapter.tex   section-01..03.tex   contoh.tex   praktikum.tex
latihan.tex   rangkuman.tex        evaluasi.tex figures/
```

---

## Kebutuhan

- Distribusi LaTeX (diuji dengan MiKTeX 24.1 pada Windows).
- Package utama: `babel` (indonesian), `geometry`, `tcolorbox`,
  `listings`, `booktabs`, `longtable`, `enumitem`, `tikz`, `subfiles`,
  `natbib`, `hyperref`, `lmodern`.
- **Tidak** memakai `colortbl` (lihat catatan teknis di bawah).

---

## Cara Mengompilasi

### Buku utuh

Dari direktori ini:

```bat
scripts\build-all.bat
```

atau dari akar repositori:

```bat
compile_main.bat
```

Hasil: `..\output\main.pdf`

Kompilasi manual (empat tahap, urutannya penting):

```bat
pdflatex -interaction=nonstopmode -output-directory=..\output main.tex
bibtex ..\output\main
pdflatex -interaction=nonstopmode -output-directory=..\output main.tex
pdflatex -interaction=nonstopmode -output-directory=..\output main.tex
```

### Satu bab

```bat
scripts\build-chapter.bat 05
scripts\build-chapter.bat all
```

atau dari akar repositori:

```bat
compile_bab.bat
```

Komplikasi mandiri **harus dijalankan dari dalam direktori bab**,
karena `preamble.tex` menghitung path relatif dari sana:

```bat
cd chapters\05
latexmk -pdf chapter.tex
```

Hasil: `chapter.pdf` (satu bab).

---

## Catatan Teknis

Beberapa keputusan teknis pada proyek ini bukan pilihan gaya,
melainkan penyesuaian terhadap perilaku package dan lingkungan
LaTeX yang dipakai. Semuanya didokumentasikan di tempatnya:

1. **Bab dimuat dengan `\subfile`, bukan `\include`** — lihat
   komentar di `main.tex`. Package `subfiles` menetapkan direktori
   berkas aktif; `\include` tidak, sehingga `\subfile{section-01}`
   di dalam bab akan gagal ditemukan.

2. **`\input` di dalam bab mengikuti direktori bab** — lihat
   komentar `\input@path` di `preamble.tex`.

3. **`colortbl` tidak dimuat** — pada instalasi MiKTeX tertentu,
   `colortbl` versi baru memerlukan makro `\insert@pcolumn` yang
   belum tersedia pada `array.sty` bawaan, sehingga seluruh tabel
   gagal dirakit. Lihat komentar di `config/packages.tex`.
   Jangan memakai `\rowcolor` atau `\cellcolor`.

4. **Penambal `\enit@after`** — `enumitem` menetapkan makro itu
   secara lokal, sedangkan `tcolorbox` `breakable` dapat menyusun
   dua potongan kotak dalam grup berbeda. Lihat komentar di
   `config/environments.tex`.

5. **Sitasi memakai gaya numerik** `[1]`, `[2]`, sesuai penomoran
   Daftar Referensi RPS. Gaya author-year tidak dipakai karena
   sebagian sumber resmi tidak mencantumkan tahun terbit.

---

## Sumber Isi

Isi buku diturunkan dari Rencana Pembelajaran Semester (RPS) berbasis
OBE pada `../rps_silabus/silabus.tex`, dengan pemetaan
CPL $\rightarrow$ CPMK $\rightarrow$ Sub-CPMK $\rightarrow$ bab.
Prosesor acuan: Intel 8086 (mode real, 16-bit), assembler MASM/TASM,
lingkungan Emu8086 / GUI Turbo Assembler / DOSBox.
