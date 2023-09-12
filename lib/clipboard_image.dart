import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/services.dart';

class ClipboardImage {
  static const MethodChannel _channel = const MethodChannel('clipboard_image');

  static Future<String> copyImage(String path) async {
    if (Platform.isIOS) {
      final result = await _channel.invokeMethod('copyImage', path);
      return result;
    }

    if (Platform.isAndroid) {
      final data = ClipboardData(text: 'IMAGE:/$path');
      final result = await Clipboard.setData(data).then((value) => path);
      return result;
    }
    throw UnsupportedError("This method only suppor iOS");
  }

  static Future getImage() async {
    if (Platform.isIOS) {
      return _channel.invokeMethod('getImage');
    }
    if (Platform.isAndroid) {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData != null) {
        return clipboardData.text;
      }
      return null;
    }
    throw UnsupportedError("This method only suppor iOS");
  }

  static Future clearClipboardImage() async {
    Clipboard.setData(ClipboardData(text: ""));
  }
}
