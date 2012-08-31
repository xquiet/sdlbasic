#####################################################################################
#  sdlBasic Makefile v1.07 for all (beta 2) 		                            #
#####################################################################################
#
# syntax make OS=<platform> [exec_prefix=<exec_prefix>] [font_prefix=<font_prefix>]
# [stripped=<yes/no>][compress=<no|gexe|upx>] [command]
#
# platforms supported = [linux|osx|freebsd|openbsd|netbsd|morphos|amigaos4]
# main commands = [install|remove|clean|distclean]
#
######################################################################################

#------------------------------------------------------------------------------------#
# OPTION #

# stripped: activate/deactivate stripped's executable [yes-NO]
# compress:  executable crunch [NO-gzexe-UPX]
#------------------------------------------------------------------------------------#



#-----------------------------------------------------------------------------------------------------------------------------#

BAS_SRC=sdlBrt.c
BAS_INC_SRC=array.c const.c eval.c node.c stack.c var.c builtin.c data.c keyword.c \
symbol.c y_tab.c class.c error.c lexer.c shared.c trace.c

SRC =  $(UNZIP_SRC) $(BASENGINE_SRC) $(BAS_SRC)

#-----------------------------------------------------------------------------------------------------------------------------#

UNZIP_OBJ=unzip/unzip.a
SDLENGINE_OBJ=SDLengine/SDLengine.a
BASENGINE_OBJ=BASengine/BASengine.a
BAS_OBJ= sdlBrt.o

OBJECT= $(BAS_OBJ) $(UNZIP_OBJ) $(BASENGINE_OBJ) $(SDLENGINE_OBJ)

#-----------------------------------------------------------------------------------------------------------------------------#

#os is case insensitive
ifndef $(OS)
OS=$(os)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# WIN32 #

ifeq ($(OS), win32)
TARGET= ../../bin/sdlBrt.exe
xTARGET= ../../bin/~sdlBrt.exe

RC=RCsdlBrt.o
mingw=c:/devel/c-cpp/MinGW

ifndef prefix
    prefix=c:/programmi/sdlBasic
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf


stripped=yes
compress=no

CC= gcc
CPP=g++
INSTALL=copy
RM=del
STRIP=strip

CFLAG= -Wall -mwindows -g -O2 -I $(mingw)/include
LIBS= -lmingw32 -lSDLmain -lSDL -lSDL_image  -lSDL_mixer -lSDL_ttf -lSDL_net -lsmpeg
COMPILE=$(CPP) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# LINUX #

ifeq ($(OS), linux)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/opt/sdlBasic
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=yes
compress=no

CC= gcc
CPP=g++
INSTALL=/usr/bin/install
RM=rm
STRIP=strip

CFLAG= -Wall -g -O2 -I/usr/include/SDL -D_REENTRAT -DPLAY_MOD -DUNIX -DLINUX

COMPILE=$(CPP) $(CFLAG)

LIBS=-Wl,-rpath, -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lvorbisfile -lvorbis -logg -lsmpeg -lasound -lSDL -lpng -ltiff -lz -ljpeg -lpthread -lm -lfreetype -ldl
#LIBS=-Wl,-rpath, -lSDL -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net  -lsmpeg -lpthread -lm -lfreetype -lSDL -lpng -ljpeg -ltiff -lz -ldirectfb -ldirect -lesd -lasound -lopenal -lartsc  -ldl
#LIBS= -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lsmpeg
COMPILE=$(CPP) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# GP2X #

ifeq ($(OS), gp2x)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/mnt/sd/sdlBasic
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=yes
compress=no

CC= /usr/local/open2x/bin/open2x-gcc
CPP=/usr/local/open2x/bin/open2x-g++
INSTALL=/usr/bin/install
RM=rm
STRIP=/usr/local/open2x/bin/open2x-strip

CFLAG= -static -Wall -g -O2 -I/usr/local/open2x/open2x/include -I/usr/local/open2x/open2x/include/SDL -D_REENTRAT -DPLAY_MOD -DUNIX -DGP2X
LIBS=-L/usr/local/open2x/open2x/lib -Wl,-rpath, -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lsmpeg -lSDL -lpng -ltiff -lz -ljpeg -lpthread -lm -lfreetype -ldl
COMPILE=$(CPP) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# MAC OSX #

ifeq ($(OS), osx)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/usr/local
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=yes
compress=no

CC= gcc
CPP=g++
INSTALL=/usr/bin/install
RM=rm
STRIP=strip

CFLAG= -g -O2 -I/usr/local/include/SDL -D_REENTRAT -DPLAY_MOD -DUNIX  -Wno-long-double
LIBS= -lobjc -framework Appkit -framework Carbon -framework IOKit `sdl-config --libs` -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lsmpeg -lfreetype -ljpeg -lpng -lz
COMPILE=$(CC) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# FREEBSD #

ifeq ($(OS), freebsd)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/usr/local
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=yes
compress=UPX

CC= gcc
CPP=g++
INSTALL=/usr/bin/install
RM=rm
STRIP=strip

CFLAG= -Wall -g -O2 -I/usr/local/include/SDL11 -D_REENTRAT -DPLAY_MOD -DUNIX -DFBSD
LIBS=-lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lsmpeg -L/usr/local/lib \
-lpthread
COMPILE=$(CPP) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# OPENBSD #

ifeq ($(OS), openbsd)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/usr/local
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=yes
compress=no

CC= gcc
CPP=g++
INSTALL=/usr/bin/install
RM=rm
STRIP=strip

CFLAG= -Wall -g -O2 -I/usr/local/include/SDL -D_REENTRAT -DPLAY_MOD -DUNIX -DOPENBSD
LIBS=-L/usr/local/lib -L/usr/X11R6/lib -lX11 -lXext -lpthread -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lsmpeg
COMPILE=$(CPP) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# NETBSD #

ifeq ($(OS), netbsd)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/usr/local
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=yes
compress=no

CC= gcc
CPP=g++
INSTALL=/usr/bin/install
RM=rm
STRIP=strip

CFLAG= -Wall -g -O2 -L/usr/pkg/lib -I/usr/pkg/include/SDL -D_REENTRAT -DPLAY_MOD -DUNIX -DNETBSD
LIBS=-lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lsmpeg
COMPILE=$(CPP) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# MORPHOS #

ifeq ($(OS), morphos)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/usr/local
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=yes
compress=no

CC= gcc -noixemul
CPP=g++
INSTALL=/usr/bin/install
RM=rm
STRIP=strip

CFLAG= -Wall -g -O3 -fomit-frame-pointer -mmultiple -mstring -I/usr/include/SDL -D_REENTRAT -DPLAY_MOD -DUNIX -D__MORPHOS__
LIBS= -lSDL -lSDL_mixer -lSDL_image -lSDL_ttf -lSDL_net -lsmpeg
COMPILE=$(CPP) $(CFLAG)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#
# AMIGAOS4 #

ifeq ($(OS), amigaos4)
TARGET= ../../bin/sdlBrt
xTARGET= ../../bin/~sdlBrt

ifndef prefix
    prefix=/usr/local
endif
exec_prefix=$(prefix)/bin
font_prefix=$(prefix)/share/fonts/ttf

stripped=no
compress=no

# on amiga can be: ppc-amigaos-strip --remove-section=.comment $(TARGET)
CC= ppc-amigaos-gcc
CPP= ppc-amigaos-g++
INSTALL=/usr/bin/install
RM=rm
STRIP=strip

CFLAG= -Wall -ggdb -O3 -fomit-frame-pointer -mmultiple -mstring -D__USE_INLINE__ -D__USE_NETINET_IN_H -I/usr/local/amiga/ppc-amigaos/local/clib2/include/SDL/ -D_REENTRAT -DPLAY_MOD -DUNIX
LIBS= -lsmpeg -lSDL_mixer -lSDL_image -lSDL_ttf -lfreetype -lSDL_net -lSDL -lpng -lz -ljpeg -lvorbisfile -lvorbis -logg -lauto -lm -lnet -lunix
COMPILE=$(CPP) $(CFLAG) $(LIBS)
endif

#----------------------------------------------------------------------------------------------------------------------------------------#

all: 		$(TARGET)

$(TARGET):	$(OBJECT) $(RC)
	$(COMPILE) -o $(TARGET) $^ $(LIBS)

ifeq ($(stripped), yes)
	    $(STRIP) $(TARGET)
endif


$(BAS_OBJ):		%.o: 	%.c $(BAS_INC_SRC)
	$(CC) $(CFLAG) -Dfont_prefix=\"$(font_prefix)\" -c $< -o $@




RCsdlBrt.o:	RCsdlBrt.rc
	windres RCsdlBrt.rc RCsdlBrt.o


install:	install-bin install-fonts

install-bin:	all
ifeq ($(compress), gzexe)
	gzexe $(TARGET)
endif
ifeq ($(compress), UPX)
	upx -9 $(TARGET)
endif
	$(INSTALL) -c -m 755 -d ${exec_prefix}
	$(INSTALL) -c $(TARGET) ${exec_prefix}


install-fonts:
	$(INSTALL) -c -m 755 -d ${font_prefix}/dejavu
	$(INSTALL)  fonts/DejaVuSans.ttf ${font_prefix}/dejavu/DejaVuSans.ttf
	$(INSTALL)  fonts/DejaVuSansMono-Roman.ttf ${font_prefix}/dejavu/DejaVuSansMono-Roman.ttf

remove:	remove-bin	remove-fonts

remove-bin:
	$(RM) ${exec_prefix}/$(TARGET)

remove-fonts:
	$(RM) ${font_prefix}/dejavu/DejaVuSans.ttf
	$(RM) ${font_prefix}/dejavu/DejaVuSansMono-Roman.ttf

clean:
	$(RM) *.o
	$(RM) $(TARGET)
	$(RM) $(xTARGET)

dist-clean:	clean remove

