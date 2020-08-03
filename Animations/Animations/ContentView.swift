//
//  ContentView.swift
//  Animations
//
//  Created by Ania on 03/08/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount: CGFloat = 1
    @State private var animationAmount2: CGFloat = 1
    @State private var animationAmount3 = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            Button("Tap me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    animationAmount3 += 360
                }
            }.padding(40)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(
                .degrees(animationAmount3),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            
            Spacer()
            
            Stepper("Scale amount", value: $animationAmount2.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)
                .padding(.all, 20)
            
            Spacer()
            
            Button("Tap me") {
                animationAmount2 += 1
            }.padding(.all, 30)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount2)
            
            Spacer()
            
            Button("Tap me") {
                //animationAmount += 1
            }.padding(.all, 50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(Circle()
                        .stroke(Color.red)
                        .scaleEffect(animationAmount)
                        .opacity(Double(2 - animationAmount)))
            .animation(
                Animation.easeOut(duration: 2)
                    .repeatForever(autoreverses: false)
            )
            .onAppear {
                self.animationAmount = 2
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
