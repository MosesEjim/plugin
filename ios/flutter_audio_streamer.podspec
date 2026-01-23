#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_audio_streamer.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_audio_streamer'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter FFI plugin project.'
  s.description      = <<-DESC
A new Flutter FFI plugin project.
                       DESC
  s.homepage         = 'http://livemic.net'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'livemic.net' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*.{h,m,mm,c,swift}'
  s.public_header_files = 'Classes/**/*.h'
  s.vendored_libraries = 'lib/*.a'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES', 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'HEADER_SEARCH_PATHS' => '$(inherited) "$(PODS_TARGET_SRCROOT)/include/**"',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'OTHER_LDFLAGS' => '$(inherited) -force_load "$(PODS_TARGET_SRCROOT)/lib/libshout.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libogg.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libvorbis.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libvorbisenc.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libvorbisfile.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libmp3lame.a"'
  }
  
  # Propagate linker flags to the main app to ensure symbols are available for FFI
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS' => '$(inherited) -ObjC -all_load -Wl,-exported_symbol,_shout_init -Wl,-exported_symbol,_shout_new -Wl,-exported_symbol,_shout_open -Wl,-exported_symbol,_shout_send -Wl,-exported_symbol,_shout_close -Wl,-exported_symbol,_shout_free -Wl,-exported_symbol,_shout_set_host -Wl,-exported_symbol,_shout_set_port -Wl,-exported_symbol,_shout_set_user -Wl,-exported_symbol,_shout_set_password -Wl,-exported_symbol,_shout_set_mount -Wl,-exported_symbol,_shout_set_protocol -Wl,-exported_symbol,_shout_set_format -Wl,-exported_symbol,_shout_get_error -Wl,-exported_symbol,_shout_get_errno -Wl,-exported_symbol,_shout_set_metadata -Wl,-exported_symbol,_shout_metadata_new -Wl,-exported_symbol,_shout_metadata_add -Wl,-exported_symbol,_shout_metadata_free -Wl,-exported_symbol,_lame_init -Wl,-exported_symbol,_lame_init_params -Wl,-exported_symbol,_lame_encode_buffer -Wl,-exported_symbol,_lame_encode_flush -Wl,-exported_symbol,_lame_close -Wl,-exported_symbol,_lame_set_in_samplerate -Wl,-exported_symbol,_lame_set_out_samplerate -Wl,-exported_symbol,_lame_set_num_channels -Wl,-exported_symbol,_lame_set_brate -Wl,-exported_symbol,_lame_set_quality -Wl,-exported_symbol,_lame_set_mode'
  }
  
  s.swift_version = '5.0'
  s.static_framework = true
  s.libraries = 'c++'
end
