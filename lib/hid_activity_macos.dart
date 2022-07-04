
import 'hid_activity_macos_platform_interface.dart';

class HidActivityMacos {
  Stream<String> get getActivityStream {
    return HidActivityMacosPlatform.instance.getActivityStream;
  }
}
