//
//  ContentView.swift
//  Drawing
//
//  Created by Ania on 26/09/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: self.colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
        }
//        VStack {
//        Text("Hello world")
//            .frame(width: 300, height: 300)
//            .border(ImagePaint(image: Image("cupcakes"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
//
//            Capsule()
//                .strokeBorder(ImagePaint(image: Image("cupcakes"), scale: 0.1), lineWidth: 20)
//                .frame(width: 300, height: 300)
//        }
        
        
//        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .fill(Color.red, style: FillStyle(eoFill: true, antialiased: true))
//
//            Text("Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
//        }
    }
    
    struct Arc: InsettableShape {
        var insetAmount: CGFloat = 0
        var startAngle: Angle
        var endAngle: Angle
        var clockwise: Bool
        
        func path(in rect: CGRect) -> Path {
            let rotationAdjustment = Angle.degrees(90)
            let modifiedStart = startAngle - rotationAdjustment
            let modifiedEnd = endAngle - rotationAdjustment
            
            var path = Path()
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
            
            return path
        }
        
        func inset(by amount: CGFloat) -> some InsettableShape {
            var arc = self
            arc.insetAmount += amount
            return arc
        }
    }
    
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            
            return path
        }
    }
    
    struct Flower: Shape {
        // How much to move this petal away from the center
        var petalOffset: Double = -20
        
        // How wide to make each petal
        var petalWidth: Double = 100
        
        func path(in rect: CGRect) -> Path {
            // The path that will hold all petals
            var path = Path()
            
            // Count from 0 up to pi * 2, moving up pi / 8 each time
            for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi/8) {
                // rotate the petal by the current value of our loop
                let rotation = CGAffineTransform(rotationAngle: number)
                
                //move the petal to be at the center of our view
                let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
                
                // create a path for this petal using our properties plus a fixed Y and height
                let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
                
                // apply our rotation/position transformation to the petal
                let rotatedPetal = originalPetal.applying(position)
                
                // add it to our main path
                path.addPath(rotatedPetal)
            }
            
            return path
        }
    }
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
