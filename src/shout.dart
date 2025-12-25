import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

final DynamicLibrary shoutLib = Platform.isAndroid
    ? DynamicLibrary.open("libshout.so")
    : DynamicLibrary.process();
/**
 * The native functions are called in shout_wrapper.c
 * as {$native_function_name}_wrapper
 */
final String wrapperExtension = Platform.isAndroid?'':'_wrapper';

// shout_init
typedef ShoutInitNative = Int32 Function();
typedef ShoutInit = int Function();
final ShoutInit shoutInit =
    shoutLib.lookup<NativeFunction<ShoutInitNative>>('shout_init$wrapperExtension').asFunction();

// shout_new
typedef ShoutNewNative = Pointer<Void> Function();
typedef ShoutNew = Pointer<Void> Function();
final ShoutNew shoutNew =
    shoutLib.lookup<NativeFunction<ShoutNewNative>>('shout_new$wrapperExtension').asFunction();

// shout_set_host
typedef ShoutSetHostNative = Int32 Function(Pointer<Void>, Pointer<Utf8>);
typedef ShoutSetHost = int Function(Pointer<Void>, Pointer<Utf8>);
final ShoutSetHost shoutSetHost = shoutLib
    .lookup<NativeFunction<ShoutSetHostNative>>('shout_set_host$wrapperExtension')
    .asFunction();

// shout_set_port
typedef ShoutSetPortNative = Int32 Function(Pointer<Void>, Int32);
typedef ShoutSetPort = int Function(Pointer<Void>, int);
final ShoutSetPort shoutSetPort = shoutLib
    .lookup<NativeFunction<ShoutSetPortNative>>('shout_set_port$wrapperExtension')
    .asFunction();

// shout_set_password
typedef ShoutSetPasswordNative = Int32 Function(Pointer<Void>, Pointer<Utf8>);
typedef ShoutSetPassword = int Function(Pointer<Void>, Pointer<Utf8>);
final ShoutSetPassword shoutSetPassword = shoutLib
    .lookup<NativeFunction<ShoutSetPasswordNative>>('shout_set_password$wrapperExtension')
    .asFunction();

// shout_set_mount
typedef ShoutSetMountNative = Int32 Function(Pointer<Void>, Pointer<Utf8>);
typedef ShoutSetMount = int Function(Pointer<Void>, Pointer<Utf8>);
final ShoutSetMount shoutSetMount = shoutLib
    .lookup<NativeFunction<ShoutSetMountNative>>('shout_set_mount$wrapperExtension')
    .asFunction();

// shout_set_protocol
typedef ShoutSetProtocolNative = Int32 Function(Pointer<Void>, Int32);
typedef ShoutSetProtocol = int Function(Pointer<Void>, int);
final ShoutSetProtocol shoutSetProtocol = shoutLib
    .lookup<NativeFunction<ShoutSetProtocolNative>>('shout_set_protocol$wrapperExtension')
    .asFunction();

// shout_set_user
typedef ShoutSetUserNative = Int32 Function(Pointer<Void>, Pointer<Utf8>);
typedef ShoutSetUser = int Function(Pointer<Void>, Pointer<Utf8>);
final ShoutSetUser shoutSetUser = shoutLib
    .lookup<NativeFunction<ShoutSetUserNative>>('shout_set_user$wrapperExtension')
    .asFunction();

// shout_set_format (shout_set_content_format)
typedef ShoutSetFormatNative = Int32 Function(Pointer<Void>, Int32);
typedef ShoutSetFormat = int Function(Pointer<Void>, int);
final ShoutSetFormat shoutSetFormat = shoutLib
    .lookup<NativeFunction<ShoutSetFormatNative>>('shout_set_format$wrapperExtension')
    .asFunction();

// shout_open
typedef ShoutOpenNative = Int32 Function(Pointer<Void>);
typedef ShoutOpen = int Function(Pointer<Void>);
final ShoutOpen shoutOpen =
    shoutLib.lookup<NativeFunction<ShoutOpenNative>>('shout_open$wrapperExtension').asFunction();

// shout_send
typedef ShoutSendNative = Int32 Function(Pointer<Void>, Pointer<Uint8>, Int32);
typedef ShoutSend = int Function(Pointer<Void>, Pointer<Uint8>, int);
final ShoutSend shoutSend =
    shoutLib.lookup<NativeFunction<ShoutSendNative>>('shout_send$wrapperExtension').asFunction();

// shout_get_connected
typedef ShoutGetConnectedNative = Int32 Function(Pointer<Void>);
typedef ShoutGetConnected = int Function(Pointer<Void>);
final ShoutGetConnected shoutGetConnected = shoutLib
    .lookup<NativeFunction<ShoutGetConnectedNative>>('shout_get_connected$wrapperExtension')
    .asFunction();

// shout_set_nonblocking
typedef ShoutSetNonBlockingNative = Int32 Function(Pointer<Void>, Int32);
typedef ShoutSetNonBlocking = int Function(Pointer<Void>, int);

final ShoutSetNonBlocking shoutSetNonBlocking = shoutLib
    .lookup<NativeFunction<ShoutSetNonBlockingNative>>('shout_set_nonblocking$wrapperExtension')
    .asFunction();

// shout_close
typedef ShoutCloseNative = Int32 Function(Pointer<Void>);
typedef ShoutClose = int Function(Pointer<Void>);
final ShoutClose shoutClose = shoutLib
    .lookup<NativeFunction<ShoutCloseNative>>('shout_close$wrapperExtension')
    .asFunction();

typedef ShoutSyncC = Int32 Function(Pointer<Void> shout);
typedef ShoutSync = int Function(Pointer<Void> shout);

final ShoutSync shoutSync =
    shoutLib.lookup<NativeFunction<ShoutSyncC>>('shout_sync$wrapperExtension').asFunction();

// Define a typedef for the C function signature
typedef shout_get_errno_native = Int32 Function(Pointer<Void> shout);

// Define a Dart function that matches the C function signature
typedef ShoutGetErrno = int Function(Pointer<Void> shout);

// Load the function from the shared library
final ShoutGetErrno shoutGetErrno = shoutLib
    .lookup<NativeFunction<shout_get_errno_native>>('shout_get_errno$wrapperExtension')
    .asFunction();

// shout_get_error
typedef ShoutGetErrorNative = Pointer<Utf8> Function(Pointer<Void>);
typedef ShoutGetError = Pointer<Utf8> Function(Pointer<Void>);
final ShoutGetError shoutGetError = shoutLib
    .lookup<NativeFunction<ShoutGetErrorNative>>('shout_get_error$wrapperExtension')
    .asFunction();

// Define the native function signature
typedef ShoutVersionNative = Pointer<Utf8> Function(
    Pointer<Int>, Pointer<Int>, Pointer<Int>);

// Define the Dart function signature
typedef ShoutVersion = Pointer<Utf8> Function(
    Pointer<Int>, Pointer<Int>, Pointer<Int>);

// Lookup and assign the function
final ShoutVersion shoutVersion = shoutLib
    .lookup<NativeFunction<ShoutVersionNative>>('shout_version$wrapperExtension')
    .asFunction();

// Define a typedef for the C function signature
typedef shout_set_tls_native = Void Function(Pointer<Void> shout, Int32 mode);

// Define a Dart function that matches the C function signature
typedef ShoutSetTls = void Function(Pointer<Void> shout, int mode);

// Load the function from the shared library
final ShoutSetTls shoutSetTls = shoutLib
    .lookup<NativeFunction<shout_set_tls_native>>('shout_set_tls$wrapperExtension')
    .asFunction();
