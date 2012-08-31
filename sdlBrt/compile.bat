@echo off

cd SDLengine
    call compile.bat
cd ..
cd unzip
    call compile.bat
cd ..
cd BASengine
    call compile.bat
cd ..

echo now compiling sdlBasic: please wait

rem WARNING!!! verify the correct path of mingGw
set MINGWPATH=c:\devel\c-cpp\mingw
path %MINGWPATH%\bin;%PATH%

mingw32-make os=win32

rem backup sdlBrt.exe
rem copy ..\..\bin\sdlBrt.exe C:\devel\basic\sdlBasic\bin\win32\mingw
