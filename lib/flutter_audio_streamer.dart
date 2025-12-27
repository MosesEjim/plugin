import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'src/libshout_bindings.dart';

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
  void connect() {
    final result = _lib.shout_open(_shout);
    if (result != SHOUTERR_SUCCESS) {
      final error = _lib.shout_get_error(_shout).cast<Utf8>().toDartString();
      throw Exception('Failed to connect: $error');
    }
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
       throw Exception('Failed to send data: $error');
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
