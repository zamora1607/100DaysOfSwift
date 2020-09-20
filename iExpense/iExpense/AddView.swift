//
//  AddView.swift
//  iExpense
//
//  Created by Ania on 16/08/2020.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: String = ""
    @State private var showingAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("name: ", text: $name)
                Picker("type:", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("amount: ", text: $amount)
                    .keyboardType(.numberPad)
            }.navigationTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(amount) {
                    let expense = ExpenseItem(name: name, type: type, amount: actualAmount)
                    self.expenses.items.append(expense)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    self.showingAlert = true
                }
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Amount value incorrect"), dismissButton: .cancel(Text("OK")))
            }
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
