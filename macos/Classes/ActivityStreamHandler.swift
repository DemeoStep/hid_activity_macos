import Foundation
import FlutterMacOS
import AppKit

class ActivityStreamHandler: NSObject, FlutterStreamHandler{
    var sink: FlutterEventSink?
    var timer: Timer?
    
    func startMonitors() {
        NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.any, handler: { [self](event: NSEvent) in
                do {
                    let arr = event.description.components(separatedBy: " ")
                    sink!("\(arr[1])")
                    
//                    switch arr[1] {
//                    case ("type=KeyDown"):
//                        sink!("Keyboard key pressed")
//                    case ("type=KeyUp"):
//                        sink!("Keyboard key pressed")
//                    case ("type=SysDefined"):
//                        sink!("Keyboard key pressed")
//                    default:
//                        sink!("Mouse activity")
//                    }
            }
        })
        
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.any, handler: { [self](event: NSEvent) in
                do {
                    let arr = event.description.components(separatedBy: " ")
                    sink!("\(arr[1])")
//                    switch arr[1] {
//                    case "type=KeyDown":
//                        sink!("Keyboard key pressed")
//                    case ("type=KeyUp"):
//                        sink!("Keyboard key pressed")
//                    case ("type=SysDefined"):
//                        sink!("Keyboard key pressed")
//                    default:
//                        sink!("Mouse activity")
//                    }
            }
            
            return event
            
        })
    }

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        sink = events
        
        if(AXIsProcessTrusted() == false) {
            AXIsProcessTrustedWithOptions(
                    [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)
            self.sink!("You must grant Accessibility permissions to this app in the System Preferences")
            if #available(macOS 10.12, *) {
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in
                    if (AXIsProcessTrusted() == true) {
                        timer.invalidate()
                        self.startMonitors()
                    }
                }
            }
        } else {
            startMonitors()
        }
        
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }
}
