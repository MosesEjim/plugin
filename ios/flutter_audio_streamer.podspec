#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_audio_streamer.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_audio_streamer'
  s.version          = '0.0.4'
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
  s.source_files = 'Classes/**/*.{h,m,mm,c}'
  s.public_header_files = 'Classes/**/*.h'
  s.vendored_libraries = 'lib/*.a'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES', 
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' ,
    'HEADER_SEARCH_PATHS' => '$(inherited) "$(PODS_TARGET_SRCROOT)/include/**"',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
    'OTHER_LDFLAGS' => '-force_load "$(PODS_TARGET_SRCROOT)/lib/libshout.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libogg.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libvorbis.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libvorbisenc.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libvorbisfile.a" -force_load "$(PODS_TARGET_SRCROOT)/lib/libmp3lame.a"'
  }
  s.swift_version = '5.0'
  s.static_framework = true
  s.libraries = 'c++'
end
