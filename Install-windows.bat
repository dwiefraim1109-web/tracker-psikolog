@echo off
title Install Tracker Psikolog
color 0A

echo.
echo ================================================================
echo    INSTALL TRACKER PSIKOLOG KLINIS
echo ================================================================
echo.

cd /d "%~dp0"

if not exist "tracker.html" (
    echo [ERROR] File tracker.html tidak ditemukan!
    echo Letakkan file ini di folder yang sama dengan tracker.html
    echo.
    pause
    exit /b 1
)

echo [OK] tracker.html ditemukan
echo [OK] Membuat shortcut...

set "VBS=%TEMP%\create_shortcut_tracker.vbs"

(
echo Set oWS = WScript.CreateObject^("WScript.Shell"^)
echo Set oFS = CreateObject^("Scripting.FileSystemObject"^)
echo curDir = oFS.GetParentFolderName^("%~f0"^)
echo htmlPath = curDir ^& "\tracker.html"
echo paths = Array^( _
echo     oWS.ExpandEnvironmentStrings^("%ProgramFiles%\Google\Chrome\Application\chrome.exe"^), _
echo     oWS.ExpandEnvironmentStrings^("%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"^), _
echo     oWS.ExpandEnvironmentStrings^("%LocalAppData%\Google\Chrome\Application\chrome.exe"^), _
echo     oWS.ExpandEnvironmentStrings^("%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"^), _
echo     oWS.ExpandEnvironmentStrings^("%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"^) _
echo ^)
echo browser = ""
echo For Each p In paths
echo     If oFS.FileExists^(p^) Then browser = p : Exit For
echo Next
echo If browser = "" Then
echo     MsgBox "Chrome/Edge tidak ditemukan!", 16, "Error"
echo     WScript.Quit
echo End If
echo htmlURL = "file:///" ^& Replace^(htmlPath, "\", "/"^)
echo shortcut = oWS.SpecialFolders^("Desktop"^) ^& "\Tracker Psikolog.lnk"
echo Set oLink = oWS.CreateShortcut^(shortcut^)
echo oLink.TargetPath = browser
echo oLink.Arguments = "--app=""" ^& htmlURL ^& """"
echo oLink.WorkingDirectory = curDir
echo oLink.WindowStyle = 1
echo oLink.Save
echo MsgBox "Shortcut dibuat di Desktop!", 64, "Sukses"
) > "%VBS%"

cscript //nologo "%VBS%"
del "%VBS%"

echo.
echo [SELESAI] Cek Desktop untuk shortcut "Tracker Psikolog"
echo.
pause