@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM build-chapter.bat
REM Mengompilasi satu bab secara mandiri.
REM
REM Penggunaan:
REM     scripts\build-chapter.bat 03
REM     scripts\build-chapter.bat all
REM
REM PENTING: kompilasi dijalankan DI DALAM direktori bab,
REM karena preamble.tex menghitung path relatif dari sana.
REM ============================================================

set "BOOK_DIR=%~dp0.."
set "ROOT_DIR=%~dp0..\.."
set "OUTPUT_DIR=%ROOT_DIR%\output"

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

if "%~1"=="" (
    echo Penggunaan: build-chapter.bat ^<nomor-bab^>
    echo Contoh    : build-chapter.bat 03
    echo             build-chapter.bat all
    exit /b 1
)

if /i "%~1"=="all" (
    set "LIST="
    for /d %%D in ("%BOOK_DIR%\chapters\*") do (
        if exist "%%D\chapter.tex" set "LIST=!LIST! %%~nxD"
    )
) else (
    set "LIST=%~1"
)

for %%N in (%LIST%) do (
    if not exist "%BOOK_DIR%\chapters\%%N\chapter.tex" (
        echo Bab %%N tidak ditemukan, dilewati.
    ) else (
        echo ------------------------------------------------------------
        echo Building Chapter %%N
        echo ------------------------------------------------------------
        pushd "%BOOK_DIR%\chapters\%%N"
        latexmk -pdf -interaction=nonstopmode chapter.tex
        if errorlevel 1 (
            pdflatex -interaction=nonstopmode chapter.tex
            pdflatex -interaction=nonstopmode chapter.tex
        )
        if exist "chapter.pdf" (
            move /y "chapter.pdf" "%OUTPUT_DIR%\bab-%%N.pdf" >nul
            echo   -^> %OUTPUT_DIR%\bab-%%N.pdf
        ) else (
            echo   GAGAL: chapter.pdf tidak terbentuk untuk bab %%N
        )
        popd
    )
)

echo.
echo Selesai.
echo.
pause
exit /b 0
