@echo off
REM ============================================================
REM compile_asm.bat
REM Launcher untuk compile_asm.ps1.
REM
REM Tanpa argumen: menguji semua .asm di modul_praktikum\code
REM dan buku_ajar\code\asm.
REM
REM Contoh:
REM   compile_asm.bat
REM   compile_asm.bat modul_praktikum\code\m01-cetak-karakter.asm
REM ============================================================
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0compile_asm.ps1" %*
exit /b %errorlevel%
