# Make file for SciTE on Linux or compatible OS
# Copyright 1998-2002 by Neil Hodgson <neilh@scintilla.org>
# The License.txt file describes the conditions under which this software may be distributed.
# This makefile assumes GCC 2.95.2 is used and changes will be needed to use other compilers.
# GNU make does not like \r\n line endings so should be saved to CVS in binary form.

.SUFFIXES: .cxx .o .h .a .c
CC = g++
AR = ar
CP=cp


# If explicit setting of GTK1 or GTK2 then use that else look for
# pkg-config which is an OK indication that GTK2 is available
ifndef GTK1
ifndef GTK2
ifneq (,$(findstring /,$(shell whereis pkg-config)))
GTK2=1
else
GTK1=1
endif
endif
endif

# For the Gnome desktop stuff to work, prefix must point to where Gnome thinks it is.
# "h@h@" is printed here when gnome-config unavailable. Seems harmless.
ifdef GTK2
CONFIGFLAGS=pkg-config --cflags gtk+-2.0
CONFIGLIB=pkg-config --libs gtk+-2.0 gthread-2.0
CONFIGTHREADS=
gnomeprefix:=$(shell pkg-config --variable=prefix gtk+-2.0 2>/dev/null)
else
CONFIGFLAGS=gtk-config --cflags
CONFIGLIB=gtk-config --libs
CONFIGTHREADS=glib-config --libs gthread
gnomeprefix:=$(shell gnome-config --prefix 2>/dev/null)
endif
ifndef prefix
  prefix=/usr
endif
datadir=$(prefix)/share
pixmapdir=$(datadir)/pixmaps
bindir=$(prefix)/bin
SYSCONF_PATH=$(prefix)/share/sdlBasic
DOC_PATH=$(prefix)/share/doc/sdlBasic
PLUGINS_PATH=$(prefix)/share/sdlBasic/plugins

INSTALL=install -o root -g root

PROG	= ../../linux/bin/sdlBasic

all: 	$(PROG)
	strip $(PROG)
	$(CP) -f -R ../share ../../linux

vpath %.h ../src ../scintilla/include
vpath %.cxx ../src

#CXXFLAGS= -g -DGTK -DSCI_LEXER -DSYSCONF_PATH=\"$(SYSCONF_PATH)\" -Wwrite-strings
INCLUDEDIRS=-I ../scintilla/include -I ../src
CXXBASEFLAGS=-W -Wall -DGTK -DSCI_LEXER -DPIXMAP_PATH=\"$(pixmapdir)\" -DSYSCONF_PATH=\"$(SYSCONF_PATH)\" $(INCLUDEDIRS)

ifdef DEBUG
CXXTFLAGS=-DDEBUG -g $(CXXBASEFLAGS)
else
CXXTFLAGS=-DNDEBUG -Os $(CXXBASEFLAGS)
endif
CXXFLAGS=$(CXXTFLAGS) -DNO_LUA
ifeq ($(shell uname), Darwin)
CXXFLAGS:=$(CXXFLAGS) -Dunix
endif

.cxx.o:
	$(CC) `$(CONFIGFLAGS)` $(CXXFLAGS) -c $< -o $@

clean:
	rm -f *.o $(PROG)
	rm -f -R ../../linux/share

deps:
	$(CC) -MM `$(CONFIGFLAGS)` $(CXXFLAGS) *.cxx ../src/*.cxx >deps.mak

# make should be run in ../../scintilla/gtk to compile all the lexers.
COMPLIB=../scintilla/gtk/scintilla.a

$(PROG): SciTEGTK.o SciTEBase.o SciTEBuffers.o SciTEIO.o Exporters.o \
MultiplexExtension.o SciTEProps.o Utf8_16.o \
	$(COMPLIB) $(LUA_OBJS)
	$(CC) `$(CONFIGTHREADS)` -DGTK $^ -o $@ `$(CONFIGLIB)`

# Automatically generate header dependencies with "make deps"
include deps.mak

