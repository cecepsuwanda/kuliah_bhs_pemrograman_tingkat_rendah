@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM compile_bab.bat
REM Mengompilasi setiap bab buku ajar secara mandiri.
REM
REM Struktur yang dipakai (lihat Arsitektur_Buku_Ajar.md):
REM     buku_ajar\chapters\NN\chapter.tex
REM
REM Kompilasi dijalankan DI DALAM direktori bab, karena
REM preamble.tex menghitung path relatif dari sana.
REM ============================================================

set "ROOT_DIR=%~dp0"
set "OUTPUT_DIR=%ROOT_DIR%output"
set "SOURCE_DIR=%ROOT_DIR%buku_ajar"
set "CHAPTERS_DIR=%SOURCE_DIR%\chapters"

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

if not exist "%CHAPTERS_DIR%" (
    echo ERROR: direktori %CHAPTERS_DIR% tidak ditemukan.
    goto :end
)

echo ============================================================
echo Compiling Individual Chapters
echo ============================================================

for /d %%D in ("%CHAPTERS_DIR%\*") do (
    if exist "%%D\chapter.tex" (
        set "BAB_NAME=%%~nxD"
        echo.
        echo ------------------------------------------------------------
        echo Compiling Bab !BAB_NAME!...
        echo ------------------------------------------------------------

        pushd "%%D"

        pdflatex -interaction=nonstopmode -halt-on-error chapter.tex
        if !errorlevel! equ 0 (
            pdflatex -interaction=nonstopmode -halt-on-error chapter.tex

            if exist "chapter.pdf" (
                echo Moving chapter.pdf to output as bab-!BAB_NAME!.pdf...
                move /y "chapter.pdf" "%OUTPUT_DIR%\bab-!BAB_NAME!.pdf" >nul
            )
        ) else (
            echo ERROR compiling Bab !BAB_NAME!.
        )

        popd
    )
)

echo Cleaning up intermediate files...
call :cleanup "%SOURCE_DIR%"

echo.
echo Operation Completed. Check the output folder for PDFs.
goto :end

:cleanup
set "TARGET_FOLDER=%~1"
pushd "%TARGET_FOLDER%"
for %%E in (aux bbl blg bcf out toc lof lot lol fls fdb_latexmk nav snm vrb idx ilg ind acn acr alg glg glo gls ist xdy run.xml synctex pdfsync synctex.gz) do (
    del /s /q "*.%%E" 2>nul
)
popd
exit /b 0

:end
echo.
pause
exit /b 0
