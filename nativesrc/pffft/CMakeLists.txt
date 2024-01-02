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

# C90 requires the gcc extensions for function attributes like always_inline
# C99 provides the function attributes: no gcc extensions required
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_EXTENSIONS ON)

set(CMAKE_CXX_STANDARD 98)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
include(GenerateExportHeader)
add_library (pffft SHARED "fftpack.c" "fftpack.h" "pffft.c" "pffft.h")
target_compile_definitions(pffft PRIVATE _USE_MATH_DEFINES)
if (USE_SCALAR_VECT)
  target_compile_definitions(pffft PRIVATE PFFFT_SCALVEC_ENABLED=1)
endif()
if (USE_DEBUG_ASAN)
  target_compile_options(pffft PRIVATE "-fsanitize=address")
endif()
if (NOT USE_SIMD)
  target_compile_definitions(pffft PRIVATE PFFFT_SIMD_DISABLE=1)
endif()
if (USE_SIMD AND USE_SIMD_NEON)
  target_compile_definitions(pffft PRIVATE PFFFT_ENABLE_NEON=1)
  target_compile_options(pffft PRIVATE "-mfpu=neon")
endif()
target_link_libraries( pffft ${MATHLIB} )



if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET ${TARGET_NAME} PROPERTY CXX_STANDARD 20)
endif()
set_property(TARGET pffft APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)
generate_export_header(pffft)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
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






