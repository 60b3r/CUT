@echo off
title 60b3r's CleanUp Tool
color 0a
set typ=*.*
set log="\logs.txt"
goto X

:E
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo wrong syntax, request cancelled, or an error has occured.
pause

:X
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo SCRIPT FEATURE OPTIONS and DESCRIPTIONS.
echo.
echo [A] Scan and make logs for files.
echo [B] Scan and delete 0-byte files.
echo [C] Scan and delete empty folders.
echo [D] ! Compete solution !
echo [Q] About and Credits
echo.
set /p e="> "
for %%a in (%e%) do call :%%a
goto X

:A
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo you have selected the option: [sf]
echo Only -SCAN- 0-byte files from defined directory.
echo logfile can be created after scanning is complete.
echo.
echo CAUTION: please provide a COMPLETE and CORRECT path.
echo (format: "drive:\dir\subdir\" without quote marks.)
set /p path="define path >"
if "%path%"=="" goto E
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo please wait while the script scans and logs the files.
echo do not close the program before the scan is complete.
pause
echo SCANNING STARTED. PLEASE WAIT...
echo.
for /r "%path%" %%F in (*) do if %%~zF==0 echo %%F
echo.
echo SCANNING FILES COMPLETED. make logfile (Y/N)?
set /p e="> "
if /i not "%e%"=="Y" goto E
if /i not "%e%"=="y" goto E
echo making logfile. please wait...
for /r "%path%" %%F in (*) do if %%~zF==0 echo "%%F" >>%log%
echo logfile created (%log%).
goto X

:B
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo you have selected option: [df]
echo Scan and -DELETE- 0 byte files from defined directory.
echo beware of script deleting important zero-byte system files.
echo.
echo CAUTION: no logfile is created for this session.
echo please choose scanning only option first for logging.
echo CAUTION: please provide a COMPLETE and CORRECT path.
echo (format: "drive:\dir\subdir\" without quote marks.)
set /p path="define path >"
if "%path%"=="" goto E
echo.
echo this will immediately DELETE ALL 0 byte files after scan.
echo are you sure you want to continue (Y/N)?
set /p e="> "
if /i not "%e%"=="Y" goto E
if /i not "%e%"=="y" goto E
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo please wait while the script is working the files.
echo do not close the program before the scan is complete.
echo.
echo SCANNING AND DELETING FILES...
echo.
for /r "%path%" %%F in (%typ%) do if %%~zF==0 del "%%F"
echo.
echo DELETE FILES COMPLETED.
goto X

:C
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo you have selected option [dd]
echo Scan and -DELETE- empty folders from CURRENT directory.
echo cannot delete folders with empty folders inside.
echo.
echo CAUTION: no logfile is created for this session.
echo please choose scanning only option first for logging.
echo CAUTION: please move script to root directory path.
echo script will only work on the location of its directory.
echo.
echo this will immediately DELETE ALL empty folders after scan.
echo are you sure you want to continue (Y/N)?
set /p e="> "
if /i not "%e%"=="Y" goto E
if /i not "%e%"=="y" goto E
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo please wait while the script is working the folders.
echo do not close the program before the scan is complete.
echo.
echo SCANNING AND DELETING FOLDERS...
echo.
for /f "delims=" %%i in ('dir /s /b /ad ^| sort /r') do rd "%%i" 2>NUL
echo.
echo DELETE FOLDERS COMPLETED. RUN SCRIPT AGAIN IF NECESSARY.
goto X

:D
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo you have selected option [cc]
echo ! Compete solution ! (silenty purges all junks)
echo script will only work on parent directory.
echo.
echo only use this script if you know what you're doing.
echo are you sure you want to continue (Y/N)?
set /p e="> "
if /i not "%e%"=="Y" goto E
if /i not "%e%"=="y" goto E

:F
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo do not interrupt while script is running.
echo executing purging sequence...
for /r %%F in (%typ%) do if %%~zF==0 del "%%F"
for /f "delims=" %%i in ('dir /s /b /ad ^| sort /r') do rd "%%i" 2>NUL
echo.
echo purge completed successfully.
echo re-run script again (Y/N)?
set /p e="> "
if /i not "%e%"=="Y" goto E
if /i not "%e%"=="y" goto E
goto F

:Q
cls
echo === 0-byte file and empty folder removal tool ===
echo another simple batch script for cleanup by 60b3r
echo.
echo you have selected option:
echo [Q] About and Credits
echo.
echo thanks to inspirations and tutorials:
echo the cleanup app RED v2.2	(jonasjohn.de)
echo Raymond Chen's blog	    (oldnewthing/22703)
echo Steve Jansen's github	    (steve-jansen)
echo.
echo created using Notepad on Windows 10 Education
echo packed using UPX (bat2exe v3.2) by Fatih Kodak
echo 'delete folder' icon (coquette) by dryicons
echo you may freely distribute this software anywhere
echo but please credit me by link to my webblog.
echo.
echo deprecated but useful features yet to be added:
echo 1. Choose different save location for log files.
echo 2. Change and save filters for file extensions.
echo 3. Deal with multiple nested folders at once.
echo.
echo please report bugs and revisions to:
echo 60b3r@email.com
echo also visit my blog for more content:
echo 60b3r.tumblr.com
echo.
pause
goto X
