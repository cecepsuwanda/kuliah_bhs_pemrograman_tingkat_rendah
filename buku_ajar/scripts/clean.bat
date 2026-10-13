@echo off
setlocal

REM ============================================================
REM clean.bat
REM Menghapus berkas bantu LaTeX di seluruh direktori buku.
REM ============================================================

set "BOOK_DIR=%~dp0.."

echo ============================================================
echo Membersihkan berkas bantu LaTeX...
echo ============================================================

pushd "%BOOK_DIR%"

for %%E in (aux bbl blg bcf out toc lof lot lol fls fdb_latexmk nav snm vrb ^
            idx ilg ind acn acr alg glg glo gls ist xdy run.xml synctex ^
            synctex.gz pdfsync) do (
    del /s /q "*.%%E" 2>nul
)

rem latexmk -C juga menghapus pdf; pakai -c agar PDF tetap ada
where latexmk >nul 2>nul
if not errorlevel 1 (
    latexmk -c main.tex >nul 2>nul
)

popd

echo.
echo Pembersihan selesai.
echo.
pause
exit /b 0
