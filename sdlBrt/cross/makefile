#####################################################################################
#  sdlBasic Makefile v1.07 for all (beta 2) 		                            #
################################################################################
#
# syntax make OS=<targetplatform>
# [stripped=<yes/no>][compress=<no|gexe|upx>] [command]
#
################################################################################

# os is case insensitive

os=default
ifndef $(OS)
OS=$(os)
endif


TARGETEXE=sdlBrt

COMPILE=$(CPP) $(CFLAGS)

include cross/$(OS).mk
include */make.inc

#include sqlite3/make.inc

CFLAGS += $(EXTRA_CFLAGS) $(DEFINES)
LIBS += $(EXTRA_LIBS)


STAGE    := ../../
STAGEOS  := $(STAGE)/$(OS)
STAGEBIN := $(STAGEOS)/bin


TARGET=$(STAGEBIN)/$(TARGETEXE)

SQLITE_SRC=$(wildcard sqlite3/*.c)
UNZIP_SRC= $(wildcard unzip/*.c)
SDLENGINE_SRC=$(wildcard SDLengine/*.c)
BASENGINE_SRC=$(wildcard BASengine/*.c)

BAS_SRC=sdlBrt.c

SRC =  $(UNZIP_SRC) $(SDLENGINE_SRC) $(BASENGINE_SRC) $(BAS_SRC) $(SQLITE_SRC)

OBJECT := $(SRC:%.c=%-$(OS).o)

CROSSOBJECT :=$(wildcard *.o)
CROSSOBJECT :=$(wildcard SDLengine/*.o)
CROSSOBJECT +=$(wildcard BASengine/*.o)
CROSSOBJECT +=$(wildcard sqlite3/*.o)



all: 		$(TARGET)



$(TARGET):	$(OBJECT) $(RC)
	mkdir -p $(STAGEBIN)
	$(COMPILE) -o $(TARGET) $^ $(LIBS)
ifeq ($(stripped), yes)
	    $(STRIP) $(TARGET)
endif



$(OBJECT):		%-$(OS).o: 	%.c
	$(CC) $(CFLAGS) -c $< -o $@


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
	$(INSTALL) -c $(TARGET) ${exec_prefix}/$(TARGETEXE)


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
	$(RM) -f $(OBJECT) $(EXTRA_GEN)

cleanall:
	$(RM) -f $(CROSSOBJECT) $(EXTRA_GEN)
	$(RM) -rf $(STAGE)

dist-clean:	clean remove

sdlBrt_h.add:
	@echo  >> $@
	@for extra in $(EXTRA); do echo \#include \"extra/$$extra/wrap.h\"  >> $@; done

builtin_struct.add:
	@echo  >> $@
	@for extra in $(EXTRA); do cat extra/$$extra/builtin_struct.add  >> $@; done

builtin_h.add:
	@echo  >> $@
	@for extra in $(EXTRA); do cat extra/$$extra/builtin_h.add  >> $@; done

builtin_c.add:
	@echo  >> $@
	@for extra in $(EXTRA); do cat extra/$$extra/builtin_c.add  >> $@; done


show:
	@echo OS $(OS)
	@echo TARGET $(TARGET)
	@echo TARGETEXE $(TARGETEXE)
	@echo CFLAGS $(CFLAGS)
	@echo prefix $(prefix)
	@echo exec_prefix $(exec_prefix)
	@echo font_prefix $(font_prefix)

showsrc:
	@echo SRC:
	@echo "--------"
	@for src in $(SRC); do echo $$src; done

showobj:
	@echo OBJECTS:
	@echo "--------"
	@for obj in $(OBJECT); do echo $$obj; done

showxobj:
	@echo CROSSOBJECTS:
	@echo "--------"
	@for obj in $(CROSSOBJECT); do echo $$obj; done

