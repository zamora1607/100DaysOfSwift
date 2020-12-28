//
//  ContentView.swift
//  BetterRest
//
//  Created by Ania on 27/07/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    
    private let hoursOfSleep = Array(stride(from: 4, through: 12, by: 0.25))
    
    var body: some View {
        NavigationView {
            Form {
                Text("Recommended bedtime: \(recommendedBedtime)")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Section(header: Text("When do you want to wake up?")){
                    DatePicker("Please enter time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Desired amount of sleep")) {
                    Picker(selection: $sleepAmount, label: Text("Desired amount of sleep")) {
                        ForEach(hoursOfSleep, id: \.self) {
                            Text("\($0, specifier: "%g") hours")
                        }
                    }.pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                    
                }
                Section(header: Text("Daily coffe intake")) {
                    Stepper(value: $coffeAmount, in: 1...20) {
                        if coffeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeAmount) cups")
                        }
                    }
                    .accessibility(label: Text("\(coffeAmount) cups of coffe"))
                }
            }.navigationTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var recommendedBedtime: String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute  ?? 0) * 60
        
        do {
            let predition = try model.prediction(wake: Double(hour+minutes), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            let sleepTime = wakeUp - predition.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            return "??"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
