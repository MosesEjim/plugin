import Flutter
import UIKit

// Forward declaration for linker anchor function (defined in shout_wrapper.c)
// This unique function name avoids conflicts with C header declarations
@_silgen_name("flutter_audio_streamer_force_link")
func flutter_audio_streamer_force_link() -> Int32

public class FlutterAudioStreamerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        // This is an FFI-only plugin, but we need a dummy registration
        // to ensure the static libraries are linked into the app
        
        // Force a reference to prevent dead-code stripping of the entire plugin
        // This anchor function references shout/lame symbols internally
        _ = flutter_audio_streamer_force_link
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        // FFI-only plugin - no method channel handling needed
        result(FlutterMethodNotImplemented)
    }
}
