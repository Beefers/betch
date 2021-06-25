:: betch
:: A fetch script written in Batch.
:: Created by Beef
:: I hate myself

:: Initial Load
@echo off
:: We use %~dp0 here to account for whatever directory betch is running in - this will always specify the script directory.
@set mainDir=%~dp0
@set mem=wmic os get FreeVirtualMemory, FreePhysicalMemory, FreeVirtualMemory,MaxProcessMemorySize,TotalVisibleMemorySize,TotalVirtualMemorySize
@set storage=wmic volume where "driveLetter='c:'" get capacity,freespace

for /F "useBackq tokens=1-4" %%A In (
    `powershell "$OS=GWmi Win32_OperatingSystem;$UP=(Get-Date)-"^
    "($OS.ConvertToDateTime($OS.LastBootUpTime));$DO='d='+$UP.Days+"^
    "' h='+$UP.Hours+' n='+$UP.Minutes+' s='+$UP.Seconds;echo $DO"`) do (
    set "%%A"&set "%%B"&set "%%C"&set "%%D")

echo - %USERNAME%@%USERDOMAIN%
echo - %OS%
echo - %PROCESSOR_IDENTIFIER%
echo - %d% days, %h% hours, %n% minutes, %s% seconds
set /p "=- " <nul
cmd /c %mem%
set /p "=- " <nul
cmd /c %storage%