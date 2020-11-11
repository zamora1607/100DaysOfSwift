//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ania on 08/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.details.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.details.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.details.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.details.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.details.specialRequestEnabled {
                        Toggle(isOn: $order.details.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.details.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake order")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(order: OrderWrapper())
    }
}
