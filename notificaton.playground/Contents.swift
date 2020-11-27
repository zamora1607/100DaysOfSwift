import UIKit
import PlaygroundSupport

extension Notification.Name {
    static let HWSSettingsDidChange = Notification.Name("HWSSettingsDidChangeNotification")
}

class Controller {
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSettings), name: .HWSSettingsDidChange, object: self)
    }
    
    @objc func reloadSettings(note: Notification) {
        print("Reloading settings")
        if let userInfo = note.userInfo {
            print(userInfo)
        }
    }
}

let controller = Controller()
print("before")
NotificationCenter.default.post(name: .HWSSettingsDidChange, object: nil, userInfo: ["theme" : "dark"])
//let notification = Notification(name: .HWSSettingsDidChange)
//NotificationQueue.default.enqueue(notification, postingStyle: .whenIdle, coalesceMask: .none, forModes: nil)
//PlaygroundPage.current.needsIndefiniteExecution = true
print("then")

