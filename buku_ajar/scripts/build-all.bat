@echo off
setlocal

REM ============================================================
REM build-all.bat
REM Mengompilasi seluruh buku dari main.tex.
REM Hasil: ..\..\output\main.pdf
REM ============================================================

set "BOOK_DIR=%~dp0.."
set "ROOT_DIR=%~dp0..\.."
set "OUTPUT_DIR=%ROOT_DIR%\output"

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo ============================================================
echo Building complete book
echo ============================================================

pushd "%BOOK_DIR%"

latexmk -pdf -interaction=nonstopmode -output-directory="%OUTPUT_DIR%" main.tex

if errorlevel 1 (
    echo latexmk gagal, memakai pdflatex berulang...
    pdflatex -interaction=nonstopmode -output-directory="%OUTPUT_DIR%" main.tex
    pdflatex -interaction=nonstopmode -output-directory="%OUTPUT_DIR%" main.tex
    pdflatex -interaction=nonstopmode -output-directory="%OUTPUT_DIR%" main.tex
)

popd

echo.
echo Selesai. Berkas: %OUTPUT_DIR%\main.pdf
echo.
pause
exit /b 0
