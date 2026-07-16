@echo off
echo ===================================================
echo  Compiling VB.NET Web Forms Hosting Server...
echo ===================================================

REM Ensure the bin directory exists
if not exist bin (
    mkdir bin
)

REM 1. Compile Server.vb into a Class Library (ServerLib.dll)
echo Compiling ServerLib.dll...
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\vbc.exe /target:library /r:System.Web.dll,System.dll,System.Core.dll /out:ServerLib.dll Server.vb
if %errorlevel% neq 0 (
    echo [ERROR] Failed to compile ServerLib.dll
    exit /b %errorlevel%
)

REM 2. Compile Bootstrapper.vb into a Console Application (Server.exe) referencing ServerLib.dll
echo Compiling Server.exe...
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\vbc.exe /target:exe /r:ServerLib.dll,System.dll,System.Core.dll,System.Web.dll /out:Server.exe Bootstrapper.vb
if %errorlevel% neq 0 (
    echo [ERROR] Failed to compile Server.exe
    exit /b %errorlevel%
)

echo ===================================================
echo  Compilation successful!
echo  Double-click Server.exe to start the web host.
echo ===================================================
