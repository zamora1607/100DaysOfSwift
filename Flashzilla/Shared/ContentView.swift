//
//  ContentView.swift
//  Shared
//
//  Created by Ania on 03/01/2021.
//

import SwiftUI

struct ContentView: View {
    
//    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
//    @State private var counter = 0
 
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale: CGFloat = 1
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Text("Transparency")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
        
/*
        Text("Hello world")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    self.scale *= 1.5
                }
            }
*/
        
/*
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? Color.black : Color.green)
        .foregroundColor(.white)
        .clipShape(Capsule())
 */
/*
        Text("example")
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                print("Moving to the background")
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification), perform: { _ in
                print("screenshot")
            })
            .onReceive(timer, perform: { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                self.counter += 1
            })
 */
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
