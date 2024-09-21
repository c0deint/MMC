@echo off
setlocal enabledelayedexpansion
echo Welcome to MINECRAFT OPTIONS CHANGER! press enter to continue
pause

set "configPath=%APPDATA%\.minecraft\options.txt"

if not exist "%configPath%" (
    echo Options.txt was not found in %configPath%.
    pause
    exit /b
)

set /a lineNum=0
for /f "delims=" %%A in ('type "%configPath%"') do (
    set /a lineNum+=1
    set "line[!lineNum!]=%%A"
)

for /L %%i in (1,1,!lineNum!) do (
    echo Line %%i: !line[%%i]!
    set "originalLine=!line[%%i]!"
    for /f "tokens=1* delims=:" %%A in ("!originalLine!") do (
        set "key=%%A"
        set "currentValue=%%B"
    )

    set /p "newValue=Digit the new value for %key% (%currentValue% or press enter to keep): "
    
    if not "!newValue!"=="" (
	set "line[%%i]=!key!:!newValue!"
    )
)

(
    for /L %%i in (1,1,!lineNum!) do (
        echo !line[%%i]!
    )
) > "%configPath%"

echo Configurations has been changed sucessful!
pause
