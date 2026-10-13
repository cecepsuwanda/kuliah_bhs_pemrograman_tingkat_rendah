# PANDUAN PENULISAN BAB
## Buku Ajar Pemrograman Bahasa Tingkat Rendah

Dokumen ini adalah acuan teknis dan gaya penulisan untuk **setiap bab**.
Bacalah seluruhnya sebelum menulis. Acuan tingkat proyek ada pada
`../Arsitektur_Buku_Ajar.md`; acuan isi ada pada
`RENCANA_PENULISAN_BUKU_AJAR.md`.

**Bab model (wajib ditiru):** `chapters/03/` — bab ini sudah
dikompilasi bersih dan menjadi contoh baku struktur, gaya, dan
kepadatan isi.

---

## 1. Aturan Teknis yang Tidak Boleh Dilanggar

1. **Tidak ada `\usepackage`** di dalam `chapter.tex`, section, maupun
   file `contoh/praktikum/latihan/rangkuman/evaluasi`. Semua package
   sudah dimuat di `config/packages.tex`.
2. Hanya `chapter.tex` yang memakai
   `\documentclass[../../main.tex]{subfiles}` dan
   `\begin{document} ... \end{document}`.
3. Section memakai `\subfile{section-NN}` dari `chapter.tex`.
   Potongan kecil memakai `\input{...}`.
4. **Setiap bab harus dapat dikompilasi sendiri** tanpa error:
   ```
   cd chapters/NN
   pdflatex -interaction=nonstopmode --enable-installer chapter.tex
   ```
   Perintah di atas **harus** dijalankan dari dalam direktori bab.
5. **Dilarang memakai `\rowcolor`, `\cellcolor`, atau `colortbl`.**
   Package `colortbl` sengaja tidak dimuat karena tidak kompatibel
   dengan instalasi MiKTeX di mesin ini. Pewarnaan baris tabel tidak
   diperlukan.
6. Gunakan `booktabs` (`\toprule`, `\midrule`, `\bottomrule`,
   `\addlinespace`) untuk semua tabel. Hindari `\hline` kecuali pada
   tabel sederhana.
7. Label harus unik dan mengikuti awalan: `chap:`, `sec:`, `fig:`,
   `tab:`, `eq:`, `lst:`. Contoh: `\label{lst:program-loop}`.
8. Jangan menulis nomor gambar/tabel/bab secara manual. Selalu pakai
   `\ref{}`: `` Gambar~\ref{fig:...} ``, `` Tabel~\ref{tab:...} ``,
   `` Kode~\ref{lst:...} ``, `` Bab~\ref{chap:...} ``.
9. Diagram digambar dengan **TikZ langsung di dalam file** (tidak ada
   berkas gambar eksternal). Gunakan warna palet buku.
10. Kode assembly panjang (> 25 baris) disimpan sebagai berkas di
    `code/asm/` dan dimasukkan dengan
    `\lstinputlisting[language=MASM, caption={...}, label={lst:...}]{\CodeDir/namafile.asm}`.
    Kode pendek ditulis langsung dengan `\begin{lstlisting}`.
11. **Jangan menulis berkas memakai `printf`/heredoc di shell** —
    escape backslash akan rusak dan menghasilkan berkas korup.
    Gunakan alat tulis berkas yang aman.

---

## 2. Palet Warna Buku

| Nama | Kegunaan |
|---|---|
| `obeBlue`, `obeBlueLight` | judul, konsep inti, ringkasan instruksi |
| `obeTeal`, `obeTealLight` | praktikum, aktivitas, alur proses |
| `obeGreen`, `obeGreenLight` | checklist, rangkuman, refleksi |
| `obeAmber`, `obeAmberLight` | asesmen, peringatan ringan |
| `obeMaroon`, `obeMaroonLight` | studi kasus, kesalahan umum |
| `obeGray`, `obeGrayLight` | catatan, keluaran program |

---

## 3. Environment dan Command yang Tersedia

### Kotak OBE (dari `config/environments.tex`)

```latex
\begin{subcpmkbox} ... \end{subcpmkbox}          % Outcome khusus bab
\begin{tujuanbox} ... \end{tujuanbox}            % Tujuan pembelajaran
\begin{materibox} ... \end{materibox}            % Materi pokok
\begin{aktivitasbox} ... \end{aktivitasbox}      % Aktivitas
\begin{praktikumbox} ... \end{praktikumbox}      % Praktikum
\begin{asesmenbox} ... \end{asesmenbox}          % Asesmen
\begin{checklistbox} ... \end{checklistbox}      % Checklist kompetensi
\begin{refleksibox} ... \end{refleksibox}        % Refleksi
\begin{studikasusbox} ... \end{studikasusbox}    % Studi kasus
\begin{peringatanbox} ... \end{peringatanbox}    % Kesalahan umum
\begin{infobox} ... \end{infobox}                % Catatan
\begin{instruksibox} ... \end{instruksibox}      % Ringkasan instruksi
```

Semua kotak bersifat `breakable` (boleh terpotong antar halaman) dan
judulnya sudah otomatis — **jangan** menambahkan `\section*` untuk
judul kotak.

### Environment teorema

```latex
\begin{definisi} ... \end{definisi}
\begin{contoh} ... \end{contoh}
\begin{prosedur} ... \end{prosedur}
\begin{teorema} ... \end{teorema}
\begin{lemma} ... \end{lemma}
\begin{catatan} ... \end{catatan}
```

### Environment listing

```latex
\begin{program}[caption={...}, label={lst:...}]   % kode assembly bernomor
\begin{session}[caption={...}, label={lst:...}]   % keluaran program / sesi debugger
\begin{pseudocode}[caption={...}, label={lst:...}]% pseudocode
```

### Command

| Command | Hasil | Contoh |
|---|---|---|
| `\code{x}` | kode umum | `\code{INT 21h}` |
| `\asm{x}` | mnemonic instruksi | `\asm{MOV}` |
| `\lstasm\|MOV AX, 5\|` | instruksi inline | pakai delimiter `\|` |
| `\reg{AX}` | register | `\reg{AX}` |
| `\flag{ZF}` | flag | `\flag{ZF}` |
| `\dir{DB}` | direktif assembler | `\dir{DB}` |
| `\file{x.asm}` | nama berkas | `\file{program.asm}` |
| `\eng{x}` | istilah asing | `\eng{pipeline}` |
| `\hex{1234}` | `1234h` | `\hex{1234}` |
| `\bin{1010}` | `1010b` | `\bin{1010}` |
| `\term{x}` | istilah yang didefinisikan | `\term{opcode}` |
| `\important{x}` | "Penting: x" | |
| `\note{x}` | "Catatan: x" | |
| `\checkbox` `\checked` | kotak centang | |

---

## 4. Struktur File per Bab

```
chapters/NN/
├── chapter.tex      # subfiles + \chapter + kotak OBE + \subfile/\input
├── section-01.tex   # \section{...}  materi utama
├── section-02.tex   # \section{...}  materi utama
├── section-03.tex   # \section{...}  materi utama
├── contoh.tex       # \section{Contoh Program}
├── praktikum.tex    # \section{Praktikum}
├── latihan.tex      # \section{Latihan}
├── rangkuman.tex    # \section{Rangkuman}
├── evaluasi.tex     # \section{Evaluasi}
└── figures/         # (kosong; diagram memakai TikZ)
```

Kerangka `chapter.tex`:

```latex
\documentclass[../../main.tex]{subfiles}

\begin{document}

\chapter{Judul Bab}
\label{chap:KEY}

\begin{subcpmkbox}
\SubCPMK{N.N} --- <rumusan indikator>.
\vspace{0.4em}
\textbf{CPMK yang didukung:} \CPMK{NN} \quad\textbullet\quad
\textbf{CPL yang didukung:} \CPL{NN}
\end{subcpmkbox}

\begin{tujuanbox}
Setelah mempelajari bab ini, mahasiswa mampu:
\begin{enumerate}
    \item ...
\end{enumerate}
\end{tujuanbox}

\begin{materibox}
\begin{enumerate}
    \item ...
\end{enumerate}
\end{materibox}

\subfile{section-01}
\subfile{section-02}
\subfile{section-03}

\input{contoh}
\input{praktikum}
\input{latihan}
\input{rangkuman}
\input{evaluasi}

\end{document}
```

---

## 5. Kepadatan Isi yang Diharapkan

Setiap bab inti (Bab III--XVI) dianggap selesai bila memenuhi:

| Unsur | Minimal |
|---|---|
| Panjang naskah bab | 2.500--4.000 kata |
| Section materi | 3 section |
| Diagram TikZ | 1 gambar ber-`\label{fig:...}` |
| Tabel | 2 tabel ber-`\label{tab:...}` |
| Contoh program utuh | 2 contoh (boleh 1 berkas di `code/asm/` + 1 inline) |
| Berkas `code/asm/` | 1--2 berkas baru yang benar dan dapat dirakit |
| Soal latihan | 8 soal (campuran konseptual, analisis, penulisan program) |
| Soal evaluasi | 5 pilihan ganda + 3--4 uraian + kisi-kisi |
| Kotak wajib | `subcpmkbox`, `tujuanbox`, `materibox`, `praktikumbox`, `asesmenbox`, `checklistbox`, `refleksibox`, `infobox` |

---

## 6. Konvensi Kode Assembly

- Prosesor **Intel 8086**, mode real, 16-bit.
- Sintaks **MASM/TASM** (kompatibel Emu8086).
- Program utuh: `.MODEL SMALL` + `.STACK 100h` + `.DATA` + `.CODE` +
  `END START`.
- Inisialisasi segmen:
  `MOV AX, @DATA` / `MOV DS, AX`.
- Keluar: `MOV AH, 4Ch` / `MOV AL, 00h` / `INT 21h`.
- Cetak string: `MOV AH, 09h` / `LEA DX, pesan` / `INT 21h`; string
  berakhir `'$'`.
- Cetak karakter: `MOV AH, 02h` / `MOV DL, 'A'` / `INT 21h`.
- Komentar berbahasa Indonesia, tanda `;`, satu komentar per
  instruksi penting.
- Berkas `code/asm/` memakai nama huruf kecil, misalnya
  `aritmatika.asm`, `loop-maksimum.asm`.

---

## 7. Daftar Label Bab (untuk referensi silang)

| Bab | Folder | Label |
|:---:|:---:|---|
| I | 01 | `chap:pendahuluan` |
| II | 02 | `chap:landasan-teori` |
| III | 03 | `chap:pengenalan` |
| IV | 04 | `chap:arsitektur-8086` |
| V | 05 | `chap:register` |
| VI | 06 | `chap:segmentasi` |
| VII | 07 | `chap:format-instruksi` |
| VIII | 08 | `chap:mode-pengalamatan` |
| IX | 09 | `chap:translasi` |
| X | 10 | `chap:aritmatika` |
| XI | 11 | `chap:logika` |
| XII | 12 | `chap:kontrol` |
| XIII | 13 | `chap:prosedur` |
| XIV | 14 | `chap:interupsi` |
| XV | 15 | `chap:debugging` |
| XVI | 16 | `chap:disassembly` |
| XVII | 17 | `chap:evaluasi-akhir` |

---

## 8. Kunci Sitasi yang Tersedia (`references.bib`)

`intel1979`, `intel2024`, `bartlett2004`, `bartlett2023`, `hyde2010`,
`wikibooksx86`, `wikibooksdisasm`, `brown2000`, `bodur`, `ebrahim2018`,
`irvine1999`, `emu8086help`, `kader2014`, `courses2103`, `carleton2011`,
`evans2020`, `uva2024`, `nasm2024`, `guitasm`, `emu8086site`, `dosbox`,
`irvine2011`, `stallings2016`, `tanenbaum2013`, `brey2009`,
`abdelghany2020`, `gunawan2023`.

Gunakan `\cite{kunci}`. Setiap bab memuat 3--5 sitasi, termasuk pada
`rangkuman.tex` di dalam `infobox` "Rujukan bab".

---

## 9. Gaya Bahasa

- Bahasa Indonesia baku, kalimat aktif, sasaran pembaca mahasiswa
  semester 2.
- Istilah teknis asing dimiringkan dengan `\eng{}` pada kemunculan
  pertama, lalu boleh tegak pada kemunculan berikutnya.
- Setiap konsep abstrak harus segera diikuti contoh konkret.
- Hindari kalimat lebih dari tiga baris.
- Jangan memakai kata "kami"; gunakan "penulis" atau bentuk pasif.
- Setiap angka heksadesimal ditulis dengan `\hex{}` atau akhiran `h`.
- Setiap kesalahan umum dibahas di `peringatanbox`, bukan disisipkan
  dalam paragraf.

---

## 10. Daftar Periksa Sebelum Menyatakan Bab Selesai

- [ ] `chapter.tex` memuat kotak `subcpmkbox`, `tujuanbox`, `materibox`.
- [ ] Tiga section materi lengkap dengan contoh dan penjelasan.
- [ ] Minimal satu TikZ ber-label dan dua tabel ber-label.
- [ ] Minimal dua contoh program; berkas `code/asm/` dibuat bila perlu.
- [ ] `praktikum.tex` memuat tujuan, alat, langkah kerja, hasil, dan
      `asesmenbox` berisi tabel rubrik.
- [ ] `latihan.tex` memuat 8 soal dan `refleksibox`.
- [ ] `rangkuman.tex` memuat ringkasan, `checklistbox`, dan `infobox`
      rujukan bab berisi `\cite{}`.
- [ ] `evaluasi.tex` memuat pilihan ganda, uraian, tabel kisi-kisi, dan
      `checklistbox` pencapaian kompetensi.
- [ ] Kompilasi mandiri dari direktori bab berakhir **tanpa error**.
- [ ] Tidak ada `\usepackage`, `\rowcolor`, atau `\cellcolor`.
- [ ] Seluruh label unik dan seluruh `\ref` menunjuk label yang ada.
