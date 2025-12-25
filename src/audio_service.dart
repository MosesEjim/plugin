import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'lame.dart';
import 'shout.dart';

/// High-level API for audio encoding + streaming
class AudioService {
  // Shout instance
  Pointer<Void>? _shout;

  // LAME encoder instance
  Pointer<lame_global_flags>? _lame;

  // === Initialization ===
  void init() {
    // Init Shout
    shoutInit();
    _shout = shoutNew();

    // Init LAME
    _lame = lameInit();
  }

  // === Configure Shout ===
  void setHost(String host) {
    final ptr = host.toNativeUtf8();
    shoutSetHost(_shout!, ptr);
    malloc.free(ptr);
  }

  void setPort(int port) => shoutSetPort(_shout!, port);

  void setUser(String user) {
    final ptr = user.toNativeUtf8();
    shoutSetUser(_shout!, ptr);
    malloc.free(ptr);
  }

  void setPassword(String password) {
    final ptr = password.toNativeUtf8();
    shoutSetPassword(_shout!, ptr);
    malloc.free(ptr);
  }

  void setMount(String mount) {
    final ptr = mount.toNativeUtf8();
    shoutSetMount(_shout!, ptr);
    malloc.free(ptr);
  }

  void setFormat(int format) => shoutSetFormat(_shout!, format);
  void setProtocol(int protocol) => shoutSetProtocol(_shout!, protocol);
  void setNonBlocking(bool value) => shoutSetNonBlocking(_shout!, value ? 1 : 0);

  bool open() => shoutOpen(_shout!) == 0;
  void close() {
    shoutClose(_shout!);
    _shout = null;

    lameClose(_lame!);
    _lame = null;
  }

  bool isConnected() => shoutGetConnected(_shout!) == 1;

  String getShoutError() {
    final ptr = shoutGetError(_shout!);
    return ptr == nullptr ? '' : ptr.toDartString();
  }

  // === Configure LAME ===
  void setLameInSampleRate(int rate) => lameSetInSamplerate(_lame!, rate);
  void setLameOutSampleRate(int rate) => lameSetOutSamplerate(_lame!, rate);
  void setLameNumChannels(int channels) => lameSetNumChannels(_lame!, channels);
  void setLameBitrate(int bitrate) => lameSetBitrate(_lame!, bitrate);
  void setLameQuality(int quality) => lameSetQuality(_lame!, quality);
  void setLameVBR(int vbrMode) => lameSetVBR(_lame!, vbrMode);
  void initLameParams() => lameInitParams(_lame!);

  // === Encoding PCM to MP3 ===
  Uint8List encodeBuffer(List<int> left, List<int> right) {
    final nsamples = left.length;
    final mp3BufferSize = (1.25 * nsamples + 7200).toInt();
    final mp3Buffer = malloc<Uint8>(mp3BufferSize);

    final leftPtr = malloc<Int16>(nsamples);
    final rightPtr = malloc<Int16>(nsamples);

    for (var i = 0; i < nsamples; i++) {
      leftPtr[i] = left[i].toSigned(16);
      rightPtr[i] = right[i].toSigned(16);
    }

    final encodedBytes = lameEncodeBuffer(
      _lame!,
      leftPtr,
      rightPtr,
      nsamples,
      mp3Buffer,
      mp3BufferSize,
    );

    final result = mp3Buffer.asTypedList(encodedBytes).toList();

    malloc.free(leftPtr);
    malloc.free(rightPtr);
    malloc.free(mp3Buffer);

    return Uint8List.fromList(result);
  }

  Uint8List flushLame() {
    final mp3BufferSize = 7200; // LAME recommended flush buffer
    final mp3Buffer = malloc<Uint8>(mp3BufferSize);

    final encodedBytes = lameEncodeFlush(_lame!, mp3Buffer, mp3BufferSize);

    final result = mp3Buffer.asTypedList(encodedBytes).toList();
    malloc.free(mp3Buffer);

    return Uint8List.fromList(result);
  }

  // === Streaming MP3 to Shout ===
  int send(Uint8List mp3Data) {
    final buffer = malloc<Uint8>(mp3Data.length);
    buffer.asTypedList(mp3Data.length).setAll(0, mp3Data);
    final result = shoutSend(_shout!, buffer, mp3Data.length);
    malloc.free(buffer);
    return result;
  }

  // === Convenience: Encode PCM and send ===
  int encodeAndSend(List<int> left, List<int> right) {
    final mp3 = encodeBuffer(left, right);
    return send(mp3);
  }
}
