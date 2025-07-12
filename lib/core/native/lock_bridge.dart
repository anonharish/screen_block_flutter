import 'package:flutter/services.dart';

class LockBridge {
  static const _channel = MethodChannel('focusdroid/lock');

  static Future<void> openUsageAccessSettings() async {
    try {
      await _channel.invokeMethod('openUsageAccessSettings');
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
  }
}
