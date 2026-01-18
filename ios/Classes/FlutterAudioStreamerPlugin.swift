import Flutter
import UIKit

// Forward declarations for C functions to ensure they get linked
@_silgen_name("shout_init")
func shout_init()

@_silgen_name("shout_new")
func shout_new() -> UnsafeMutableRawPointer?

@_silgen_name("lame_init")
func lame_init() -> UnsafeMutableRawPointer?

public class FlutterAudioStreamerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        // This is an FFI-only plugin, but we need a dummy registration
        // to ensure the static libraries are linked into the app
        
        // Force a reference to the C functions to prevent dead-code stripping
        _ = shout_init
        _ = shout_new
        _ = lame_init
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // FFI-only plugin - no method channel handling needed
        result(FlutterMethodNotImplemented)
    }
}
