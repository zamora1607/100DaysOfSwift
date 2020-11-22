//
//  AddActivityView.swift
//  challenge-habit-tracking
//
//  Created by Ania on 22/11/2020.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities

    @State private var showingError = false
    
    @State private var name: String = ""
    @State private var type: String = "sport"
    @State private var ammount: Int = 0
    
    static let types = ["sport", "ritual", "eating"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name: ", text: $name)
                    Picker("Type: ", selection: $type) {
                        ForEach(Self.types, id: \.self) {
                            Text($0)
                        }
                    }
                    Stepper("Ammount \t \(self.ammount)", value: $ammount)
                }
            }
            .navigationBarTitle("New Activity")
            .navigationBarItems(trailing: Button("Save") {
                if !name.isEmpty {
                    let activity = ActivityItem(name: name, type: type, ammount: ammount)
                    self.activities.items.append(activity)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingError = true
                }
            }.alert(isPresented: $showingError, content: {
                Alert(title: Text("Error occured"), message: Text("Name cannot be empty"), dismissButton: .default(Text("OK")))
            }))
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
