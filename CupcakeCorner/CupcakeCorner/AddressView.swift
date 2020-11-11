//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Ania on 08/11/2020.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderWrapper
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text:$order.details.name)
                TextField("Street Address", text: $order.details.streetAddress)
                TextField("City", text: $order.details.city)
                TextField("Zip", text: $order.details.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }.disabled(order.details.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderWrapper())
    }
}
