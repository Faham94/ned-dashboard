@echo off
echo ===================================================
echo  Compiling VB.NET Web Forms Hosting Server...
echo ===================================================

REM Ensure the bin directory exists
if not exist bin (
    mkdir bin
)

REM Copy Oracle managed driver into bin/ so the ASP.NET AppDomain can load it.
REM The DLL was obtained from NuGet package Oracle.ManagedDataAccess 12.2.1100 (net40 build).
if exist bin\Oracle.ManagedDataAccess.dll (
    echo Oracle.ManagedDataAccess.dll already present in bin\
) else (
    echo [WARNING] bin\Oracle.ManagedDataAccess.dll is missing!
    echo           Re-run the setup or copy it manually from the NuGet package.
)

REM 1. Compile ServerLib.dll
REM    Includes: Server.vb   - HTTP host infrastructure
REM              DbHelper.vb - Oracle connection helper (GetConnection)
REM    Page code-behinds (Default.aspx.vb, Dashboard.aspx.vb, etc.) are NOT
REM    compiled here — ASP.NET compiles them dynamically at runtime via CodeFile=.
echo Compiling ServerLib.dll...
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\vbc.exe ^
    /target:library ^
    /r:System.Web.dll,System.dll,System.Core.dll,System.Configuration.dll ^
    /r:bin\Oracle.ManagedDataAccess.dll ^
    /out:ServerLib.dll ^
    Server.vb DbHelper.vb RawPrinterHelper.vb
if %errorlevel% neq 0 (
    echo [ERROR] Failed to compile ServerLib.dll
    exit /b %errorlevel%
)

REM Copy ServerLib.dll into bin/ so ASP.NET AppDomain resolves it
copy /Y ServerLib.dll bin\ServerLib.dll >nul

REM 2. Compile Server.exe
echo Compiling Server.exe...
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\vbc.exe ^
    /target:exe ^
    /r:ServerLib.dll,System.dll,System.Core.dll,System.Web.dll ^
    /out:Server.exe ^
    Bootstrapper.vb
if %errorlevel% neq 0 (
    echo [ERROR] Failed to compile Server.exe
    exit /b %errorlevel%
)

echo ===================================================
echo  Compilation successful!
echo  Double-click Server.exe to start the web host.
echo  Navigate to: http://localhost:8080/Default.aspx
echo ===================================================

