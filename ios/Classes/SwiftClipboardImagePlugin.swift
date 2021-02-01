import Flutter
import UIKit

public class SwiftClipboardImagePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "clipboard_image", binaryMessenger: registrar.messenger())
    let instance = SwiftClipboardImagePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "copyImage":
        copyImage(call, result: result)
    default:
        result(FlutterMethodNotImplemented)
    }
    
  }

  public func copyImage(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let path = call.arguments as! String
    if FileManager.default.fileExists(atPath: path) {
        do {
            let url = URL.init(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            UIPasteboard.general.items = []
            UIPasteboard.general.image = image
            result("Image copied")
        } catch {
            result("Unable to lo  ad data: \(error)")
        }
    }
  }
}
