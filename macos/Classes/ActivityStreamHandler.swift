import Foundation
import FlutterMacOS

class ActivityStreamHandler: NSObject, FlutterStreamHandler{
    var sink: FlutterEventSink?

    var timer: Timer?

    //TODO Check permissions periodically until not granted
    
    let accessEnabled = AXIsProcessTrustedWithOptions(
    [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary)


    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        sink = events
        
        if accessEnabled != true {
                    sink!("You need to enable the keylogger in the System Prefrences")
        } else {

        NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.any, handler: { [self](event: NSEvent) in
            do {
                let arr = event.description.components(separatedBy: " ")
                
                switch arr[1] {
                case ("type=KeyDown"):
                    sink!("Keyboard key pressed")
                case ("type=KeyUp"):
                    sink!("Keyboard key pressed")
                case ("type=SysDefined"):
                    sink!("Keyboard key pressed")
                default:
                    sink!("Mouse activity")
                }
            
            
        }
            
        })
        
        NSEvent.addLocalMonitorForEvents(matching: NSEvent.EventTypeMask.any, handler: { [self](event: NSEvent) in
            do {
                let arr = event.description.components(separatedBy: " ")
                
                switch arr[1] {
                case "type=KeyDown":
                    sink!("Keyboard key pressed")
                case ("type=KeyUp"):
                    sink!("Keyboard key pressed")
                case ("type=SysDefined"):
                    sink!("Keyboard key pressed")
                default:
                    sink!("Mouse activity")
                    //sink!("\(arr[1])")
                }
            
            
        }
            return event
            
        })
        }
        
        
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        timer?.invalidate()
        return nil
    }
}
