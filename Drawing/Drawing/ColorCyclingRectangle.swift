//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Ania on 17/10/2020.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorRectangle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
    }
}

struct ColorRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [self.color(for: value, brightness: 1), self.color(for: value, brightness: 0.5)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
                
            }
        }
        .drawingGroup()
//        This tells SwiftUI it should render the contents of the view into an off-screen image before putting it back onto the screen as a single rendered output, which is signficantly faster.
    }
    
    func color(for value: Int, brightness:Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangle()
    }
}
