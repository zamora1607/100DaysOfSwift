//
//  ContentView.swift
//  Shared
//
//  Created by Ania on 30/12/2020.
//

import SwiftUI
import UserNotifications
import SamplePackage


struct ContentView: View {
    
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

//struct ContentView: View {
//
//    @State private var backgroundColor = Color.red
//
//    var body: some View {
//        VStack {
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
//                    if success {
//                        print("All set")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//            .padding()
//            Button("Schedule notification") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cat"
//                content.subtitle = "It looks hungry"
//                content.sound = UNNotificationSound.default
//
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                UNUserNotificationCenter.current().add(request)
//            }
//            .padding()
//            Spacer()
//            Text("Henlo world!")
//                .padding()
//                .background(backgroundColor)
//            Text("Change color")
//                .padding()
//                .contextMenu{
//                    Button(action: {
//                        self.backgroundColor = .red
//                    }) {
//                        Text("Red")
//                        Image(systemName: "checkmark.circle.fill")
//                    }
//                    Button(action: {
//                        self.backgroundColor = .green
//                    }) {
//                        Text("Green")
//                    }
//                    Button(action: {
//                        self.backgroundColor = .blue
//                    }) {
//                        Text("Blue")
//                    }
//                }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
