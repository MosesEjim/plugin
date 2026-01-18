import Flutter
import UIKit

// Forward declarations for wrapper functions (defined in shout_wrapper.c and lame_wrapper.c)
// Using wrapper function names to avoid ambiguity with library symbols

@_silgen_name("shout_init_wrapper")
func shout_init_wrapper() -> Int32

@_silgen_name("shout_new_wrapper")
func shout_new_wrapper() -> UnsafeMutableRawPointer?

@_silgen_name("lame_init_wrapper")
func lame_init_wrapper() -> UnsafeMutableRawPointer?

public class FlutterAudioStreamerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        // This is an FFI-only plugin, but we need a dummy registration
        // to ensure the static libraries are linked into the app
        
        // Force a reference to the wrapper functions to prevent dead-code stripping
        // These wrappers call into libshout and liblame, ensuring those libraries are linked
        _ = shout_init_wrapper
        _ = shout_new_wrapper
        _ = lame_init_wrapper
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // FFI-only plugin - no method channel handling needed
        result(FlutterMethodNotImplemented)
    }
}
