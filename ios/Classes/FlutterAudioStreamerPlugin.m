#import "FlutterAudioStreamerPlugin.h"

@implementation FlutterAudioStreamerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  // This is a dummy registration to ensure the plugin is linked on iOS.
  // FFI symbols are resolved via DynamicLibrary.process() which requires
  // the symbols to be present in the main executable or loaded frameworks.
}
@end
