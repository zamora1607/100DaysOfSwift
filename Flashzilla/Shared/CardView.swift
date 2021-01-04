//
//  CardView.swift
//  Flashzilla
//
//  Created by Ania on 04/01/2021.
//

import SwiftUI

struct CardView: View {
    
    let card: Card
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
        DragGesture()
            .onChanged{ gesture in
                self.offset = gesture.translation
            }
            
            .onEnded { _ in
                if abs(self.offset.width) > 100 {
                    self.removal?()
                } else {
                    self.offset = .zero
                }
            }
        )
        .onTapGesture {
            self.isShowingAnswer = true
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: Card.example)
            CardView(card: Card.example)
        }
    }
}
