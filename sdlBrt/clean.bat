@echo off

rem clean batch file
cd SDLengine
    call clean.bat
cd ..
cd unzip
    call clean.bat
cd ..
cd BASengine
    call clean.bat
cd ..

del *.o
del sdlBrt.exe
del sdlBrt
del ~sdlBrt
