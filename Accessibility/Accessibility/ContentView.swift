//
//  ContentView.swift
//  Accessibility
//
//  Created by Ania on 27/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    let pictures = [
        "charlie-qBirgyjk38s-unsplash",
        "claudia-gschwend-zaQuhF6_7EE-unsplash",
        "michael-heise-MoQl-zfavSY-unsplash",
        "puria-berenji-ntxC8zI5S2s-unsplash"
    ]
    
    let labels = [
        "Facet z brodą",
        "Kokosy",
        "Portret kobiety",
        "Mężczyzna w zimie"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
        VStack {
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .accessibility(label: Text(labels[selectedPicture]))
                .accessibility(addTraits: .isButton)
                .accessibility(removeTraits: .isImage)
                .onTapGesture {
                    self.selectedPicture = Int.random(in: 0...3)
                }
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            .accessibilityElement(children: .combine)
            //.accessibility(label: Text("Ypur score is 1000"))
            Slider(value: $estimate, in: 0...50)
                .padding()
                .accessibility(value: Text("\(Int(estimate))"))
            Stepper("Rate our service \(rating)/5", value: $rating, in: 1...5)
                .accessibility(value: Text("\(rating) out of 5"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
