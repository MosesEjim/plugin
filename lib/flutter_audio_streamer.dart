
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'flutter_audio_streamer_bindings_generated.dart';

class FlutterAudioStreamer {
  static final FlutterAudioStreamerBindings _bindings =
      FlutterAudioStreamerBindings();

  Isolate? _audioIsolate;
  SendPort? _isolateSendPort;

  bool _initialized = false;

  /// Initialize native audio stack (shout + lame)
  void init({
    required String host,
    required int port,
    required String mount,
    required String password,
    int sampleRate = 44100,
    int channels = 2,
    int bitrate = 128,
  }) {
   
  }

  /// Start streaming
  void start() {
    _ensureInit();
    _bindings.fas_start();
  }

  /// Push raw PCM frames (interleaved int16)
  void pushPcm(Int16List pcm) {
    _ensureInit();
    _bindings.fas_push_pcm(pcm, pcm.length ~/ 2);
  }

  /// Stop streaming (but keep encoder alive)
  void stop() {
    if (!_initialized) return;
    _bindings.fas_stop();
  }

  /// Free all native memory
  void dispose() {
    if (!_initialized) return;
    _bindings.fas_dispose();
    _initialized = false;
  }

  void _ensureInit() {
    if (!_initialized) {
      throw StateError('FlutterAudioStreamer not initialized');
    }
  }
}

