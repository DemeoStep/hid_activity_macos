import Cocoa
import FlutterMacOS

public class HidActivityMacosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let activityChannel = FlutterEventChannel(name: "hid_activity_macos", binaryMessenger: registrar.messenger)
        let activityStreamHandler = ActivityStreamHandler()
            activityChannel.setStreamHandler(activityStreamHandler)
  }
}
