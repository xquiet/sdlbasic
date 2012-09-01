###############
# (C) 2012 by Matteo Pasotti <pasotti.matteo@gmail.com>
# License: GPLv3
###############


INCLUDE_DIRECTORIES( ${GLIB_INCLUDE_DIR} )
INCLUDE_DIRECTORIES( ${SDL_INCLUDE_DIR} )

MESSAGE(STATUS "SDL INCLUDE DIR:  " ${SDL_INCLUDE_DIR} )
MESSAGE(STATUS "GLIB INCLUDE DIR: " ${GLIB_INCLUDE_DIR} )

link_libraries ( ${SDL_LIBRARY} ${SDLTTF_LIBRARY} ${SDLNET_LIBRARY} ${SDLIMAGE_LIBRARY} ${SDLMIXER_LIBRARY} ${GLIB_LIBRARY} ${SMPEG_LIBRARIES} ${M_LIB} SDLengine )

add_library(BASengine datafunction.c membank.c dir.c file.c strings.c math.c)

