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
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffe intake")
                        .font(.headline)
                    Stepper(value: $coffeAmount, in: 1...20) {
                        if coffeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeAmount) cups")
                        }
                    }
                }
            }.navigationTitle("BetterRest")
            .navigationBarItems(trailing:
                                    Button(action: calculateBedTime, label: {
                                        Text("Calculate")
                                    }))
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedTime() {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute  ?? 0) * 60
        
        do {
            let predition = try model.prediction(wake: Double(hour+minutes), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            let sleepTime = wakeUp - predition.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is"
        } catch {
            alertTitle = "Error"
            alertMessage = "We cannot calculate your bedtime"
        }
        
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
