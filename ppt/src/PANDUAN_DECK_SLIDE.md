# PANDUAN PENULISAN DECK SLIDE

Acuan teknis dan gaya untuk **setiap** berkas `ppt/src/minggu-NN.tex`.
Bacalah seluruhnya sebelum menulis satu deck. Rencana lengkap ada di
`ppt/RENCANA_PRESENTASI_PPT.md`; deck acuan yang sudah jadi dan **wajib
ditiru strukturnya** adalah `ppt/src/minggu-01.tex` (Bab III, 29 frame).

---

## 1. Berkas yang boleh dan tidak boleh disentuh

**Boleh dibuat:** `ppt/src/minggu-NN.tex` (berkas baru untuk minggu Anda).

**Jangan diubah:** `ppt/src/preamble-ppt.tex`, `ppt/src/listing-ppt.tex`,
`ppt/src/minggu-01.tex`, `ppt/compile_ppt.bat`, dan deck minggu lain.
Tema, makro, dan gaya kode sudah lengkap di dua berkas pertama — pakai saja,
jangan didefinisikan ulang.

---

## 2. Kerangka berkas

```latex
% =========================================================
% ppt/src/minggu-NN.tex
% Slide pertemuan NN
% Bab <ROMawi> — <Judul Bab>
%
% Sub-CPMK <x.y> | CPMK<xx> | CPL<xx>
% =========================================================

\documentclass[aspectratio=169,11pt]{beamer}
\input{preamble-ppt}

\renewcommand{\PertemuanTeks}{Pertemuan NN}

\begin{document}
... frame demi frame ...
\end{document}
```

- Nomor minggu **dua digit**: `minggu-02`, `minggu-09`, `minggu-15`.
- `\JudulDeck{<judul bab>}{Pertemuan NN}` untuk frame pertama.
- `\PemisahBagian{<judul seksi>}` untuk frame pemisah tiap `\section`.
- Jangan menyetel `\title`/`\author`; identitas sudah diurus preamble.

---

## 3. Urutan frame baku

Ikuti persis urutan ini (lihat `minggu-01.tex` sebagai contoh nyata):

| # | Frame | Sumber isi |
|---|---|---|
| 1 | `\JudulDeck{...}{Pertemuan NN}` | — |
| 2 | **Capaian dan Tujuan Pembelajaran** — blok Sub-CPMK, CPMK/CPL pendukung, lalu daftar tujuan | `chapter.tex`: `subcpmkbox` + `tujuanbox` |
| 3 | **Peta Materi** — tiga seksi + blok "praktik pada pertemuan ini" | `chapter.tex`: `materibox` |
| 4 | `\PemisahBagian{seksi 1}` | `\section{...}` |
| 5… | Frame inti seksi 1 (1 frame per subseksi; boleh gabung 2 subseksi ringan) | `section-01.tex` |
| … | **Rangkuman Bagian 1** — 4 butir kunci penutup seksi | ringkasan `section-01.tex` |
| … | `\PemisahBagian{seksi 2}` + frame inti | `section-02.tex` |
| … | **Rangkuman Bagian 2** — 4–5 butir kunci penutup seksi | ringkasan `section-02.tex` |
| … | `\PemisahBagian{seksi 3}` + frame inti | `section-03.tex` |
| … | **Rangkuman Bagian 3** — 4–5 butir kunci penutup seksi | ringkasan `section-03.tex` |
| … | **Satu frame per contoh program** (wajib semua, lengkap dengan kode) | `contoh.tex` |
| … | **Praktikum** — judul, alat & bahan, langkah kerja, yang dikumpulkan | `praktikum.tex` |
| … | **Latihan** — 4–5 soal terpilih | `latihan.tex` |
| … | **Rangkuman** — 5–6 butir kunci | `rangkuman.tex` |
| … | **Cek Pemahaman** — 2–3 soal pilihan ganda cepat | `evaluasi.tex` |
| … | **Penutup** — tugas sebelum pertemuan berikutnya + bacaan lanjutan | — |

Semua bagian **wajib ada**. Urutan tidak boleh diubah.

**Tentang "Rangkuman Bagian".** Frame ini ada **tepat tiga buah** per deck —
satu di akhir tiap seksi, diletakkan sebelum frame pemisah seksi berikutnya
(dan sebelum blok contoh program untuk seksi terakhir). Isinya ringkas saja:
4–5 butir kunci seksi itu, **bukan** pengulangan kalimat frame-frame sebelumnya.
Frame **Rangkuman** di akhir deck tetap ada dan berbeda: yang itu merangkum
seluruh bab. Lihat `ppt/src/minggu-03.tex` sebagai contoh nyata (cari
`Rangkuman Bagian 1`).

---

## 4. Aturan isi

1. **Setia pada buku.** Materi, istilah, angka, dan contoh harus berasal dari
   bab yang bersangkutan. Jangan menambah materi yang tidak ada di buku.
2. **Kepadatan.** Maksimal **6 butir** atau **±40 kata** per frame. Bila lebih
   padat, gunakan `\small` atau `\footnotesize` dan pecah menjadi dua frame.
3. **Kode program.** Maksimal **±15 baris** per frame. Ambil dari
   `buku_ajar/code/asm/*.asm` bila ada berkasnya, atau dari `contoh.tex`.
   Persingkat komentar yang panjang agar tidak meluber.
4. **Diagram.** Gambar ulang dengan `tikz`, disederhanakan. Lebar maksimum
   **11.6 cm**. Warna wajib dari palet OBE.
5. **Tabel.** Pakai `booktabs` di dalam `center`, kolom `p{}` boleh.
   **Lebar teks slide adalah 14,0 cm** (398,34 pt; kertas 16,0 cm dikurangi
   margin), **bukan 14,8 cm**. Untuk tabel dengan `n` kolom `p{}` patuhi:

   > jumlah lebar kolom + 0,42 cm × (n − 1) ≤ 13,8 cm

   Angka 0,42 cm adalah dua kali `\tabcolsep` (6 pt) yang ditambahkan di setiap
   batas kolom. Tabel yang tampak "pas" menurut penjumlahan lebar kolom saja
   sering tetap menghasilkan `Overfull \hbox` — hitung dengan rumus di atas.
6. **Bahasa.** Indonesia; istilah teknis tetap Inggris dan dibungkus `\eng{}`.
7. **Ketertelusuran.** Pada frame yang isinya spesifik, tambahkan
   `\Sumber{Bab <Romawi>, <bagian>}` di akhir frame bila tidak mengganggu.

---

## 5. Makro yang tersedia (jangan didefinisikan ulang)

Notasi: `\code{}` `\asm{}` `\reg{}` `\flag{}` `\dir{}` `\file{}` `\eng{}`
`\hex{}` `\bin{}` `\dec{}` `\term{}` `\important{}` `\catatan{}`
`\CPL{}` `\CPMK{}` `\SubCPMK{}` `\checkbox{}` `\checked{}` `\crossed{}`

Tata letak: `\JudulDeck{}{}`, `\PemisahBagian{}`, `\Sumber{}`

Identitas: `\NamaMK` `\KodeMK` `\Prodi` `\Fakultas` `\PerguruanTinggi`
`\DosenPengampu` `\SemesterTeks`

Lingkungan kode: `kodeasm` (assembly, bernomor baris) dan `keluaran`
(keluaran program / sesi debugger, tanpa nomor).

**Catatan:** `\note` **tidak boleh** dipakai (milik beamer); pakai `\catatan`.

---

## 6. Aturan teknis wajib — melanggar berarti deck gagal dirakit

1. **Frame yang memuat `kodeasm` atau `keluaran` WAJIB memakai opsi
   `[fragile]`.** Tanpa itu kompilasi gagal.
2. **Jangan pernah memakai `postbreak` pada listings.** Di beamer,
   `breaklines=true` + `postbreak=...` menghasilkan puluhan galat
   `Missing number, treated as zero <to be read again> \kern`. Opsi ini sudah
   sengaja dibuang dari `listing-ppt.tex`.
3. **Jangan memakai `\rowcolor`/`\cellcolor`** (paket `colortbl` rusak di mesin
   ini). Tabel `p{}` + `booktabs` aman.
4. **Jangan memakai `tcolorbox`.** Kotak memakai `block`, `alertblock`, atau
   `exampleblock` beamer.
5. Jangan menaruh `lstlisting` di dalam argumen perintah lain; taruh di tingkat
   teratas frame (boleh di dalam `column`/`columns`).

---

## 7. Kompilasi dan verifikasi (wajib)

```bash
cd ppt/src
pdflatex --enable-installer -interaction=nonstopmode -output-directory=.. minggu-NN.tex
pdflatex --enable-installer -interaction=nonstopmode -output-directory=.. minggu-NN.tex
```

Syarat lulus, semuanya harus terpenuhi:

- `pdflatex` keluar dengan kode **0**.
- `ppt/minggu-NN.pdf` terbentuk; jumlah halaman = jumlah frame, dalam rentang
  target rencana §6 (±3).

Verifikasi log **wajib memakai perintah ini, salin apa adanya**:

```bash
grep -c  '^!'        ../minggu-NN.log   # baris galat  -> harus 0
grep -cF 'Overfull'  ../minggu-NN.log   # luber        -> harus 0
grep -c  'undefined' ../minggu-NN.log   # referensi    -> harus 0
```

> **Jebakan yang sudah dua kali terjadi — jangan diulang.** Pola
> `grep 'Overfull \vbox'` **tidak berfungsi**: di dalam shell, `\v` tidak
> menjadi backslash-literal, sehingga grep melaporkan `0` padahal ada
> `Overfull \vbox` sungguhan. Ini sudah menyesatkan deck minggu 1 dan minggu 5
> dan sempat membuat pelanggaran nyata lolos. **Selalu pakai
> `grep -F 'Overfull'`**, yang mencari teks apa adanya tanpa regex.

Catatan: `Overfull \vbox` berarti isi frame meluber ke bawah — sering
memotong baris terakhir kode atau menabrak kaki slide, dan **terlihat**.
`Overfull \hbox` pada tabel yang di-`center` biasanya hanya melebar ke margin
sehingga tidak terlihat, tetapi tetap harus 0.

### 7.1 Pemeriksaan kaki slide — WAJIB, karena log saja tidak cukup

Di beamer, sebuah frame dapat meluber ke bawah **tanpa memicu
`Overfull \vbox`**: glue vertikal menyerap kelebihannya. Jadi log yang bersih
**tidak** menjamin tidak ada teks yang tertimpa kaki slide. Ini bukan teori —
sudah terjadi pada deck minggu 6, 7, dan 13, di mana baris "Dikumpulkan"
tertimpa pita footer tanpa satu pun peringatan di log.

Jalankan pemeriksa berbasis piksel setelah kompilasi bersih:

```bash
cd ppt
python scripts/check_luber.py minggu-NN.pdf
```

Script mengukur **celah putih** antara konten terakhir dan pita footer pada
tiap halaman. Pada proyek ini celah sehat terukur **6–13 piksel** (100 dpi),
sedangkan frame yang meluber memberi **0**. Ambangnya 4.

- Halaman berlabel `CURIGA` **wajib diperiksa mata** dengan `pdftoppm` +
  tool Read, lalu diperbaiki (biasanya: padatkan daftar, kecilkan font, atau
  pendekkan teks).
- Halaman yang tidak punya pita footer — jadi tidak diperiksa — adalah frame
  `[plain]`: 1 judul + 3 pemisah bagian = **4 halaman per deck**. Itu normal.

Skrip menerima pola glob, jadi `python scripts/check_luber.py "minggu-*.pdf"`
memeriksa seluruh deck sekaligus. `compile_ppt.bat` juga menjalankannya
otomatis setelah kompilasi.

Bila `pdflatex` gagal karena masalah cache font / instalasi paket MiKTeX,
**ulangi sekali** — kegagalan seperti itu biasanya sementara, terutama bila
beberapa deck dikompilasi bersamaan.

---

## 8. Pemeriksaan visual (wajib)

Jangan hanya percaya log. Setelah kompilasi bersih:

```bash
cd ppt
mkdir -p _prev-NN
pdftoppm -png -r 90 -f <hal> -l <hal> minggu-NN.pdf _prev-NN/hal-<hal>
```

lalu buka PNG-nya dengan tool Read dan periksa halaman: frame judul, satu frame
diagram, satu frame berkode, dan satu frame terpadat. Pastikan tidak ada teks
terpotong tepi, label diagram tumpang-tindih, atau kotak kode meluber.

**Hapus** folder `_prev-NN` setelah selesai — jangan tinggalkan berkas
sementara di repositori.

---

## 9. Yang dilaporkan setelah selesai

1. Path berkas yang dibuat dan jumlah frame (`pdfinfo minggu-NN.pdf`).
2. Jumlah galat dan jumlah `Overfull \vbox` (harus 0).
3. Hasil pemeriksaan visual: halaman mana yang diperiksa dan apa temuannya.
4. Bagian mana dari bab yang **tidak** masuk slide, bila ada, beserta alasannya.
5. Kesulitan atau hal yang perlu keputusan pemilik proyek.

Jangan melakukan `git commit` atau `git push`.
