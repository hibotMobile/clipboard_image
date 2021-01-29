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
    throw UnsupportedError("This method only suppor iOS");
  }
}
