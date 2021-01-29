#import "ClipboardImagePlugin.h"
#if __has_include(<clipboard_image/clipboard_image-Swift.h>)
#import <clipboard_image/clipboard_image-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "clipboard_image-Swift.h"
#endif

@implementation ClipboardImagePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftClipboardImagePlugin registerWithRegistrar:registrar];
}
@end
