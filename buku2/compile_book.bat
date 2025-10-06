@echo off
echo Compiling Buku Bahasa Pemrograman Tingkat Rendah...
echo.

REM Check if biber is available
where biber >nul 2>nul
if %errorlevel% equ 0 (
    echo Using biber for bibliography...
    pdflatex materi_per_pertemuan
    biber materi_per_pertemuan
    pdflatex materi_per_pertemuan
    pdflatex materi_per_pertemuan
) else (
    echo Warning: biber not found, using bibtex...
    pdflatex materi_per_pertemuan
    bibtex materi_per_pertemuan
    pdflatex materi_per_pertemuan
    pdflatex materi_per_pertemuan
)

echo.
echo Compilation completed!
echo Output file: materi_per_pertemuan.pdf
pause
