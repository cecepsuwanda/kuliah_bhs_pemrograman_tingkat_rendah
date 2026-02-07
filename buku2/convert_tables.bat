@echo off
echo ================================================
echo  CONVERT TABLES TO LONGTABLE SCRIPT
echo  Bahasa Pemrograman Tingkat Rendah
echo ================================================
echo.
echo Script ini akan membantu mengkonversi tabel biasa
echo menjadi longtable yang dapat dibagi halaman.
echo.
echo PERINGATAN: Backup file Anda terlebih dahulu!
echo.
pause

REM Buat backup folder
if not exist "backup" mkdir backup
if not exist "backup\chapters" mkdir "backup\chapters"

echo Membuat backup...
xcopy "chapters\*.tex" "backup\chapters\" /Y >nul

echo.
echo ================================================
echo  PILIHAN KONVERSI
echo ================================================
echo.
echo [1] Konversi tabel di Chapter 2 (Register tables)
echo [2] Konversi tabel di Chapter 6 (Interrupt tables)
echo [3] Konversi semua tabel yang panjang
echo [4] Lihat template longtable
echo [0] Keluar
echo.
set /p CHOICE="Pilihan (0-4): "

if "%CHOICE%"=="0" goto END
if "%CHOICE%"=="1" goto CONVERT_CH2
if "%CHOICE%"=="2" goto CONVERT_CH6
if "%CHOICE%"=="3" goto CONVERT_ALL
if "%CHOICE%"=="4" goto SHOW_TEMPLATE

echo Pilihan tidak valid!
pause
goto END

:CONVERT_CH2
echo.
echo Mengkonversi tabel di Chapter 2...
echo (Implementasi manual diperlukan)
echo.
echo Tabel yang perlu dikonversi:
echo - Detail Register Umum Intel 8086
echo - Detail Register Indeks SI dan DI
echo - Detail Register Pointer SP dan BP
echo - Detail Register Segmen Intel 8086
echo - Detail Register FLAGS Intel 8086
echo.
pause
goto END

:CONVERT_CH6
echo.
echo Mengkonversi tabel di Chapter 6...
echo (Implementasi manual diperlukan)
echo.
echo Tabel yang perlu dikonversi:
echo - Contoh Interrupt Vector Table
echo - Mode Video BIOS yang Umum Digunakan
echo - Kode Warna untuk Text Mode
echo - Scan Codes untuk Special Keys
echo - Kode Error DOS yang Umum
echo.
pause
goto END

:CONVERT_ALL
echo.
echo Mengkonversi semua tabel yang panjang...
echo (Implementasi manual diperlukan)
echo.
echo Proses ini memerlukan:
echo 1. Identifikasi tabel yang panjang
echo 2. Konversi manual ke longtable
echo 3. Testing hasil konversi
echo.
pause
goto END

:SHOW_TEMPLATE
echo.
echo Membuka template longtable...
if exist "template_longtable.tex" (
    echo Template tersedia di: template_longtable.tex
    echo.
    echo Isi template:
    echo - Contoh konversi dari table ke longtable
    echo - Cara penggunaan longtable
    echo - Konfigurasi header berulang
    echo.
) else (
    echo Template tidak ditemukan!
)
pause
goto END

:END
echo.
echo Terima kasih!
echo.
echo CATATAN:
echo - File backup tersimpan di folder backup\
echo - Gunakan template_longtable.tex sebagai referensi
echo - Konversi manual diperlukan untuk setiap tabel
echo.
pause
