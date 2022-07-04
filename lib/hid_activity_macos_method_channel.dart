import 'package:flutter/services.dart';

import 'hid_activity_macos_platform_interface.dart';

/// An implementation of [HidActivityMacosPlatform] that uses method channels.
class MethodChannelHidActivityMacos extends HidActivityMacosPlatform {
  /// The method channel used to interact with the native platform.
  final EventChannel _mouseActivityChannel = const EventChannel('hid_activity_macos');

  @override
  Stream<String> get getActivityStream {
    return _mouseActivityChannel.receiveBroadcastStream().cast();
  }
}
