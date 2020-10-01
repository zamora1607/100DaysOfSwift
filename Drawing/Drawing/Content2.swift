//
//  Content2.swift
//  Drawing
//
//  Created by Ania on 28/09/2020.
//

import SwiftUI

struct Content2: View {
    @State private var amount: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .saturation(Double(amount))
                    .blur(radius: (1 - amount) * 20)
                
                Spacer()
                
                Circle()
                    .fill(Color(red: 1, green: 0, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 1, blue: 0))
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(.screen)
                
                Circle()
                    .fill(Color(red: 0, green: 0, blue: 1))
                    .frame(width: 200 * amount)
                    .blendMode(.screen)
                
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct Content2_Previews: PreviewProvider {
    static var previews: some View {
        Content2()
    }
}
