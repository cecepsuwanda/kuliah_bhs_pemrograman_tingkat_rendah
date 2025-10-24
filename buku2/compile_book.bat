@echo off
echo Compiling Buku Bahasa Pemrograman Tingkat Rendah...
echo.

REM Pastikan folder output, output\pdf, dan output\log ada
if not exist "output" mkdir output
if not exist "output\pdf" mkdir "output\pdf"
if not exist "output\log" mkdir "output\log"

REM Using biblatex with biber backend
echo Using biblatex with biber for bibliography...
pdflatex -interaction=nonstopmode -output-directory=output main
biber output\main
pdflatex -interaction=nonstopmode -output-directory=output main
pdflatex -interaction=nonstopmode -output-directory=output main

REM Pindahkan PDF ke folder output\pdf
echo.
echo Moving PDF to output\pdf...
if exist "output\main.pdf" (
    move /Y "output\main.pdf" "output\pdf\main.pdf"
    echo PDF moved successfully!
) else (
    echo Warning: main.pdf not found!
)

REM Pindahkan file log ke folder output\log
echo.
echo Moving log files to output\log...
if exist "output\main.log" move /Y "output\main.log" "output\log\main.log"
if exist "output\main.blg" move /Y "output\main.blg" "output\log\main.blg"
echo Log files moved!

echo.
echo Compilation completed!
echo Output PDF: output\pdf\main.pdf
echo Log files: output\log\
echo Other auxiliary files: output\
pause
