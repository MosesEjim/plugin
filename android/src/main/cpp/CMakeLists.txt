cmake_minimum_required(VERSION 3.10)

project(flutter_audio_streamer_library VERSION 0.0.1 LANGUAGES C)

add_library(flutter_audio_streamer SHARED
  "${CMAKE_CURRENT_SOURCE_DIR}/../../../../ios/Classes/flutter_audio_streamer.c"
  "${CMAKE_CURRENT_SOURCE_DIR}/../../../../ios/Classes/lame_wrapper.c"
  "${CMAKE_CURRENT_SOURCE_DIR}/../../../../ios/Classes/shout_wrapper.c"
)

# Explicitly set C standard
set(CMAKE_C_STANDARD 11)

# Include headers from iOS directory (reusing them)
target_include_directories(flutter_audio_streamer PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../../ios/include"
    "${CMAKE_CURRENT_SOURCE_DIR}/../../../../ios/Classes"
)

# Import prebuilt libraries
add_library(libshout SHARED IMPORTED)
set_target_properties(libshout PROPERTIES IMPORTED_LOCATION
    "${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/libshout.so"
)

add_library(libmp3lame SHARED IMPORTED)
set_target_properties(libmp3lame PROPERTIES IMPORTED_LOCATION
    "${CMAKE_CURRENT_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/libmp3lame.so"
)

# Link against the prebuilt libraries
target_link_libraries(flutter_audio_streamer
    libshout
    libmp3lame
    # Add other dependencies if they are separate files (ogg, vorbis, etc.)
    # If they are linked into libshout/libmp3lame or not needed by the plugin directly, they might not need explicit linking here unless symbols are missing.
    # Assuming libshout.so has its deps resolved or we just link what we use.
)

# Define macro for Android
target_compile_definitions(flutter_audio_streamer PUBLIC ANDROID)
