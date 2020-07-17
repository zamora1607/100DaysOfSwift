//
//  ContentView.swift
//  WeSplit
//
//  Created by Ania on 17/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    // text field can store only string
    @State private var checkAmmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var total: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return total / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Ammount", text: $checkAmmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip ammount", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total ammount")) {
                    Text("$\(total, specifier: "%.2f")")
                }
                Section(header: Text("Ammount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
