# Force library to scan local directory for FFmpeg libs. Without it, `LD_LIBRARY_PATH=.` is needed.
# This must come before add_library/add_executable
set(CMAKE_BUILD_RPATH "$ORIGIN")

add_library (pffft SHARED "fftpack.c" "fftpack.h" "pffft.c" "pffft.h")
add_executable (pffft_exe "test_pffft.c")
set_property(TARGET pffft_exe PROPERTY OUTPUT_NAME pffft_test)
target_link_libraries(pffft_exe pffft)
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






