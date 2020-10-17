//
//  WrapUp.swift
//  Drawing
//
//  Created by Ania on 17/10/2020.
//

import SwiftUI

struct WrapUpView: View {
    @State private var thickness: CGFloat = 8
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Arrow(thickness: thickness)
                .frame(width: 300, height: 150, alignment: .center)
            
            Spacer()
            
            Slider(value: $thickness, in: 1...20, step:1)
                .padding([.horizontal, .bottom])
        }
    }
}

struct Arrow: Shape {
    var thickness: CGFloat = 8
    
    var animatableData: CGFloat {
        get { thickness }
        set { self.thickness = newValue }
    }
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let thick = rect.maxY/thickness
        let stemLong = rect.maxX - rect.maxX/6
        let arrowEnd = rect.maxX + thickness * 2 - rect.maxX/9
        let arrowWidth = thick * 0.75
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addRect(CGRect(x: CGFloat.zero, y: rect.maxY/2, width: stemLong, height: thick))
        path.move(to: CGPoint(x: stemLong, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: stemLong, y: rect.maxY/2 - arrowWidth))
        path.addLine(to: CGPoint(x:arrowEnd, y: rect.maxY/2 + thick/2))
        path.addLine(to: CGPoint(x: stemLong, y: rect.maxY/2 + arrowWidth + thick))
        
        return path
    }
    

}

struct WrapUp_Previews: PreviewProvider {
    static var previews: some View {
        WrapUpView()
    }
}
