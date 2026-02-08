@echo off
echo ============================================================
echo Menghapus file hasil kompilasi LaTeX di seluruh codebase...
echo (termasuk semua subfolder hingga terdalam)
echo ============================================================

pushd "%~dp0"

del /s /q *.aux 2>nul
del /s /q *.log 2>nul
del /s /q *.out 2>nul
del /s /q *.toc 2>nul
del /s /q *.lof 2>nul
del /s /q *.lot 2>nul
del /s /q *.bbl 2>nul
del /s /q *.blg 2>nul
del /s /q *.lol 2>nul
del /s /q *.synctex.gz 2>nul
del /s /q *.fls 2>nul
del /s /q *.fdb_latexmk 2>nul
del /s /q *.nav 2>nul
del /s /q *.snm 2>nul
del /s /q *.vrb 2>nul
del /s /q *.pdf 2>nul

popd

echo.
echo Pembersihan selesai! Semua file LaTeX temporary telah dihapus.
pause
