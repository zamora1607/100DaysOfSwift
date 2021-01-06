//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Ania on 06/01/2021.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var tryAgain = false
    
    var body: some View {
        Form {
            Toggle("Try again if your answer is wrong", isOn: $tryAgain)
        }
        .navigationBarTitle("Settings")
        .navigationBarItems(trailing: Button("Done", action: dismiss))
        .onAppear(perform: loadValue)
    }
    
    func dismiss() {
        saveValue()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func loadValue() {
        let data = UserDefaults.standard.bool(forKey: "TryAgain")
        self.tryAgain = data
    }
    
    func saveValue() {
        UserDefaults.standard.set(self.tryAgain, forKey: "TryAgain")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
