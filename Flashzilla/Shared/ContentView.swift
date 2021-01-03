//
//  ContentView.swift
//  Shared
//
//  Created by Ania on 03/01/2021.
//

import SwiftUI

struct ContentView: View { //Gestures 
    
//    @State private var currentAmount: CGFloat = 0
//    @State private var finalAmount: CGFloat = 1
//
//    @State private var currentAmountRotation: Angle = .degrees(0)
//    @State private var finalAmountRotation: Angle = .degrees(0)
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        
        let dragGesture = DragGesture()
            .onChanged{ value in self.offset = value.translation }
            .onEnded{ _ in
                withAnimation {
                    self.offset = .zero
                    self.isDragging = false
                }
            }
        
            let pressGesture = LongPressGesture()
                .onEnded { value in
                    withAnimation {
                        self.isDragging = true
                    }
                }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
//        VStack {
//            Text("Hello world!")
//                .onTapGesture {
//                    print("text tapped")
//                }
//        }
////        .highPriorityGesture(
//        .simultaneousGesture(
//            TapGesture()
//                .onEnded({ _ in
//                    print("Vstack tapped")
//                })
//        )
   
        
        
//        Text("Hello, world!")
//            .scaleEffect(finalAmount + currentAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged({ (amount) in
//                        self.currentAmount = amount - 1
//                    })
//                    .onEnded({ (amount) in
//                        self.finalAmount += self.currentAmount
//                        self.currentAmount = 0
//                    })
//            )
//            .rotationEffect(currentAmountRotation + finalAmountRotation)
//            .gesture(
//                RotationGesture()
//                    .onChanged({ angle in
//                        self.currentAmountRotation = angle
//                    })
//                    .onEnded({ angle in
//                        self.finalAmountRotation += self.currentAmountRotation
//                        self.currentAmountRotation = .degrees(0)
//                    })
//            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
