@echo off
setlocal enabledelayedexpansion

REM ================================================
REM Compile Script - Buku Assembly 8086
REM Bahasa Pemrograman Tingkat Rendah
REM ================================================
REM
REM Cara penggunaan:
REM   compile.bat               -> Menu interaktif
REM   compile.bat book          -> Compile buku lengkap (dengan bibliografi)
REM   compile.bat [nomor]       -> Compile satu bab (1-15, tanpa bibliografi)
REM   compile.bat [start]-[end] -> Compile range bab (misal: 3-7, tanpa bibliografi)
REM   compile.bat all           -> Compile semua bab individual (tanpa bibliografi)
REM   compile.bat quick book    -> Quick compile buku
REM   compile.bat quick [nomor] -> Quick compile bab
REM
REM CATATAN: Kompilasi bab individual akan memproses sitasi dengan benar,
REM          tetapi tidak menampilkan daftar pustaka di akhir bab.
REM          Untuk buku lengkap dengan daftar pustaka, gunakan 'compile.bat book'.
REM
REM ================================================

REM Setup folders
if not exist "output" mkdir output
if not exist "output\pdf" mkdir "output\pdf"
if not exist "output\log" mkdir "output\log"
if not exist "output\chapters" mkdir "output\chapters"

REM Jika tidak ada parameter, tampilkan menu
if "%1"=="" goto MENU

REM Parse parameter
set PARAM1=%1
set PARAM2=%2

REM Check untuk quick mode
if /i "%PARAM1%"=="quick" (
    if "%PARAM2%"=="" (
        echo ERROR: Parameter untuk quick compile tidak diberikan!
        echo Contoh: compile.bat quick book
        echo          compile.bat quick 3
        pause
        exit /b 1
    )
    goto QUICK_MODE
)

REM Check untuk compile all
if /i "%PARAM1%"=="all" goto COMPILE_ALL

REM Check untuk compile book
if /i "%PARAM1%"=="book" goto COMPILE_BOOK

REM Check untuk range (mengandung -)
echo %PARAM1% | findstr /C:"-" >nul
if not errorlevel 1 goto COMPILE_RANGE

REM Jika angka, compile single chapter
set /a TEST=%PARAM1% 2>nul
if %TEST% GEQ 1 if %TEST% LEQ 17 (
    set BAB_NUM=%PARAM1%
    goto COMPILE_CHAPTER
)

REM Parameter tidak valid
echo ERROR: Parameter tidak valid!
echo.
echo Cara penggunaan:
echo   compile.bat               -> Menu interaktif
echo   compile.bat book          -> Compile buku lengkap (dengan bibliografi)
echo   compile.bat [nomor]       -> Compile satu bab (1-17, tanpa bibliografi)
echo   compile.bat [start]-[end] -> Compile range bab (tanpa bibliografi)
echo   compile.bat all           -> Compile semua bab individual (tanpa bibliografi)
echo   compile.bat quick book    -> Quick compile buku
echo   compile.bat quick [nomor] -> Quick compile bab
echo.
echo CATATAN: Sitasi akan diproses, tapi daftar pustaka hanya di buku lengkap
pause
exit /b 1

REM ================================================
REM MENU INTERAKTIF
REM ================================================
:MENU
cls
echo ================================================
echo  MENU KOMPILASI BUKU ASSEMBLY 8086
echo  Bahasa Pemrograman Tingkat Rendah
echo ================================================
echo.
echo  [1] Compile buku lengkap
echo  [2] Compile satu bab
echo  [3] Compile beberapa bab (range)
echo  [4] Compile semua bab individual
echo  [5] Quick compile (tanpa bibliography)
echo  [0] Keluar
echo.
echo ================================================
set /p CHOICE="Pilihan (0-5): "

if "%CHOICE%"=="0" goto END
if "%CHOICE%"=="1" goto COMPILE_BOOK
if "%CHOICE%"=="2" goto MENU_SINGLE
if "%CHOICE%"=="3" goto MENU_RANGE
if "%CHOICE%"=="4" goto COMPILE_ALL
if "%CHOICE%"=="5" goto MENU_QUICK

echo Pilihan tidak valid!
pause
goto MENU

:MENU_SINGLE
cls
echo ================================================
echo Compile Satu Bab
echo ================================================
echo CATATAN: Sitasi \cite{} akan diproses dengan benar.
echo          Daftar pustaka lengkap hanya di compile buku lengkap.
echo ================================================
echo.
echo Daftar Bab:
echo  1  - Pengenalan Bahasa Rakitan dan Sistem Bilangan
echo  2  - Arsitektur Mikroprosesor Intel 8086
echo  3  - Instalasi GUI Turbo Assembler dan Struktur Program
echo  4  - Tipe Data dalam Bahasa Assembly
echo  5  - Instruksi Dasar: Perpindahan Data dan Aritmatika
echo  6  - Interrupt dan Sistem BIOS/DOS
echo  7  - Instruksi Logika dan Operasi Bit
echo  8  - Percabangan dan Perulangan
echo  9  - I/O Teks Dasar (Mode Teks BIOS)
echo  10 - Input dari Keyboard dan Penanganan Buffer
echo  11 - Instruksi Stack dan Subrutin
echo  12 - Array dan String
echo  13 - Pemrograman Modular dan Makro
echo  14 - Pemrograman Grafik Dasar
echo  15 - Pemrosesan File Dasar
echo  16 - Pemrosesan File Lanjutan
echo  17 - Program Residen (TSR)
echo.
set /p BAB_NUM="Masukkan nomor bab (1-17): "

if "%BAB_NUM%"=="" (
    echo ERROR: Nomor bab tidak boleh kosong!
    pause
    goto MENU
)
if %BAB_NUM% LSS 1 (
    echo ERROR: Nomor bab harus antara 1-17!
    pause
    goto MENU
)
if %BAB_NUM% GTR 17 (
    echo ERROR: Nomor bab harus antara 1-17!
    pause
    goto MENU
)

goto COMPILE_CHAPTER

:MENU_RANGE
cls
echo ================================================
echo Compile Beberapa Bab Berurutan
echo ================================================
echo CATATAN: Sitasi \cite{} akan diproses dengan benar.
echo ================================================
echo.
set /p START_BAB="Nomor bab awal (1-17): "
set /p END_BAB="Nomor bab akhir (1-17): "

if "%START_BAB%"=="" goto MENU
if "%END_BAB%"=="" goto MENU
if %START_BAB% LSS 1 goto MENU
if %END_BAB% GTR 17 goto MENU
if %START_BAB% GTR %END_BAB% (
    echo ERROR: Bab awal harus lebih kecil dari bab akhir!
    pause
    goto MENU
)

echo.
echo Akan compile bab %START_BAB% sampai %END_BAB%...
pause

for /L %%i in (%START_BAB%,1,%END_BAB%) do (
    set BAB_NUM=%%i
    call :DO_COMPILE_CHAPTER
)

echo.
echo ================================================
echo Selesai compile bab %START_BAB% sampai %END_BAB%!
echo ================================================
echo Lokasi: output\chapters\
echo.
echo CATATAN: Sitasi sudah diproses, tapi daftar pustaka lengkap
echo          hanya tersedia di buku lengkap (opsi [1]).
echo.
pause
goto MENU

:MENU_QUICK
cls
echo ================================================
echo Quick Compile (Preview Mode)
echo ================================================
echo.
echo  [1] Quick compile buku lengkap
echo  [2] Quick compile satu bab
echo  [0] Kembali
echo.
set /p QCHOICE="Pilihan: "

if "%QCHOICE%"=="0" goto MENU
if "%QCHOICE%"=="1" (
    set PARAM2=book
    goto QUICK_MODE
)
if "%QCHOICE%"=="2" (
    set /p BAB_NUM="Nomor bab (1-17): "
    if "%BAB_NUM%"=="" goto MENU
    if %BAB_NUM% LSS 1 goto MENU
    if %BAB_NUM% GTR 17 goto MENU
    set PARAM2=%BAB_NUM%
    goto QUICK_MODE
)
goto MENU

REM ================================================
REM COMPILE BUKU LENGKAP
REM ================================================
:COMPILE_BOOK
cls
echo ================================================
echo Compiling Buku Lengkap...
echo ================================================
echo.

pdflatex -interaction=nonstopmode -output-directory=output main
biber output\main
pdflatex -interaction=nonstopmode -output-directory=output main
pdflatex -interaction=nonstopmode -output-directory=output main

if exist "output\main.pdf" (
    move /Y "output\main.pdf" "output\pdf\main.pdf" >nul
    echo.
    echo ================================================
    echo Compilation completed!
    echo Output: output\pdf\main.pdf
    echo ================================================
) else (
    echo ERROR: Compilation gagal!
)

if exist "output\main.log" move /Y "output\main.log" "output\log\main.log" >nul
if exist "output\main.blg" move /Y "output\main.blg" "output\log\main.blg" >nul

if "%1"=="" (
    echo.
    pause
    goto MENU
) else (
    pause
    exit /b 0
)

REM ================================================
REM COMPILE SATU BAB
REM ================================================
:COMPILE_CHAPTER
call :DO_COMPILE_CHAPTER
if "%1"=="" (
    pause
    goto MENU
) else (
    pause
    exit /b 0
)

:DO_COMPILE_CHAPTER
REM Format chapter filename
if %BAB_NUM% LSS 10 (
    set CHAPTER_FILE=ch0%BAB_NUM%
) else (
    set CHAPTER_FILE=ch%BAB_NUM%
)

if not exist "chapters\%CHAPTER_FILE%.tex" (
    echo ERROR: File chapters\%CHAPTER_FILE%.tex tidak ditemukan!
    exit /b 1
)

echo.
echo ================================================
echo Compiling Bab %BAB_NUM% (%CHAPTER_FILE%.tex)...
echo ================================================
echo Note: Sitasi akan berfungsi, tetapi daftar pustaka tidak ditampilkan.
echo       Untuk daftar pustaka lengkap, compile buku lengkap.
echo ================================================

cd chapters
pdflatex -interaction=nonstopmode -output-directory=..\output %CHAPTER_FILE%.tex >nul
cd ..
biber output\%CHAPTER_FILE% >nul 2>&1
cd chapters
pdflatex -interaction=nonstopmode -output-directory=..\output %CHAPTER_FILE%.tex >nul
pdflatex -interaction=nonstopmode -output-directory=..\output %CHAPTER_FILE%.tex >nul
cd ..

if exist "output\%CHAPTER_FILE%.pdf" (
    move /Y "output\%CHAPTER_FILE%.pdf" "output\chapters\%CHAPTER_FILE%.pdf" >nul
    echo Output: output\chapters\%CHAPTER_FILE%.pdf
) else (
    echo ERROR: Compilation gagal!
)

if exist "output\%CHAPTER_FILE%.log" move /Y "output\%CHAPTER_FILE%.log" "output\log\%CHAPTER_FILE%.log" >nul
if exist "output\%CHAPTER_FILE%.blg" move /Y "output\%CHAPTER_FILE%.blg" "output\log\%CHAPTER_FILE%.blg" >nul
REM Keep .bbl file for citations support
if exist "output\%CHAPTER_FILE%.aux" del /Q "output\%CHAPTER_FILE%.aux" >nul 2>&1
if exist "output\%CHAPTER_FILE%.out" del /Q "output\%CHAPTER_FILE%.out" >nul 2>&1

exit /b 0

REM ================================================
REM COMPILE RANGE BAB
REM ================================================
:COMPILE_RANGE
REM Parse range (format: start-end)
for /f "tokens=1,2 delims=-" %%a in ("%PARAM1%") do (
    set START_BAB=%%a
    set END_BAB=%%b
)

if %START_BAB% LSS 1 (
    echo ERROR: Nomor bab awal tidak valid!
    pause
    exit /b 1
)
if %END_BAB% GTR 17 (
    echo ERROR: Nomor bab akhir tidak valid!
    pause
    exit /b 1
)
if %START_BAB% GTR %END_BAB% (
    echo ERROR: Bab awal harus lebih kecil dari bab akhir!
    pause
    exit /b 1
)

cls
echo ================================================
echo Compile Bab %START_BAB% sampai %END_BAB%
echo ================================================

for /L %%i in (%START_BAB%,1,%END_BAB%) do (
    set BAB_NUM=%%i
    call :DO_COMPILE_CHAPTER
)

echo.
echo ================================================
echo Selesai! Compiled bab %START_BAB%-%END_BAB%
echo ================================================
echo Lokasi: output\chapters\
echo.
echo CATATAN: Sitasi sudah diproses di setiap bab.
echo.
pause
exit /b 0

REM ================================================
REM COMPILE ALL CHAPTERS
REM ================================================
:COMPILE_ALL
cls
echo ================================================
echo Compile Semua Bab Secara Individual
echo ================================================
echo CATATAN: Sitasi \cite{} akan diproses dengan benar.
echo          Daftar pustaka lengkap hanya di compile buku lengkap.
echo ================================================
echo.
echo Akan compile 17 bab...
echo Proses ini memakan waktu beberapa menit.
echo.
pause

for /L %%i in (1,1,17) do (
    set BAB_NUM=%%i
    call :DO_COMPILE_CHAPTER
)

echo.
echo ================================================
echo Semua bab selesai dikompilasi!
echo ================================================
echo Lokasi: output\chapters\
echo.
echo CATATAN: Sitasi sudah diproses, tapi daftar pustaka lengkap
echo          hanya tersedia di buku lengkap (opsi [1]).
echo.

if "%1"=="" (
    pause
    goto MENU
) else (
    pause
    exit /b 0
)

REM ================================================
REM QUICK COMPILE (tanpa bibliography)
REM ================================================
:QUICK_MODE
cls
echo ================================================
echo Quick Compile - Preview Mode
echo ================================================
echo.

if /i "%PARAM2%"=="book" (
    echo Quick compiling buku lengkap...
    pdflatex -interaction=nonstopmode -output-directory=output main
    
    if exist "output\main.pdf" (
        move /Y "output\main.pdf" "output\pdf\main.pdf" >nul
        echo Output: output\pdf\main.pdf
    ) else (
        echo ERROR: Compilation gagal!
    )
) else (
    set BAB_NUM=%PARAM2%
    
    if %BAB_NUM% LSS 10 (
        set CHAPTER_FILE=ch0%BAB_NUM%
    ) else (
        set CHAPTER_FILE=ch%BAB_NUM%
    )
    
    if not exist "chapters\%CHAPTER_FILE%.tex" (
        echo ERROR: File tidak ditemukan!
        pause
        exit /b 1
    )
    
    echo Quick compiling bab %BAB_NUM%...
    cd chapters
    pdflatex -interaction=nonstopmode -output-directory=..\output %CHAPTER_FILE%.tex >nul
    cd ..
    
    if exist "output\%CHAPTER_FILE%.pdf" (
        move /Y "output\%CHAPTER_FILE%.pdf" "output\chapters\%CHAPTER_FILE%.pdf" >nul
        echo Output: output\chapters\%CHAPTER_FILE%.pdf
    ) else (
        echo ERROR: Compilation gagal!
    )
)

echo.
echo Note: Quick mode tidak menjalankan bibtex.
echo       Untuk compile lengkap, gunakan mode normal.

if "%1"=="" (
    echo.
    pause
    goto MENU
) else (
    pause
    exit /b 0
)

REM ================================================
REM END
REM ================================================
:END
cls
echo.
echo Terima kasih!
echo.
exit /b 0

