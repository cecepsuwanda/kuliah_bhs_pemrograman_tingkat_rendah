@echo off
echo Cleaning up LaTeX auxiliary files...

del *.aux
del *.log
del *.toc
del *.out
del *.fdb_latexmk
del *.fls
del *.synctex.gz
del *.bbl
del *.blg
del *.idx
del *.ind
del *.ilg
del *.lof
del *.lot
del *.nav
del *.snm
del *.vrb
del *.tdo
del *.toc
del *.thm
del *.dvi
del *.ps

echo.
echo Cleanup complete!
pause