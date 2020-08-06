//
//  ContentView2.swift
//  Animations
//
//  Created by Ania on 06/08/2020.
//

import SwiftUI

struct ContentView2: View {
    
    @State private var enabled = false
    
    var body: some View {
        Button("Tap me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200, alignment: .center)
        .background(enabled ? Color.blue : Color.red)
        .animation(.default)
        .foregroundColor(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0, style: .continuous))
        .animation(.interpolatingSpring(stiffness: 15, damping: 1))
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
