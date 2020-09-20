//
//  ContentView.swift
//  iExpense
//
//  Created by Ania on 16/08/2020.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items) {
                UserDefaults.standard.setValue(data, forKey: "items")
            }
        }
    }
    
    init () {
        if let items = UserDefaults.standard.data(forKey: "items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("PLN \(item.amount)")
                            .fontWeight(.bold)
                            .foregroundColor(colorLabel(amount: item.amount))
                        
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("Expenses")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                showingAddExpense = true
            }) {
                Image(systemName: "plus")
            })
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func colorLabel(amount: Int) -> Color {
        if amount <= 10 {
            return Color.green
        } else if amount <= 100 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    
    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
