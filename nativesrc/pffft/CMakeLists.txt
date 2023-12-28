cmake_minimum_required(VERSION 3.2)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
project("pffft" C)

set(CMAKE_SCAN_FOR_MODULES)
if ("${CMAKE_C_COMPILER_ID}" STREQUAL "MSVC")
  # using Visual Studio C++
  message(STATUS "INFO: detected MSVC: will not link math lib m")
  set(MATHLIB "")
else()
  message(STATUS "INFO: detected NO MSVC: ${CMAKE_C_COMPILER_ID}: will link math lib m")
  set(MATHLIB "m")
endif()

add_library (pffft SHARED "fftpack.c" "fftpack.h" "pffft.c" "pffft.h")
target_link_libraries( pffft ${MATHLIB} )
target_compile_definitions(pffft PRIVATE _USE_MATH_DEFINES)
if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD 20)
endif()



if (WIN32)
	set(LIB_PREFIX "")
	set(LIB_EXT .dll)
else()
	set(LIB_PREFIX "lib")
	set(LIB_EXT .so)
endif()






