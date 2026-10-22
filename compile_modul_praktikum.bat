@echo off
setlocal

REM ============================================================
REM compile_modul_praktikum.bat
REM Mengompilasi modul praktikum (modul_praktikum\main.tex)
REM menjadi modul_praktikum\main.pdf.
REM
REM Dua lintasan pdflatex diperlukan agar referensi tabel stabil.
REM Program .asm di folder code\ dirakit terpisah dengan TASM/TLINK;
REM batch ini hanya mengompilasi dokumen LaTeX.
REM
REM Pemeriksaan kelulusan:
REM   1. pdflatex keluar dengan kode 0 pada kedua lintasan.
REM   2. main.pdf terbentuk.
REM   3. main.log tidak memuat "!", "Overfull", atau "undefined".
REM ============================================================

set "ROOT_DIR=%~dp0"
set "SRC_DIR=%ROOT_DIR%modul_praktikum"
set "LOG_FILE=%SRC_DIR%\main.log"
set "PDF_FILE=%SRC_DIR%\main.pdf"
set "HAS_ERROR=0"

if not exist "%SRC_DIR%\main.tex" (
    echo [GAGAL] Berkas "%SRC_DIR%\main.tex" tidak ditemukan.
    goto :failed
)

where pdflatex >nul 2>nul
if errorlevel 1 (
    echo [GAGAL] pdflatex tidak ditemukan pada PATH.
    goto :failed
)

echo ============================================================
echo Mengompilasi modul praktikum
echo Sumber : %SRC_DIR%\main.tex
echo ============================================================

pushd "%SRC_DIR%"

echo.
echo [1/2] Lintasan pertama...
pdflatex --enable-installer -interaction=nonstopmode main.tex
if errorlevel 1 (
    echo [GAGAL] Lintasan pertama keluar dengan kode galat.
    goto :failed_pop
)

echo.
echo [2/2] Lintasan kedua...
pdflatex --enable-installer -interaction=nonstopmode main.tex
if errorlevel 1 (
    echo [GAGAL] Lintasan kedua keluar dengan kode galat.
    goto :failed_pop
)

echo.
echo Memeriksa hasil...

if not exist "%PDF_FILE%" (
    echo [GAGAL] main.pdf tidak terbentuk.
    set "HAS_ERROR=1"
)

if not exist "%LOG_FILE%" (
    echo [GAGAL] main.log tidak terbentuk.
    set "HAS_ERROR=1"
    goto :check_done
)

findstr /C:"!" "%LOG_FILE%" >nul 2>nul
if not errorlevel 1 (
    echo [GAGAL] main.log memuat tanda "!".
    set "HAS_ERROR=1"
)

findstr /C:"Overfull" "%LOG_FILE%" >nul 2>nul
if not errorlevel 1 (
    echo [GAGAL] main.log memuat "Overfull".
    set "HAS_ERROR=1"
)

findstr /C:"undefined" "%LOG_FILE%" >nul 2>nul
if not errorlevel 1 (
    echo [GAGAL] main.log memuat "undefined".
    set "HAS_ERROR=1"
)

:check_done

popd

if "%HAS_ERROR%"=="1" goto :failed

echo.
echo [OK] main.pdf terbentuk dan main.log bersih.
echo [OK] Hasil: %PDF_FILE%
goto :end

:failed_pop
popd

:failed
echo.
echo [GAGAL] Kompilasi modul praktikum tidak lulus pemeriksaan.
echo Periksa: %LOG_FILE%
exit /b 1

:end
echo.
echo Selesai.
pause
exit /b 0
