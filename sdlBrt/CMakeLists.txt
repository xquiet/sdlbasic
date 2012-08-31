project(sdlBrt)
# includo i moduli cmake
Include(FindPkgConfig)
Include(FindSDL)
Include(FindSDL_image)
Include(FindSDL_ttf)
Include(FindSDL_net)
Include(FindSDL_mixer)
Include(FindPNG)
Include(FindJPEG)
Include(FindTIFF)
Include(FindZLIB)
Include(FindALSA)
#Include(FindMPEG2)
Include(FindFreetype)

cmake_minimum_required(VERSION 2.8)

#find_package(Qt4 REQUIRED)
find_package(SDL REQUIRED)
find_package(SDL_ttf REQUIRED)
find_package(SDL_image REQUIRED)
find_package(SDL_net REQUIRED)
find_package(SDL_mixer REQUIRED)
find_package(PNG REQUIRED)
find_package(JPEG REQUIRED)
find_package(TIFF REQUIRED)
find_package(ZLIB REQUIRED)
find_package(ALSA REQUIRED)
#find_package(MPEG2 REQUIRED)
find_package(Freetype REQUIRED)
find_package(PkgConfig REQUIRED)

#----------------------------------------------------------------------------------------------
# non ho FindSmpeg

find_library(SMPEG_LIBRARY
         NAMES smpeg SMPEG Smpeg SMpeg
         PATHS
         $ENV{SMPEGDIR}/lib
         $ENV{SMPEGDIR}
         $ENV{SDLSOUNDDIR}/lib
         $ENV{SDLSOUNDDIR}
         $ENV{SDLDIR}/lib
         $ENV{SDLDIR}
         /usr/local/lib
         /usr/lib
         /sw/lib
         /opt/local/lib
         /opt/csw/lib
	 /opt/lib
         )
IF(SMPEG_LIBRARY)
	SET(SMPEG_FOUND TRUE)
	SET(SDL_SOUND_LIBRARIES_TMP ${SDL_SOUND_LIBRARIES_TMP} ${SMPEG_LIBRARY})
	SET(SMPEG_LIBRARIES ${SMPEG_LIBRARY})
ENDIF(SMPEG_LIBRARY)

#----------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------
# non ho FindOggVorbis nel sistema
# http://code.google.com/r/msclrhd-lugaru/source/browse/cmake/Modules/FindOggVorbis.cmake?r=a4c276e75d31292ec794607d12a996725cf98ff5

find_path(VORBIS_INCLUDE_DIR vorbis/vorbisfile.h)
find_path(OGG_INCLUDE_DIR ogg/ogg.h)

find_library(OGG_LIBRARY NAMES ogg)
find_library(VORBIS_LIBRARY NAMES vorbis)
find_library(VORBISFILE_LIBRARY NAMES vorbisfile)
find_library(VORBISENC_LIBRARY NAMES vorbisenc)

mark_as_advanced(VORBIS_INCLUDE_DIR OGG_INCLUDE_DIR
                 OGG_LIBRARY VORBIS_LIBRARY VORBISFILE_LIBRARY VORBISENC_LIBRARY)


if (VORBIS_INCLUDE_DIR AND VORBIS_LIBRARY AND VORBISFILE_LIBRARY AND VORBISENC_LIBRARY)
   set(OGGVORBIS_FOUND TRUE)

   set(OGGVORBIS_LIBRARIES ${OGG_LIBRARY} ${VORBIS_LIBRARY} ${VORBISFILE_LIBRARY} ${VORBISENC_LIBRARY})

   set(_CMAKE_REQUIRED_LIBRARIES_TMP ${CMAKE_REQUIRED_LIBRARIES})
   set(CMAKE_REQUIRED_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES} ${OGGVORBIS_LIBRARIES})
   check_library_exists(vorbis vorbis_bitrate_addblock "" HAVE_LIBVORBISENC2)
   set(CMAKE_REQUIRED_LIBRARIES ${_CMAKE_REQUIRED_LIBRARIES_TMP})

   if (HAVE_LIBVORBISENC2)
      set (OGGVORBIS_VERSION 2)
   else (HAVE_LIBVORBISENC2)
      set (OGGVORBIS_VERSION 1)
   endif (HAVE_LIBVORBISENC2)

else (VORBIS_INCLUDE_DIR AND VORBIS_LIBRARY AND VORBISFILE_LIBRARY AND VORBISENC_LIBRARY)
   set (OGGVORBIS_VERSION)
   set(OGGVORBIS_FOUND FALSE)
endif (VORBIS_INCLUDE_DIR AND VORBIS_LIBRARY AND VORBISFILE_LIBRARY AND VORBISENC_LIBRARY)


if (OGGVORBIS_FOUND)
   if (NOT OggVorbis_FIND_QUIETLY)
      MESSAGE(STATUS "Found OggVorbis: ${OGGVORBIS_LIBRARIES}")
   endif (NOT OggVorbis_FIND_QUIETLY)
else (OGGVORBIS_FOUND)
   if (OggVorbis_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could NOT find OggVorbis libraries")
   endif (OggVorbis_FIND_REQUIRED)
   if (NOT OggVorbis_FIND_QUITELY)
      MESSAGE(STATUS "Could NOT find OggVorbis libraries")
   endif (NOT OggVorbis_FIND_QUITELY)
endif (OGGVORBIS_FOUND)

#----------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------
# non ho FindGlib.cmake

pkg_check_modules(GLIB_PKG glib-2.0)

if (GLIB_PKG_FOUND)

    find_path(GLIB_INCLUDE_DIR  NAMES glib.h PATH_SUFFIXES glib-2.0
       PATHS
       ${GLIB_PKG_INCLUDE_DIRS}
       /usr/include/glib-2.0
       /usr/include
       /usr/local/include
    )
    find_path(GLIB_CONFIG_INCLUDE_DIR NAMES glibconfig.h PATHS ${GLIB_PKG_LIBDIR} PATH_SUFFIXES glib-2.0/include)
    find_library( GLIB_LIBRARY NAMES glib-2.0 
	           PATHS
	           ${GLIB_PKG_LIBRARY_DIRS}
	           /usr/lib
	           /usr/local/lib
	           /lib
	    )
else (GLIB_PKG_FOUND)
    # Find Glib even if pkg-config is not working (eg. cross compiling to Windows)
    find_library(GLIB_LIBRARY NAMES glib-2.0)
    string (REGEX REPLACE "/[^/]*$" "" GLIB_LIBRARY_DIR ${GLIB_LIBRARY})
    find_path(GLIB_INCLUDE_DIR NAMES glib.h PATH_SUFFIXES glib-2.0)
    find_path(GLIB_CONFIG_INCLUDE_DIR NAMES glibconfig.h PATHS ${GLIB_LIBRARY_DIR} PATH_SUFFIXES glib-2.0/include)
endif (GLIB_PKG_FOUND)

if (GLIB_INCLUDE_DIR AND GLIB_CONFIG_INCLUDE_DIR AND GLIB_LIBRARY)
    set(GLIB_INCLUDE_DIRS ${GLIB_INCLUDE_DIR} ${GLIB_CONFIG_INCLUDE_DIR})
endif (GLIB_INCLUDE_DIR AND GLIB_CONFIG_INCLUDE_DIR AND GLIB_LIBRARY)

if(GLIB_INCLUDE_DIRS AND GLIB_LIBRARY)
   set(GLIB_FOUND TRUE CACHE INTERNAL "glib-2.0 found")
   message(STATUS "Found glib-2.0: ${GLIB_INCLUDE_DIR}, ${GLIB_LIBRARY}")
else(GLIB_INCLUDE_DIRS AND GLIB_LIBRARY)
   set(GLIB_FOUND FALSE CACHE INTERNAL "glib-2.0 found")
   message(STATUS "glib-2.0 not found.")
endif(GLIB_INCLUDE_DIRS AND GLIB_LIBRARY)

mark_as_advanced(GLIB_INCLUDE_DIR GLIB_CONFIG_INCLUDE_DIR GLIB_INCLUDE_DIRS GLIB_LIBRARY)

#----------------------------------------------------------------------------------------------
# standard unix libraries

find_library(M_LIB m)

#----------------------------------------------------------------------------------------------

if(NOT SDL_FOUND)
	MESSAGE( FATAL ERROR "SDL not found!")
endif(NOT SDL_FOUND)

if(NOT SDLTTF_FOUND)
	MESSAGE( FATAL ERROR "SDL_ttf not found!")
endif(NOT SDLTTF_FOUND)

if(NOT SDLNET_FOUND)
	MESSAGE( FATAL ERROR "SDLnet not found!")
endif(NOT SDLNET_FOUND)

if(NOT SDLMIXER_FOUND)
	MESSAGE( FATAL ERROR "SDLmixer not found!")
endif(NOT SDLMIXER_FOUND)

if(NOT PNG_FOUND)
	MESSAGE( FATAL ERROR "PNG not found!")
endif(NOT PNG_FOUND)

if(NOT JPEG_FOUND)
	MESSAGE( FATAL ERROR "JPEG not found!")
endif(NOT JPEG_FOUND)

if(NOT TIFF_FOUND)
	MESSAGE( FATAL ERROR "TIFF not found!")
endif(NOT TIFF_FOUND)

if(NOT ZLIB_FOUND)
	MESSAGE( FATAL ERROR "ZLIB not found!")
endif(NOT ZLIB_FOUND)

if(NOT ALSA_FOUND)
	MESSAGE( FATAL ERROR "ALSA not found!")
endif(NOT ALSA_FOUND)

#if(NOT MPEG2_FOUND)
#	MESSAGE( FATAL ERROR "MPEG2 not found!")
#endif(NOT MPEG2_FOUND)

if(NOT SMPEG_FOUND)
	MESSAGE( FATAL ERROR "SMPEG not found!")
endif(NOT SMPEG_FOUND)

if(NOT OGGVORBIS_FOUND)
	MESSAGE( FATAL ERROR "OGGVORBIS not found!")
endif(NOT OGGVORBIS_FOUND)

if(NOT FREETYPE_FOUND)
	MESSAGE( FATAL ERROR "FREETYPE not found!")
endif(NOT FREETYPE_FOUND)

if(NOT GLIB_FOUND)
	MESSAGE( FATAL ERROR "GLIB not found!")
endif(NOT GLIB_FOUND)


if (NOT DATA_INSTALL_DIR)
  set (DATA_INSTALL_DIR share/apps/${PROJECT_NAME})
  set (PROJECT_DATA_DIR ${CMAKE_INSTALL_PREFIX}/${DATA_INSTALL_DIR})
else (NOT DATA_INSTALL_DIR)
  set (DATA_INSTALL_DIR ${DATA_INSTALL_DIR}/${PROJECT_NAME})
  set (PROJECT_DATA_DIR ${DATA_INSTALL_DIR})
endif (NOT DATA_INSTALL_DIR)

if (NOT DESKTOP_FILE_INSTALL_DIR)
  set (DESKTOP_FILE_INSTALL_DIR share/applications)
endif (NOT DESKTOP_FILE_INSTALL_DIR)

if (NOT DOC_INSTALL_DIR)
	set (DOC_INSTALL_DIR share/doc/${PROJECT_NAME})
	set (PROJECT_DOC_DIR ${CMAKE_INSTALL_PREFIX}/${DOC_INSTALL_DIR})
else (NOT DOC_INSTALL_DIR)
	set (DOC_INSTALL_DIR ${DOC_INSTALL_DIR}/${PROJECT_NAME})
	set (PROJECT_DOC_DIR ${DOC_INSTALL_DIR})
endif (NOT DOC_INSTALL_DIR)

if (NOT ICONS_DIR)
	set (ICONS_DIR share)
endif (NOT ICONS_DIR)

SET(CPACK_PACKAGE_DESCRIPTION_SUMMARY "sdlBrt is part of sdlBasic")
SET(CPACK_PACKAGE_VENDOR "Roberto Viola")

SET(CPACK_PACKAGE_VERSION_MAJOR "2007")
SET(CPACK_PACKAGE_VERSION_MINOR "07")
SET(CPACK_PACKAGE_VERSION_PATCH "14")
# VERSION_SUFFIX value
# beta1 "-beta1"
# beta2 "-beta2"
# rc1   "-rc1"
# final "" 
SET(VERSION_SUFFIX "final")

set(PROJECT_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}${VERSION_SUFFIX}")

set(PACKAGE_FILE_NAME    "${PROJECT_NAME}")
set(PACKAGE_FILE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}${VERSION_SUFFIX}")

IF (WIN32)
  SET(CPACK_PACKAGE_FILE_NAME "${PACKAGE_FILE_NAME}-${PACKAGE_FILE_VERSION}")
ELSE (WIN32)
  if (GENERATE)
	SET(CPACK_PACKAGE_CONTACT "Roberto Viola")
	SET(CPACK_RPM_PACKAGE_LICENSE GPL)
    	SET(CPACK_RPM_PACKAGE_VERSION "${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}")
    	if ("${VERSION_SUFFIX}" MATCHES "-beta1")
      		SET(CPACK_RPM_PACKAGE_RELEASE 0.1)
    	elseif ("${VERSION_SUFFIX}" MATCHES "-beta2")
      		SET(CPACK_RPM_PACKAGE_RELEASE 0.2)
    	elseif ("${VERSION_SUFFIX}" MATCHES "-rc1")
      		SET(CPACK_RPM_PACKAGE_RELEASE 0.3)
    	else ()
      		SET(CPACK_RPM_PACKAGE_RELEASE 1)
    	endif ()
    SET(CPACK_PACKAGE_FILE_NAME "${PACKAGE_FILE_NAME}-${CPACK_RPM_PACKAGE_VERSION}-${CPACK_RPM_PACKAGE_RELEASE}")
    SET(CPACK_DEBIAN_PACKAGE_NAME "${CPACK_PACKAGE_FILE_NAME}")
    SET(CPACK_DEBIAN_PACKAGE_VERSION "${CPACK_RPM_PACKAGE_VERSION}-${CPACK_RPM_PACKAGE_RELEASE}")
    SET(CPACK_GENERATOR ${GENERATE})
  else (GENERATE)
    SET(CPACK_PACKAGE_FILE_NAME "${PACKAGE_FILE_NAME}-bin-${PACKAGE_FILE_VERSION}")
    SET(CPACK_GENERATOR TBZ2 STGZ)
  endif (GENERATE)
ENDIF (WIN32)


SET(CPACK_SOURCE_IGNORE_FILES ".bzr" "build" ".bak" ".swp$" ".*~" 
                              ".svn" ".git" "CVS" "CVSROOT" ".kdev4"
                              "prepare_educazionik.rb" "release_educazionik.sh"
                              "RELEASE_HOWTO"
)
SET(CPACK_SOURCE_GENERATOR "TBZ2")
SET(CPACK_SOURCE_PACKAGE_FILE_NAME "${PACKAGE_FILE_NAME}-${PACKAGE_FILE_VERSION}")


# INCLUDE(CPack) must always be last!
INCLUDE(CPack)

set (DOC_FILES AUTHORS
               NEWS
               COPYING
               INSTALL
               README
               ChangeLog
)
MESSAGE( STATUS )
MESSAGE( STATUS "${PROJECT_NAME} ${PROJECT_VERSION}")
MESSAGE( STATUS "-------------------------------------------------------------------------------" )
MESSAGE( STATUS "DATA_INSTALL_DIR         " ${DATA_INSTALL_DIR} )
MESSAGE( STATUS "DOC_INSTALL_DIR          " ${DOC_INSTALL_DIR})
MESSAGE( STATUS "DESKTOP_FILE_INSTALL_DIR " ${DESKTOP_FILE_INSTALL_DIR})
MESSAGE( STATUS "ICONS_DIR                " ${ICONS_DIR})
MESSAGE( STATUS "CMAKE_INSTALL_PREFIX     " ${CMAKE_INSTALL_PREFIX} )
MESSAGE( STATUS "CMAKE_BUILD_TYPE         " ${CMAKE_BUILD_TYPE} )
MESSAGE( STATUS "PROJECT_SOURCE_DIR       " ${PROJECT_SOURCE_DIR} )
MESSAGE( STATUS "PROJECT_BIN_DIR          " ${PROJECT_BINARY_DIR} )
MESSAGE( STATUS )
MESSAGE( STATUS "Change a value with: cmake -D<Variable>=<Value>" )
MESSAGE( STATUS "-------------------------------------------------------------------------------" )
MESSAGE( STATUS )

# configure a header file to pass some of the CMake settings
# to the source code

#set ( FONT_PREFIX ${CMAKE_INSTALL_PREFIX}/share/fonts/ttf )
#set ( EXEC_PREFIX ${CMAKE_INSTALL_PREFIX}/bin )

add_definitions( -DFONT_PREFIX="${CMAKE_INSTALL_PREFIX}/share/fonts/ttf" )

IF (UNIX)
	add_definitions(-DUNIX=BOOL:1) 
ELSE(UNIX)
	add_definitions(-DUNIX=BOOL:0) 
ENDIF (UNIX)

#configure_file (
#	"${PROJECT_SOURCE_DIR}/sdlbrtconfig.h.in"
#	"${PROJECT_BINARY_DIR}/sdlbrtconfig.h"
#	)

#SET (BUILD_ALL true)
# add_subdirectory(BASengine)
# add_subdirectory(SDLengine)
# add_subdirectory(unzip)
# add_subdirectory(src)

#include_directories("${PROJECT_BINARY_DIR}")

include_directories ("${PROJECT_SOURCE_DIR}/BASengine")
add_subdirectory ( BASengine ) 
 
include_directories ("${PROJECT_SOURCE_DIR}/SDLengine")
add_subdirectory ( SDLengine ) 
 
include_directories ("${PROJECT_SOURCE_DIR}/unzip")
add_subdirectory ( unzip ) 

include_directories( ${SDL_INCLUDE_DIR} )
 
# add the executable
add_executable (sdlBrt sdlBrt.c)

MESSAGE( STATUS "GLIB LIBRARY:      " ${GLIB_LIBRARY} )
MESSAGE( STATUS "GLIB PKG LIB DIRS: " ${GLIB_PKG_LIBRARY_DIRS} )

target_link_libraries (sdlBrt ${SDL_LIBRARY} ${SDLTTF_LIBRARY} ${SDLNET_LIBRARY} ${SDLIMAGE_LIBRARY} ${SDLMIXER_LIBRARY} BASengine SDLengine unzip ${GLIB_LIBRARY} ${SMPEG_LIBRARIES} ${M_LIB})

install(FILES   ${DOC_FILES} DESTINATION   ${DOC_INSTALL_DIR})
