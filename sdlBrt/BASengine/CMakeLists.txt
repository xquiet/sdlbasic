###############
# (C) 2012 by Matteo Pasotti <pasotti.matteo@gmail.com>
# License: GPLv3
###############


INCLUDE_DIRECTORIES( ${GLIB_INCLUDE_DIR} )
INCLUDE_DIRECTORIES( ${SDL_INCLUDE_DIR} )

MESSAGE(STATUS "SDL INCLUDE DIR:  " ${SDL_INCLUDE_DIR} )
MESSAGE(STATUS "GLIB INCLUDE DIR: " ${GLIB_INCLUDE_DIR} )


add_library(BASengine datafunction.c membank.c dir.c file.c strings.c math.c)
