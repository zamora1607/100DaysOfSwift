//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Ania on 08/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
                        dimension[VerticalAlignment.bottom]
                    })
                Image("cupcakes")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            
            VStack {
                Text("Full name:")
                Text("Paul Hudson")
                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
                        dimension[VerticalAlignment.bottom]
                    })
                    .font(.largeTitle)
            }
        }
    }
    
    
//    var body: some View {
//        VStack(alignment: .leading) {
//            ForEach(0..<10) { position in
//                Text("Number \(position)")
//                    .alignmentGuide(.leading, computeValue: { _ in
//                        CGFloat(position) * -10
//                    })
//            }
//        }
//        .background(Color.red)
//        .frame(width: 400, height: 400)
//        .background(Color.blue)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
