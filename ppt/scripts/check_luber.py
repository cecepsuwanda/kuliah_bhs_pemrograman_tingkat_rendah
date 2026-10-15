#!/usr/bin/env python3
"""
check_luber.py — deteksi isi frame yang menembus/menyentuh kaki slide.

Latar belakang
--------------
Di beamer, sebuah frame dapat meluber ke bawah TANPA memicu peringatan
"Overfull \\vbox": glue vertikal (\\vss) menyerap kelebihannya. Karena itu
log yang bersih TIDAK menjamin tidak ada teks terpotong. Dua kasus nyata
sudah terjadi (baris "Dikumpulkan" tertimpa footer pada deck minggu 6 dan
7) dan tidak terdeteksi lewat log.

Cara kerja
----------
Footer tema slide ini adalah pita abu-abu rata (obeGray #4A4A4A) setinggi
~15 piksel pada 100 dpi, terletak di dasar halaman. Diukur dari render
nyata: pita menempati baris 339-353, dan di halaman yang sehat masih ada
~12 baris PUTIH kosong antara konten terakhir dan pita itu.

Dua sinyal diperiksa:

1. `gap` — jumlah baris putih kosong tepat di atas pita. Bila konten
   meluber atau menyentuh kaki slide, celah ini hilang (`gap` ~0-3).
   Ini sinyal utama, karena konten yang tertimpa pita tetap "terlihat"
   sebagai hilangnya celah.
2. `gelap` — jumlah piksel gelap DI DALAM pita. Pita sehat hanya berisi
   abu-abu dan tulisan putih, jadi piksel gelap berarti glif materi
   tercetak di atas pita. Sinyal pendukung.

Pemakaian
---------
    python check_luber.py <berkas.pdf> [<berkas.pdf> ...]

Halaman yang dilaporkan **perlu diperiksa mata** — sinyal ini menandai
"konten menyentuh kaki slide", yang mencakup kasus terpotong sungguhan
maupun frame yang sekadar sangat padat.

Butuh `pdftoppm` (poppler) dan PIL.
"""

import os
import subprocess
import sys
import tempfile

from PIL import Image

BAR = (74, 74, 74)      # obeGray, warna pita footer
BAR_TOL = 14
KIRI = 10               # kolom kiri yang dipakai mengenali pita (margin rata)
PUTIH_MIN = 245         # ambang "baris putih kosong"
DARK_MAX = 55           # ambang piksel gelap di dalam pita
DARK_MIN = 25
GAP_MIN = 4             # gap di bawah ini -> dicurigai
DPI = 100


def _baris_pita(px, y, w):
    """True bila baris y termasuk pita footer.

    Diperiksa pada KOLOM KIRI saja (x = 0..KIRI-1). Margin kiri pita selalu
    abu-abu rata karena teks footer baru dimulai setelah `leftskip` 0,4 cm
    (~16 px pada 100 dpi). Memeriksa seluruh lebar TIDAK bisa dipakai: baris
    yang memuat tulisan putih footer hanya ~64% abu-abu, sehingga penelusuran
    pita berhenti terlalu cepat dan `gap` menjadi 0 palsu di hampir semua
    halaman.
    """
    ujung = min(KIRI, w)
    for x in range(ujung):
        r, g, b = px[x, y][:3]
        if not (abs(r - BAR[0]) <= BAR_TOL and abs(g - BAR[1]) <= BAR_TOL
                and abs(b - BAR[2]) <= BAR_TOL):
            return False
    return True


def _baris_putih(px, y, w):
    for x in range(0, w, 4):
        r, g, b = px[x, y][:3]
        if not (r >= PUTIH_MIN and g >= PUTIH_MIN and b >= PUTIH_MIN):
            return False
    return True


def analisis(img):
    """Kembalikan (baris_atas_pita, gap_putih, piksel_gelap) atau None."""
    w, h = img.size
    px = img.load()

    # Cari baris pita terbawah, lompati margin putih di dasar halaman.
    batas = int(h * 0.20)
    bawah = None
    for y in range(h - 1, h - batas - 1, -1):
        if _baris_pita(px, y, w):
            bawah = y
            break
    if bawah is None:
        return None

    # Telusuri ke atas selama masih pita.
    atas = bawah
    while atas - 1 >= 0 and _baris_pita(px, atas - 1, w):
        atas -= 1

    # Celah putih tepat di atas pita.
    gap = 0
    y = atas - 1
    while y >= 0 and _baris_putih(px, y, w):
        gap += 1
        y -= 1

    # Piksel gelap di dalam pita.
    gelap = 0
    for yy in range(atas, h):
        for x in range(w):
            r, g, b = px[x, yy][:3]
            if r < DARK_MAX and g < DARK_MAX and b < DARK_MAX:
                gelap += 1

    return atas, gap, gelap


def periksa(pdf):
    nama = os.path.basename(pdf)
    with tempfile.TemporaryDirectory() as tmp:
        subprocess.run(
            ["pdftoppm", "-png", "-r", str(DPI), pdf,
             os.path.join(tmp, "hal")],
            check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
        )
        berkas = sorted(f for f in os.listdir(tmp) if f.endswith(".png"))
        hasil = []
        for i, f in enumerate(berkas, start=1):
            img = Image.open(os.path.join(tmp, f)).convert("RGB")
            h = analisis(img)
            if h is None:
                hasil.append((i, None, None, None))
            else:
                hasil.append((i, h[0], h[1], h[2]))

    curiga = [(i, g, d) for (i, _, g, d) in hasil
              if g is not None and (g < GAP_MIN or d >= DARK_MIN)]
    tanpapita = [i for (i, a, _, _) in hasil if a is None]
    celah = [g for (_, _, g, _) in hasil if g is not None]

    print(f"\n=== {nama}  ({len(berkas)} halaman, pita footer terdeteksi di "
          f"{len(berkas) - len(tanpapita)} halaman) ===")
    if celah:
        print(f"  celah putih di atas pita: min={min(celah)}  "
              f"maks={max(celah)}  (ambang {GAP_MIN})")
    if tanpapita:
        print(f"  pita tidak terdeteksi di halaman: {tanpapita}")
    if curiga:
        for hal, gap, gelap in curiga:
            print(f"  CURIGA  halaman {hal:<3}  gap_putih={gap}  "
                  f"piksel_gelap_di_pita={gelap}")
    else:
        print("  bersih: semua halaman punya celah putih di atas kaki slide")
    return len(curiga), len(tanpapita)


def main():
    import glob

    if len(sys.argv) < 2:
        print(__doc__)
        return 1

    berkas = []
    for pola in sys.argv[1:]:
        cocok = sorted(glob.glob(pola))
        if cocok:
            berkas.extend(cocok)
        else:
            print(f"lewat: {pola} tidak cocok dengan berkas apa pun")

    total = 0
    for pdf in berkas:
        c, _ = periksa(pdf)
        total += c
    print(f"\nRINGKASAN: {len(berkas)} berkas diperiksa, "
          f"{total} halaman dicurigai menyentuh kaki slide.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
