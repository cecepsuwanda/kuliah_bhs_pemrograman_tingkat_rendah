<#
.SYNOPSIS
    Merakit dan menautkan berkas .asm 16-bit (TASM/TLINK) lewat DOSBox.

.DESCRIPTION
    DOSBox 0.74 hanya mendukung nama 8.3. Wrapper ini menyalin setiap
    berkas ke C:\TASM\WORK\PROG.ASM, menjalankan TASM/TLINK di DOSBox,
    lalu menyalin .OBJ/.COM/.EXE kembali ke folder asal dengan nama asli.

    Tanpa argumen, semua .asm di modul_praktikum\code dan
    buku_ajar\code\asm diuji. Argumen dapat berupa berkas atau folder.

.EXAMPLE
    .\compile_asm.ps1
    .\compile_asm.ps1 modul_praktikum\code\m01-cetak-karakter.asm
    .\compile_asm.ps1 modul_praktikum\code buku_ajar\code\asm
#>
param(
    [switch]$KeepWork,
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Paths
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$DosBox   = 'C:\Program Files (x86)\DOSBox-0.74-3\DOSBox.exe'
$TasmBin  = 'C:\TASM\BIN'
$WorkDir  = 'C:\TASM\WORK'

if (-not (Test-Path -LiteralPath $DosBox)) {
    throw "DOSBox tidak ditemukan: $DosBox"
}
foreach ($tool in @('TASM.EXE', 'TLINK.EXE')) {
    if (-not (Test-Path -LiteralPath (Join-Path $TasmBin $tool))) {
        throw "$tool tidak ditemukan di $TasmBin"
    }
}

if (-not $Paths -or $Paths.Count -eq 0) {
    $Paths = @(
        (Join-Path $RepoRoot 'modul_praktikum\code'),
        (Join-Path $RepoRoot 'buku_ajar\code\asm')
    )
}

$files = New-Object System.Collections.Generic.List[string]
foreach ($p in $Paths) {
    if (-not (Test-Path -LiteralPath $p)) {
        Write-Warning "Tidak ditemukan: $p"
        continue
    }
    $item = Get-Item -LiteralPath $p
    if ($item.PSIsContainer) {
        Get-ChildItem -LiteralPath $p -Filter '*.asm' -File |
            ForEach-Object { $files.Add($_.FullName) }
    } elseif ($item.Extension -ieq '.asm') {
        $files.Add($item.FullName)
    } else {
        Write-Warning "Bukan berkas .asm: $p"
    }
}
$files = @($files | Sort-Object -Unique)

if ($files.Count -eq 0) {
    throw 'Tidak ada berkas .asm yang diproses.'
}

New-Item -ItemType Directory -Force -Path $WorkDir | Out-Null

function Clear-WorkDir {
    Get-ChildItem -LiteralPath $WorkDir -Force -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

function Invoke-DosBoxBuild {
    param([string]$BatchName)
    $arg = '-noconsole -c "mount c ' + $WorkDir +
           '" -c "mount d ' + $TasmBin +
           '" -c "c:" -c "' + $BatchName + '" -c "exit"'
    $proc = Start-Process -FilePath $DosBox -ArgumentList $arg `
        -WorkingDirectory $WorkDir -WindowStyle Minimized -Wait -PassThru
    return $proc.ExitCode
}

$ok = 0
$failed = 0
$failedFiles = New-Object System.Collections.Generic.List[string]

Write-Host "Merakit $($files.Count) berkas .asm dengan TASM/TLINK di DOSBox..."
Write-Host ""

foreach ($file in $files) {
    $leaf = Split-Path -Leaf $file
    $dir  = Split-Path -Parent $file
    $base = [IO.Path]::GetFileNameWithoutExtension($file)

    Clear-WorkDir
    Copy-Item -LiteralPath $file -Destination (Join-Path $WorkDir 'PROG.ASM') -Force

    $content = Get-Content -LiteralPath $file -Raw
    $isCom = $content -match '(?im)^\s*\.MODEL\s+TINY\b'
    $linkOpt = if ($isCom) { '/t ' } else { '' }
    $outExt = if ($isCom) { '.COM' } else { '.EXE' }

    $buildBat = @"
@echo off
d:\tasm.exe PROG.ASM > TASM.LOG
if errorlevel 1 goto end
d:\tlink.exe $linkOpt PROG.OBJ > TLINK.LOG
:end
exit
"@
    Set-Content -LiteralPath (Join-Path $WorkDir 'BUILD.BAT') `
        -Value $buildBat -Encoding ASCII

    Invoke-DosBoxBuild -BatchName 'BUILD.BAT' | Out-Null

    $tasmLog = Join-Path $WorkDir 'TASM.LOG'
    $tlinkLog = Join-Path $WorkDir 'TLINK.LOG'
    $objPath = Join-Path $WorkDir 'PROG.OBJ'
    $outPath = Join-Path $WorkDir ('PROG' + $outExt)

    $tasmText  = if (Test-Path -LiteralPath $tasmLog)  { Get-Content -LiteralPath $tasmLog -Raw }  else { '' }
    $tlinkText = if (Test-Path -LiteralPath $tlinkLog) { Get-Content -LiteralPath $tlinkLog -Raw } else { '' }

    $tasmOk = (Test-Path -LiteralPath $objPath) -and
              ($tasmText -match '(?i)Error messages:\s+None')
    $linkOk = (Test-Path -LiteralPath $outPath) -and
              ($tlinkText -notmatch '(?i)\b(error|fatal|undefined)\b')

    if ($tasmOk -and $linkOk) {
        Copy-Item -LiteralPath $objPath -Destination (Join-Path $dir ($base + '.obj')) -Force
        Copy-Item -LiteralPath $outPath -Destination (Join-Path $dir ($base + $outExt.ToLower())) -Force
        $mapPath = Join-Path $WorkDir 'PROG.MAP'
        if (Test-Path -LiteralPath $mapPath) {
            Copy-Item -LiteralPath $mapPath -Destination (Join-Path $dir ($base + '.map')) -Force
        }
        $size = (Get-Item -LiteralPath $outPath).Length
        Write-Host ("OK     {0} -> {1}{2} ({3} byte)" -f $leaf, $base, $outExt.ToLower(), $size)
        $ok++
    } else {
        Write-Host ("GAGAL  {0}" -f $leaf) -ForegroundColor Red
        Write-Host ("       Folder kerja: {0}" -f $WorkDir) -ForegroundColor DarkGray
        if ($tasmText) {
            Write-Host '--- TASM.LOG ---' -ForegroundColor DarkGray
            Write-Host $tasmText.TrimEnd()
        }
        if ($tlinkText) {
            Write-Host '--- TLINK.LOG ---' -ForegroundColor DarkGray
            Write-Host $tlinkText.TrimEnd()
        }
        $failedFiles.Add($file)
        $failed++
    }
}

Write-Host ''
Write-Host ("Ringkasan: {0} berhasil, {1} gagal, total {2}." -f $ok, $failed, $files.Count)
if ($failed -gt 0) {
    Write-Host 'Berkas gagal:' -ForegroundColor Red
    foreach ($f in $failedFiles) { Write-Host ("  - {0}" -f $f) -ForegroundColor Red }
    Write-Host ("Log terakhir dipertahankan di {0}" -f $WorkDir)
    exit 1
}

if (-not $KeepWork) { Clear-WorkDir }
exit 0
