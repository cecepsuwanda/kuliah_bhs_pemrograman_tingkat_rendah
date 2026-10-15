@echo off
REM ============================================================
REM compile_ppt.bat
REM Mengompilasi seluruh deck slide (minggu-01 .. minggu-15)
REM dari ppt\src\ menjadi PDF di ppt\.
REM
REM Sumber  : ppt\src\minggu-NN.tex  (+ preamble-ppt.tex, listing-ppt.tex)
REM Hasil   : ppt\minggu-NN.pdf
REM
REM Dua lintasan pdflatex diperlukan agar nomor frame
REM (\inserttotalframenumber) dan daftar navigasi benar.
REM ============================================================

setlocal

set "ROOT_DIR=%~dp0"
REM Buang backslash di ujung: "%~dp0" selalu berakhir "\", dan
REM -output-directory="C:\...\ppt\" akan meng-escape kutip penutupnya
REM sehingga argumennya rusak.
set "OUT_DIR=%ROOT_DIR:~0,-1%"
set "SRC_DIR=%OUT_DIR%\src"

if not exist "%SRC_DIR%" (
    echo ERROR: folder sumber "%SRC_DIR%" tidak ditemukan.
    goto :end
)

where pdflatex >nul 2>nul
if errorlevel 1 (
    echo ERROR: pdflatex tidak ditemukan pada PATH.
    goto :end
)

pushd "%SRC_DIR%"

for %%F in (minggu-*.tex) do (
    echo ============================================================
    echo Mengompilasi %%~nF
    echo ============================================================
    pdflatex --enable-installer -interaction=nonstopmode -output-directory="%OUT_DIR%" "%%F"
    if errorlevel 1 echo PERINGATAN: lintasan pertama %%~nF melaporkan galat.
    pdflatex --enable-installer -interaction=nonstopmode -output-directory="%OUT_DIR%" "%%F"
    if errorlevel 1 (
        echo PERINGATAN: %%~nF selesai dengan galat. Periksa %%~nF.log
    ) else (
        echo OK: %OUT_DIR%\%%~nF.pdf
    )
)

popd

echo.
echo ============================================================
echo Pemeriksaan kaki slide (berbasis piksel)
echo ------------------------------------------------------------
echo Log yang bersih TIDAK menjamin tidak ada teks yang tertimpa
echo kaki slide: di beamer, frame bisa meluber tanpa memicu
echo "Overfull vbox". Pemeriksa ini mengukur celah putih di atas
echo pita footer tiap halaman.
echo ============================================================
where python >nul 2>nul
if errorlevel 1 (
    echo   python tidak ditemukan pada PATH -- pemeriksaan dilewati.
    echo   Jalankan manual: python scripts\check_luber.py "minggu-*.pdf"
) else (
    python "%OUT_DIR%\scripts\check_luber.py" "%OUT_DIR%\minggu-*.pdf"
)

echo.
echo Membersihkan berkas antara...
call :bersihkan "%OUT_DIR%"
call :bersihkan "%SRC_DIR%"

echo.
echo Selesai. Deck yang jadi ada di: %OUT_DIR%
goto :end

:bersihkan
set "TARGET=%~1"
if not exist "%TARGET%" exit /b 0
pushd "%TARGET%"
for %%E in (aux bcf blg out toc lof lot fls fdb_latexmk nav snm vrb idx ilg ind acn acr alg glg glo gls ist xdy synctex pdfsync) do (
    del /q "*.%%E" 2>nul
)
del /q "*.run.xml" 2>nul
del /q "*.synctex.gz" 2>nul
popd
exit /b 0

:end
endlocal
