# Make file for SciTE on Windows
# Copyright 1998-2002 by Neil Hodgson <neilh@scintilla.org>
# The License.txt file describes the conditions under which this software may be distributed.
# This makefile assumes the mingw32 version of GCC 3.2 is used and changes will
# be needed to use other compilers.

CROSS=i386-mingw32msvc
SDK    = /opt/cross-tools/mingw
#CROSS=i686-pc-mingw32
#SDK    = /opt/cross-tools/mingw32

PREFIX = $(SDK)/$(CROSS)

OPATH := $(PATH)
PATH  := $(OPATH):$(SDK)/bin

prefix=$(PREFIX)

exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf


.SUFFIXES: .cxx
CC = $(CROSS)-g++
WINDRES =$(CROSS)-windres
DLLWRAP = dllwrap
DEL = rm -f 
CP = cp

PROGSTATIC = ../../win32/bin/sdlBasic.exe

ifndef NOTHUNKS
gversion = $(word 1,$(subst ., ,$(shell g++ --version)))
ifeq ($(gversion),2)
THUNKFLAGS=-fvtable-thunks
endif
endif

vpath %.h ../src ../scintilla/include ../scintilla/win32
vpath %.cxx ../src
vpath %.o ../scintilla/win32
vpath %.a ../scintilla/win32


INCLUDEDIRS=-I ../scintilla/include -I ../scintilla/win32 -I ../src
RCINCLUDEDIRS=--include-dir ../scintilla/win32 --include-dir ../src

CBASEFLAGS = -W -Wall $(INCLUDEDIRS) -mno-cygwin

ifdef DEBUG
CFLAGS=-DDEBUG -g $(CBASEFLAGS) -Wall -mwindows -g -O2 -static -I$(PREFIX)/include

else
CFLAGS=-DNDEBUG -Os $(CBASEFLAGS) -Wall -mwindows -g -O2 -static -I$(PREFIX)/include
STRIPFLAG="-Wl,-s"
endif

CXXFLAGS = $(CFLAGS) -pedantic -fno-exceptions $(THUNKFLAGS) -fno-rtti -mno-cygwin

LDFLAGS=-mwindows -lcomctl32 -limm32 -lole32 -luuid -mno-cygwin

.cxx.o:
	$(CC) $(CXXFLAGS) -c $< -o $@

.c.o:
	gcc $(CFLAGS) -c $< -o $@

OTHER_OBJS	= SciTEBuffers.o SciTEIO.o Exporters.o SciTEProps.o \
SciTEWin.o SciTEWinBar.o SciTEWinDlg.o MultiplexExtension.o \
UniqueInstance.o WindowAccessor.o \
PropSet.o PlatWin.o UniConversion.o Utf8_16.o SciTERes.o \
DirectorExtension.o XPM.o

OBJS = SciTEBase.o $(OTHER_OBJS)

ALL:	$(PROGSTATIC)  	
	strip $(PROGSTATIC)
	$(CP) -f -Ru ../share ../../win32/

clean:
	$(DEL) ../../win32/bin/*.exe  *.o *.obj *.dll *.res *.map
	$(DEL) -R ../../win32/share

deps:
	$(CC) -MM $(CXXFLAGS) *.cxx ../src/*.cxx >deps.mak



OBJSSTATIC = Sc1.o SciTEWinBar.o SciTEWinDlg.o MultiplexExtension.o \
	UniqueInstance.o SciTEBase.o SciTEBuffers.o \
	SciTEIO.o Exporters.o SciTEProps.o  Editor.o \
	DocumentAccessor.o KeyWords.o ExternalLexer.o \
	ContractionState.o CellBuffer.o CallTip.o Sc1Res.o PlatWin.o \
	Utf8_16.o KeyMap.o Indicator.o LineMarker.o RESearch.o \
	AutoComplete.o DirectorExtension.o MultiplexExtension.o  \
	Lexers.a Document.o DocumentAccessor.o ScintillaWinL.o ScintillaBaseL.o PropSet.o Style.o StyleContext.o UniConversion.o ViewStyle.o WindowAccessor.o XPM.o

$(PROGSTATIC): $(OBJSSTATIC)
	$(CC) $(STRIPFLAG) -Xlinker --subsystem -Xlinker windows -o $@ $^ $(LDFLAGS)

# Automatically generate dependencies for most files with "make deps"
include deps.mak

Sc1.o: SciTEWin.cxx SciTEWin.h SciTE.h Accessor.h WindowAccessor.h KeyWords.h PropSet.h \
 SString.h Scintilla.h Extender.h SciTEBase.h
	$(CC) $(CXXFLAGS) -D STATIC_BUILD -c $< -o $@

SciTERes.o:	SciTERes.rc SciTE.h PlatformRes.h
	$(WINDRES) $(RCINCLUDEDIRS) SciTERes.rc $@

# Also depends on ../src/Embedded.properties but may not want to build everywhere
# so must explicitly ask to build it.
Sc1Res.o:	SciTERes.rc SciTE.h PlatformRes.h
	$(WINDRES) $(RCINCLUDEDIRS) SciTERes.rc --define STATIC_BUILD $@

# Make sure SciTEBase gets rebuilt (so its about box gets a new
# date stamp) when any of the other objects are updated.
SciTEBase.o: $(OTHER_OBJS)
