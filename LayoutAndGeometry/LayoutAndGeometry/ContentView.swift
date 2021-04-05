//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Ania on 08/01/2021.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .blue, .yellow, .green, .pink, .orange, .purple, .gray, .white]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Rectangle()
                                .fill(self.colors[index % 7])
                                .frame(height: 150)
                                .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(width: 150)
                    }
                }
                .padding(.horizontal, (fullView.size.width - 150) / 2)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    
    //    var body: some View {
    //        GeometryReader { fullView in
    //            ScrollView(.vertical) {
    //                ForEach(0..<50) { index in
    //                    GeometryReader { geo in
    //                        Text("Row #\(index)")
    //                            .font(.title)
    //                            .frame(width: fullView.size.width)
    //                            .background(self.colors[index % 7])
    //                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
    ////                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY) / 5), axis: (x: 0, y: 1, z: 0))
    //                    }
    //                    .frame(height: 40)
    //                }
    //            }
    //        }
}


//    var body: some View {
//        OuterView()
//            .background(Color.red)
//            .coordinateSpace(name: "Custom")
//    }
//

//    var body: some View {
//        VStack {
//            GeometryReader { geo in
//                Text("Hello, world!")
//                    .frame(width: geo.size.width * 0.9)
//                    .background(Color.red)
//            }
//            .background(Color.green)
//            Text("Outside Geometry Reader")
//                .background(Color.yellow)
//        }
//    }


//    var body: some View {
//        HStack {
//            VStack {
//                Text("@twostraws")
//                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
//                        dimension[VerticalAlignment.bottom]
//                    })
//                Image("cupcakes")
//                    .resizable()
//                    .frame(width: 64, height: 64)
//            }
//
//            VStack {
//                Text("Full name:")
//                Text("Paul Hudson")
//                    .alignmentGuide(.midAccountAndName, computeValue: { dimension in
//                        dimension[VerticalAlignment.bottom]
//                    })
//                    .font(.largeTitle)
//            }
//        }
//    }


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

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}
