import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'hid_activity_macos_method_channel.dart';

abstract class HidActivityMacosPlatform extends PlatformInterface {
  /// Constructs a HidActivityMacosPlatform.
  HidActivityMacosPlatform() : super(token: _token);

  static final Object _token = Object();

  static HidActivityMacosPlatform _instance = MethodChannelHidActivityMacos();

  /// The default instance of [HidActivityMacosPlatform] to use.
  ///
  /// Defaults to [MethodChannelHidActivityMacos].
  static HidActivityMacosPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [HidActivityMacosPlatform] when
  /// they register themselves.
  static set instance(HidActivityMacosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<String> get getActivityStream {
    throw UnimplementedError('getActivityStream has not been implemented.');
  }
}
