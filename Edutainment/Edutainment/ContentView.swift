//
//  ContentView.swift
//  Edutainment
//
//  Created by Ania on 10/08/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var multiplicationTable = 1
    @State private var selectedNumberOfQuestions = 0
    let numbersOfQuestions = [5, 10, 100]
    
    var body: some View {
        VStack {
            Text("Practise multiplication for number:")
            Stepper(value: $multiplicationTable, in: 1...12) {
                Text("\(multiplicationTable)")
            }.padding(.all, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .frame(width: 150, height: 70, alignment: .center)
            .background(Color.yellow)
            
            Picker(selection: $selectedNumberOfQuestions, label: Text("Number of questions")) {
                ForEach(numbersOfQuestions, id: \.self) {
                    Text("\($0) questions")
                }
            }.pickerStyle(SegmentedPickerStyle())
            .labelsHidden()
        }
    }
    
    func selectNumberOfQuestions() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
