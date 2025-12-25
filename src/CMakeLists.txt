# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(flutter_audio_streamer_library VERSION 0.0.1 LANGUAGES C)

# Flutter required
set(CMAKE_C_STANDARD 11)
# ---- headers ----
include_directories(
    ios/include
    ios/Classes
)

add_library(flutter_audio_streamer SHARED
  "flutter_audio_streamer.c"
  flutter_audio_streamer
  STATIC
  ios/Classes/flutter_audio_streamer.c
  ios/Classes/lame_wrapper.c
  ios/Classes/shout_wrapper.c
)

target_link_libraries(
    flutter_audio_streamer
    ${CMAKE_SOURCE_DIR}/ios/lib/libmp3lame.a
    ${CMAKE_SOURCE_DIR}/ios/lib/libogg.a
    ${CMAKE_SOURCE_DIR}/ios/lib/libvorbis.a
    ${CMAKE_SOURCE_DIR}/ios/lib/libvorbisenc.a
    ${CMAKE_SOURCE_DIR}/ios/lib/libvorbisfile.a
    ${CMAKE_SOURCE_DIR}/ios/lib/libshout.a
)

# ---- required iOS frameworks ----
find_library(SECURITY_FRAMEWORK Security)
find_library(CFNETWORK_FRAMEWORK CFNetwork)
find_library(COREFOUNDATION_FRAMEWORK CoreFoundation)

target_link_libraries(
    flutter_audio_streamer
    ${SECURITY_FRAMEWORK}
    ${CFNETWORK_FRAMEWORK}
    ${COREFOUNDATION_FRAMEWORK}
)

set_target_properties(flutter_audio_streamer PROPERTIES
  PUBLIC_HEADER flutter_audio_streamer.h
  OUTPUT_NAME "flutter_audio_streamer"
)

target_compile_definitions(flutter_audio_streamer PUBLIC DART_SHARED_LIB)

if (ANDROID)
  # Support Android 15 16k page size
  target_link_options(flutter_audio_streamer PRIVATE "-Wl,-z,max-page-size=16384")
endif()
