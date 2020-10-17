//
//  TabBarView.swift
//  Drawing
//
//  Created by Ania on 17/10/2020.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            SpirographView()
                .tabItem{
                    Image(systemName: "mappin.circle.fill")
                    Text("Spirograph")
                }
            
            WrapUpView()
                .tabItem{
                    Image(systemName: "mappin.circle")
                    Text("WrapUp")
                }
            
            ComplexAnimation()
                .tabItem{
                    Image(systemName: "mappin.circle.fill")
                    Text("Chessboard")
                }
            
            ContentView()
                .tabItem{
                    Image(systemName: "mappin.circle")
                    Text("Circle")
                }
            
            Content2()
                .tabItem{
                    Image(systemName: "mappin.circle.fill")
                    Text("Blending")
                }
            
            AnimatingShapes()
                .tabItem{
                    Image(systemName: "mappin.circle")
                    Text("Trapeze")
                }
            
            ColorCyclingRectangle()
                .tabItem{
                    Image(systemName: "mappin.circle.fill")
                    Text("Color Rectangle")
                }
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
