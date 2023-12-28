cmake_minimum_required(VERSION 3.2)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
project("pffft" VERSION 1.0.0 LANGUAGES C CXX)
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

message("Target Name :: ${TARGET_NAME}")
# Set the version property.
set_target_properties(pffft PROPERTIES VERSION ${PROJECT_VERSION})
# Set the shared object version property to the project's major version.
set_target_properties(pffft PROPERTIES SOVERSION ${PROJECT_VERSION_MAJOR})
# Set the public header property to the one with the actual API.
set_target_properties(pffft PROPERTIES PUBLIC_HEADER pffft.h)



if (WIN32)
	set_target_properties(pffft PROPERTIES PREFIX "" SUFFIX ".${PRESET_NAME}.dll")
else()
	set_target_properties(pffft PROPERTIES PREFIX "" SUFFIX ".${PRESET_NAME}.so")
endif()






