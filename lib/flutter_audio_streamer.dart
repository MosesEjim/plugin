import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'src/libshout_bindings.dart';
import 'src/lame_bindings.dart';

class Shout {
  late LibShout _lib;
  Pointer<shout_t> _shout = nullptr;

  Shout() {
    try {
      if (Platform.isIOS) {
        print('Platform: iOS (Static/Process)');
        final dylib = DynamicLibrary.process();
        _lib = LibShout(dylib);
      } else if (Platform.isAndroid) {
        print('Platform: Android (libshout.so)');
        final dylib = DynamicLibrary.open('libshout.so');
        _lib = LibShout(dylib);
      } else if (Platform.isMacOS) {
        print('Platform: macOS (libshout.dylib)');
        // Try opening local dylib if running from source/example, or system installed
        try {
           final dylib = DynamicLibrary.open('libshout.dylib');
           _lib = LibShout(dylib);
        } catch (e) {
           print('Failed to open libshout.dylib, trying /usr/local/lib/libshout.dylib');
           final dylib = DynamicLibrary.open('/usr/local/lib/libshout.dylib');
           _lib = LibShout(dylib);
        }
      } else {
        print('Platform: Other (libshout.so fallback)');
        final dylib = DynamicLibrary.open('libshout.so');
        _lib = LibShout(dylib);
      }
      _init();
    } catch (e, stack) {
      print('CRITICAL ERROR during Shout initialization: $e');
      print(stack);
      rethrow;
    }
  }

  void _init() {
    print('Calling shout_init()...');
    _lib.shout_init();
    print('Calling shout_new()...');
    _shout = _lib.shout_new();
    print('Shout instance created: $_shout');
    
    if (_shout == nullptr) {
      throw Exception('Failed to create shout instance (returned nullptr)');
    }
  }

  void dispose() {
    if (_shout != nullptr) {
      _lib.shout_close(_shout);
      _lib.shout_free(_shout);
      _shout = nullptr;
    }
    _lib.shout_shutdown();
  }

  // Connection setters
  set host(String host) {
    final cHost = host.toNativeUtf8();
    _lib.shout_set_host(_shout, cHost.cast());
    calloc.free(cHost);
  }

  set port(int port) {
    _lib.shout_set_port(_shout, port);
  }

  set user(String user) {
    final cUser = user.toNativeUtf8();
    _lib.shout_set_user(_shout, cUser.cast());
    calloc.free(cUser);
  }

  set password(String password) {
    final cPassword = password.toNativeUtf8();
    _lib.shout_set_password(_shout, cPassword.cast());
    calloc.free(cPassword);
  }

  set mount(String mount) {
    final cMount = mount.toNativeUtf8();
    _lib.shout_set_mount(_shout, cMount.cast());
    calloc.free(cMount);
  }

  set protocol(int protocol) {
    _lib.shout_set_protocol(_shout, protocol);
  }

  set format(int format) {
    _lib.shout_set_format(_shout, format);
  }

  // Metadata setters
  set name(String name) {
    final cName = name.toNativeUtf8();
    _lib.shout_set_name(_shout, cName.cast());
    calloc.free(cName);
  }

  set url(String url) {
    final cUrl = url.toNativeUtf8();
    _lib.shout_set_url(_shout, cUrl.cast());
    calloc.free(cUrl);
  }

  set genre(String genre) {
    final cGenre = genre.toNativeUtf8();
    _lib.shout_set_genre(_shout, cGenre.cast());
    calloc.free(cGenre);
  }

  set description(String description) {
    final cDescription = description.toNativeUtf8();
    _lib.shout_set_description(_shout, cDescription.cast());
    calloc.free(cDescription);
  }

  // Actions
  int connect() {
    final result = _lib.shout_open(_shout);
    if (result != SHOUTERR_SUCCESS) {
      final error = _lib.shout_get_error(_shout).cast<Utf8>().toDartString();
      throw Exception('Failed to connect: $error');
    }
    return 0;
  }

  void disconnect() {
    _lib.shout_close(_shout);
  }

  void send(List<int> data) {
    final cData = calloc<UnsignedChar>(data.length);
    final cDataList = cData.cast<Uint8>().asTypedList(data.length);
    cDataList.setAll(0, data);

    final result = _lib.shout_send(_shout, cData, data.length);
    calloc.free(cData);

    if (result != SHOUTERR_SUCCESS) {
       final error = _lib.shout_get_error(_shout).cast<Utf8>().toDartString();
       //throw Exception('Failed to send data: $error');
    }
    
    _lib.shout_sync(_shout);
  }
  
  void setMetadata(String key, String value) {
      final metadata = _lib.shout_metadata_new();
      final cKey = key.toNativeUtf8();
      final cValue = value.toNativeUtf8();
      
      _lib.shout_metadata_add(metadata, cKey.cast(), cValue.cast());
      _lib.shout_set_metadata(_shout, metadata);
      
      _lib.shout_metadata_free(metadata);
      calloc.free(cKey);
      calloc.free(cValue);
  }
}

// Constants for convenience
class ShoutProtocol {
  static const int HTTP = SHOUT_PROTOCOL_HTTP;
  static const int XAUDIOCAST = SHOUT_PROTOCOL_XAUDIOCAST;
  static const int ICY = SHOUT_PROTOCOL_ICY;
}

class ShoutFormat {
  static const int OGG = SHOUT_FORMAT_OGG;
  static const int MP3 = SHOUT_FORMAT_MP3;
}

class Lame {
  late LibLame _lib;
  Pointer<lame_global_flags> _lame = nullptr;

  Lame() {
    try {
      if (Platform.isIOS) {
        final dylib = DynamicLibrary.process();
        _lib = LibLame(dylib);
      } else if (Platform.isAndroid) {
        final dylib = DynamicLibrary.open('libmp3lame.so');
        _lib = LibLame(dylib);
      } else if (Platform.isMacOS) {
        try {
           final dylib = DynamicLibrary.open('libmp3lame.dylib');
           _lib = LibLame(dylib);
        } catch (e) {
           print('Failed to open libmp3lame.dylib, trying /usr/local/lib/libmp3lame.dylib');
           final dylib = DynamicLibrary.open('/usr/local/lib/libmp3lame.dylib');
           _lib = LibLame(dylib);
        }
      } else {
        final dylib = DynamicLibrary.open('libmp3lame.so');
        _lib = LibLame(dylib);
      }
      _init();
    } catch (e, stack) {
      print('CRITICAL ERROR during Lame initialization: $e');
      print(stack);
      rethrow;
    }
  }

  void _init() {
    print('Calling lame_init()...');
    _lame = _lib.lame_init();
    print('Lame instance created: $_lame');
    
    if (_lame == nullptr) {
      throw Exception('Failed to create lame instance (returned nullptr)');
    }
  }

  void close() {
    if (_lame != nullptr) {
      _lib.lame_close(_lame);
      _lame = nullptr;
    }
  }

  // Configuration setters
  set inSamplerate(int rate) {
    _lib.lame_set_in_samplerate(_lame, rate);
  }

  set outSamplerate(int rate) {
    _lib.lame_set_out_samplerate(_lame, rate);
  }

  set bitrate(int bitrate) {
    _lib.lame_set_brate(_lame, bitrate);
  }

  set numChannels(int channels) {
    _lib.lame_set_num_channels(_lame, channels);
  }
  
  set quality(int quality) {
    _lib.lame_set_quality(_lame, quality);
  }

  set mode(int mode) {
    _lib.lame_set_mode(_lame, MPEG_mode_e.fromValue(mode));
  }

  void initParams() {
    final result = _lib.lame_init_params(_lame);
    if (result < 0) {
      throw Exception('Failed to initialize lame params: $result');
    }
  }

List<int> encodeFloat32(Float32List floatSamples) {
  final int numSamples = floatSamples.length;

  final Pointer<Short> pcmBuffer = calloc<Short>(numSamples);

  for (int i = 0; i < numSamples; i++) {
    final double v = floatSamples[i].clamp(-1.0, 1.0);
    pcmBuffer[i] = (v * 32767).round();
  }

  final int mp3BufSize = (1.25 * numSamples + 7200).ceil();
  final Pointer<UnsignedChar> mp3Buf = calloc<UnsignedChar>(mp3BufSize);

  final int bytesEncoded = _lib.lame_encode_buffer(
    _lame,
    pcmBuffer,
    nullptr,
    numSamples,
    mp3Buf,
    mp3BufSize,
  );

  calloc.free(pcmBuffer);

  if (bytesEncoded < 0) {
    calloc.free(mp3Buf);
    throw Exception('LAME encoding failed: $bytesEncoded');
  }

  final output =
      mp3Buf.cast<Uint8>().asTypedList(bytesEncoded).toList();

  calloc.free(mp3Buf);
  return output;
}

  List<int> flush() {
    final int mp3BufSize = 7200; // Safe size for flush
    final Pointer<UnsignedChar> mp3Buf = calloc<UnsignedChar>(mp3BufSize);
    
    final int result = _lib.lame_encode_flush(
      _lame,
      mp3Buf,
      mp3BufSize
    );

    if (result < 0) {
       calloc.free(mp3Buf);
       throw Exception('Lame flush failed: $result');
    }

    final List<int> output = mp3Buf.cast<Uint8>().asTypedList(result).toList();
    calloc.free(mp3Buf);
    
    return output;
  }
}
