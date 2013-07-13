@echo off

set Project=RSSReader
set ProjectTests=%Project%Tests

set msb=c:\Windows\Microsoft.NET\Framework\v2.0.50727\MSBuild.exe
set path=C:\Program Files\Embarcadero\RAD Studio\7.0\bin;%path%
call rsvars.bat

echo Building tests...
del %~dp0bin\test\%ProjectTests%.exe 2> NUL
%msb% %~dp0%ProjectTests%.dproj /p:DCC_Define="CONSOLE_TESTRUNNER" > %~dp0bin\last-build-log.txt
if not exist %~dp0bin\test\%ProjectTests%.exe goto buildfailed

cls
%~dp0bin\test\%ProjectTests%.exe
if %errorlevel% neq 0 goto testsfailed
goto testspassed

:buildfailed
color 0c
echo Build failed. Check error log in bin\last-build-log.txt
%~dp0bin\last-build-log.txt
goto done

:testsfailed
color 0c
echo Tests failed
goto done

:testspassed
color 0a
echo Building main project...
del %~dp0bin\%Project%.exe 2> NUL
%msb% %~dp0%Project%.dproj > %~dp0bin\last-build-log.txt
if not exist %~dp0bin\%Project%.exe goto buildfailed
echo DONE
goto done

:done
pause
color 0f
