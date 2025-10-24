@echo off
echo Cleaning up LaTeX auxiliary files...

REM Bersihkan file di root directory
del *.aux 2>nul
del *.log 2>nul
del *.toc 2>nul
del *.out 2>nul
del *.fdb_latexmk 2>nul
del *.fls 2>nul
del *.synctex.gz 2>nul
del *.bbl 2>nul
del *.blg 2>nul
del *.idx 2>nul
del *.ind 2>nul
del *.ilg 2>nul
del *.lof 2>nul
del *.lot 2>nul
del *.nav 2>nul
del *.snm 2>nul
del *.vrb 2>nul
del *.tdo 2>nul
del *.thm 2>nul
del *.dvi 2>nul
del *.ps 2>nul
del *.bcf 2>nul
del *.run.xml 2>nul

REM Bersihkan file di folder output (kecuali PDF dan log)
if exist "output\*.aux" del "output\*.aux" 2>nul
if exist "output\*.toc" del "output\*.toc" 2>nul
if exist "output\*.out" del "output\*.out" 2>nul
if exist "output\*.bbl" del "output\*.bbl" 2>nul
if exist "output\*.fdb_latexmk" del "output\*.fdb_latexmk" 2>nul
if exist "output\*.fls" del "output\*.fls" 2>nul
if exist "output\*.synctex.gz" del "output\*.synctex.gz" 2>nul
if exist "output\*.bcf" del "output\*.bcf" 2>nul
if exist "output\*.run.xml" del "output\*.run.xml" 2>nul

REM Bersihkan file log di folder output\log (opsional)
REM Uncomment baris di bawah jika ingin menghapus file log juga
REM if exist "output\log\*.log" del "output\log\*.log" 2>nul
REM if exist "output\log\*.blg" del "output\log\*.blg" 2>nul

echo.
echo Cleanup complete!
echo Note: PDF files in output\pdf\ and log files in output\log\ are preserved.
pause