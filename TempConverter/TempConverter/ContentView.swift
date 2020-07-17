//
//  ContentView.swift
//  TempConverter
//
//  Created by Ania on 17/07/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var startDegrees = "0.0"
    @State private var startScale = 0
    @State private var finalScale = 1
    
    var finalDegrees: Measurement<UnitTemperature> {
        var startValue: Measurement<UnitTemperature>?
        
        switch startScale {
        case 0:
            startValue = Measurement(value: Double(startDegrees) ?? 0.0, unit: UnitTemperature.celsius)
        case 1:
            startValue = Measurement(value: Double(startDegrees) ?? 0.0, unit: UnitTemperature.fahrenheit)
        default:
            startValue = Measurement(value: Double(startDegrees) ?? 0.0, unit: UnitTemperature.kelvin)
        }
        
        switch finalScale {
        case 0:
            return startValue!.converted(to: UnitTemperature.celsius)
        case 1:
            return startValue!.converted(to: UnitTemperature.fahrenheit)
        default:
            return startValue!.converted(to: UnitTemperature.kelvin)
        }
    }
    
    let scales = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter degress:") ) {
                    HStack {
                        TextField("degress", text: $startDegrees)
                            .keyboardType(.decimalPad)
                        Button("OK") {
                            self.hideKeyboard()
                        }
                    }
                    Picker("Start scale", selection: $startScale) {
                        ForEach(0 ..< scales.count) {
                            Text("\(scales[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(finalDegrees.value, specifier: "%.2f")")
                    Picker("Final scale", selection: $finalScale) {
                        ForEach(0 ..< scales.count) {
                            Text("\(scales[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }.navigationBarTitle(" Temp Converter")
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
