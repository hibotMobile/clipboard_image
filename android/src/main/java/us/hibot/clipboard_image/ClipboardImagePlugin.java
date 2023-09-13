package us.hibot.clipboard_image;

import androidx.annotation.NonNull;
import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;


/** ClipboardImagePlugin */
public class ClipboardImagePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context applicationContext;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "clipboard_image");
    channel.setMethodCallHandler(this);
    applicationContext = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "copyImage":
        String imagePath = call.arguments();
        String resultImg = copyImageToClipboard(imagePath);
        result.success(resultImg);
        break;
      case "getImage":
        String clipboardImage = getImageFromClipboard();
        result.success(clipboardImage);
        break;
      case "clearClipboardImage":
        clearClipboardImage();
        result.success(null);
        break;
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
      default:
        result.notImplemented();
        break;
    }
  }

  private String copyImageToClipboard(String imagePath) {
    ClipboardManager clipboardManager = (ClipboardManager) applicationContext.getSystemService(Context.CLIPBOARD_SERVICE);
    ClipData clipData = ClipData.newPlainText("IMAGE", "IMAGE:" + imagePath);
    clipboardManager.setPrimaryClip(clipData);
    return imagePath;
  }


  private String getImageFromClipboard() {
    ClipboardManager clipboardManager = (ClipboardManager) applicationContext.getSystemService(Context.CLIPBOARD_SERVICE);
    ClipData clipData = clipboardManager.getPrimaryClip();

    if (clipData != null && clipData.getItemCount() > 0) {
      String text = clipData.getItemAt(0).getText().toString();
      return text;
    }
    return null;
  }

  private void clearClipboardImage() {
    ClipboardManager clipboardManager = (ClipboardManager) applicationContext.getSystemService(Context.CLIPBOARD_SERVICE);
    ClipData clipData = ClipData.newPlainText(null, "");
    clipboardManager.setPrimaryClip(clipData);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
