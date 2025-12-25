import 'dart:ffi';
import 'dart:io';


// Opaque struct
base class lame_global_flags extends Opaque {}

final DynamicLibrary lameLib = Platform.isAndroid
    ? DynamicLibrary.open("libmp3lame.so")
    : DynamicLibrary.process();
/**
 * The native functions are called in shout_wrapper.c
 * as {$native_function_name}_wrapper
 */
final String wrapperExtension = Platform.isAndroid?'':'_wrapper';
// === Typedefs ===

typedef LameInitNative = Pointer<lame_global_flags> Function();
typedef LameInit = Pointer<lame_global_flags> Function();
final LameInit lameInit = lameLib
    .lookup<NativeFunction<LameInitNative>>('lame_init$wrapperExtension')
    .asFunction();

typedef LameSetInSamplerateNative = Int32 Function(Pointer<lame_global_flags>, Int32);
typedef LameSetInSamplerate = int Function(Pointer<lame_global_flags>, int);
final LameSetInSamplerate lameSetInSamplerate = lameLib
    .lookup<NativeFunction<LameSetInSamplerateNative>>('lame_set_in_samplerate$wrapperExtension')
    .asFunction();

typedef LameSetOutSamplerateNative = Int32 Function(Pointer<lame_global_flags>, Int32);
typedef LameSetOutSamplerate = int Function(Pointer<lame_global_flags>, int);
final LameSetOutSamplerate lameSetOutSamplerate = lameLib
    .lookup<NativeFunction<LameSetOutSamplerateNative>>('lame_set_out_samplerate$wrapperExtension')
    .asFunction();

typedef LameSetNumChannelsNative = Int32 Function(Pointer<lame_global_flags>, Int32);
typedef LameSetNumChannels = int Function(Pointer<lame_global_flags>, int);
final LameSetNumChannels lameSetNumChannels = lameLib
    .lookup<NativeFunction<LameSetNumChannelsNative>>('lame_set_num_channels$wrapperExtension')
    .asFunction();

typedef LameSetBitrateNative = Int32 Function(Pointer<lame_global_flags>, Int32);
typedef LameSetBitrate = int Function(Pointer<lame_global_flags>, int);
final LameSetBitrate lameSetBitrate = lameLib
    .lookup<NativeFunction<LameSetBitrateNative>>('lame_set_brate$wrapperExtension')
    .asFunction();

typedef LameSetQualityNative = Int32 Function(Pointer<lame_global_flags>, Int32);
typedef LameSetQuality = int Function(Pointer<lame_global_flags>, int);
final LameSetQuality lameSetQuality = lameLib
    .lookup<NativeFunction<LameSetQualityNative>>('lame_set_quality$wrapperExtension')
    .asFunction();

typedef LameSetVBRNative = Int32 Function(Pointer<lame_global_flags>, Int32);
typedef LameSetVBR = int Function(Pointer<lame_global_flags>, int);
final LameSetVBR lameSetVBR = lameLib
    .lookup<NativeFunction<LameSetVBRNative>>('lame_set_VBR$wrapperExtension')
    .asFunction();

typedef LameInitParamsNative = Int32 Function(Pointer<lame_global_flags>);
typedef LameInitParams = int Function(Pointer<lame_global_flags>);
final LameInitParams lameInitParams = lameLib
    .lookup<NativeFunction<LameInitParamsNative>>('lame_init_params$wrapperExtension')
    .asFunction();

typedef LameEncodeBufferNative = Int32 Function(
  Pointer<lame_global_flags>,
  Pointer<Int16>,
  Pointer<Int16>,
  Int32,
  Pointer<Uint8>,
  Int32
);
typedef LameEncodeBuffer = int Function(
  Pointer<lame_global_flags>,
  Pointer<Int16>,
  Pointer<Int16>,
  int,
  Pointer<Uint8>,
  int
);
final LameEncodeBuffer lameEncodeBuffer = lameLib
    .lookup<NativeFunction<LameEncodeBufferNative>>('lame_encode_buffer')
    .asFunction();

typedef LameEncodeFlushNative = Int32 Function(
  Pointer<lame_global_flags>,
  Pointer<Uint8>,
  Int32
);
typedef LameEncodeFlush = int Function(
  Pointer<lame_global_flags>,
  Pointer<Uint8>,
  int
);
final LameEncodeFlush lameEncodeFlush = lameLib
    .lookup<NativeFunction<LameEncodeFlushNative>>('lame_encode_flush')
    .asFunction();

typedef LameCloseNative = Int32 Function(Pointer<lame_global_flags>);
typedef LameClose = int Function(Pointer<lame_global_flags>);
final LameClose lameClose = lameLib
    .lookup<NativeFunction<LameCloseNative>>('lame_close')
    .asFunction();
