@echo off
setlocal

set HRes=5312
set VRes=2988
set FRate=30000


:: Fix VRes
call :FindReplace "2496" "%VRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "2496" "%VRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "1920" "%VRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "1760" "%VRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "640" "%VRes%" "%temp%\Garmin\Virb\export_settings.xml"

:: Fix HRes
call :FindReplace "5760" "%HRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "4736" "%HRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "3840" "%HRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "3520" "%HRes%" "%temp%\Garmin\Virb\export_settings.xml"
REM call :FindReplace "1280" "%HRes%" "%temp%\Garmin\Virb\export_settings.xml"

:: Fix FRate
call :FindReplace "30000" "%FRate%" "%temp%\Garmin\Virb\export_settings.xml"

start /d "C:\Program Files\Garmin\VIRB Edit\" VirbExport.exe "%temp%\Garmin\Virb\export_settings.xml"
TaskMgr
exit

:FindReplace <findstr> <replstr> <file>
set tmp="%temp%\tmp.txt"
If not exist %temp%\_.vbs call :MakeReplace
for /f "tokens=*" %%a in ('dir "%3" /s /b /a-d /on') do (
  for /f "usebackq" %%b in (`Findstr /mic:"%~1" "%%a"`) do (
    echo(&Echo Replacing "%~1" with "%~2" in file %%~nxa
    <%%a cscript //nologo %temp%\_.vbs "%~1" "%~2">%tmp%
    if exist %tmp% move /Y %tmp% "%%~dpnxa">nul
  )
)
del %temp%\_.vbs
exit /b

:MakeReplace
>%temp%\_.vbs echo with Wscript
>>%temp%\_.vbs echo set args=.arguments
>>%temp%\_.vbs echo .StdOut.Write _
>>%temp%\_.vbs echo Replace(.StdIn.ReadAll,args(0),args(1),1,-1,1)
>>%temp%\_.vbs echo end with
