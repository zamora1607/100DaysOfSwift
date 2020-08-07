//
//  Gestures.swift
//  Animations
//
//  Created by Ania on 07/08/2020.
//

import SwiftUI

struct CornerRotateModifier : ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct Gestures: View {
    
    @State private var dragAmmount = CGSize.zero
    @State private var dragAmmountLetters = CGSize.zero
    @State private var enabled = false
    let letters = Array("Hello Swift")
    
    @State private var isShowingGreen = false
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .offset(dragAmmount)
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.dragAmmount = $0.translation
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                self.dragAmmount = .zero
                            }
                        }
                )
            HStack {
                ForEach(0..<letters.count) {
                    num in
                    Text(String(letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(enabled ? Color.red : Color.blue)
                        .offset(dragAmmountLetters)
                        .animation(Animation.default.delay(Double(num)/20))
                }
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.dragAmmountLetters = $0.translation
                        }
                        .onEnded { _ in
                            self.dragAmmountLetters = .zero
                            self.enabled.toggle()
                        }
                )
            }
            VStack {
                Button("Tap Me") {
                    withAnimation {
                        self.isShowingGreen.toggle()
                    }
                }.padding(15)
                
                if isShowingGreen {
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
        }
    }
}

struct Gestures_Previews: PreviewProvider {
    static var previews: some View {
        Gestures()
    }
}
