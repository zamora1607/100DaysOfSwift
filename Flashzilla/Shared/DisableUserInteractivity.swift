//
//  DisableUserInteractivity.swift
//  Flashzilla (iOS)
//
//  Created by Ania on 03/01/2021.
//

import SwiftUI

struct DisableUserInteractivity: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)
                    .onTapGesture {
                        print("Rectangle tapped")
                    }
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        print("Circle tapped")
                    }
                //.allowsHitTesting(false)
            }
            VStack {
                Text("hello")
                Spacer().frame(height:100)
                Text("World")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                print("Vstack tapped")
            }
        }
    }
}

struct DisableUserInteractivity_Previews: PreviewProvider {
    static var previews: some View {
        DisableUserInteractivity()
    }
}
