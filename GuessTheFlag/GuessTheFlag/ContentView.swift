//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ania on 18/07/2020.
//

import SwiftUI

struct FlagImage<Content: View>: View {
    let content: () -> Content

    var body: some View {
        content()
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius:20)
    }
}

struct ContentView: View {
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var countries = ["Poland", "Nigeria", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMsg = ""
    
    @State private var opacity = 1.0
    @State private var animationAmount = 0.0
    @State private var tappedCorrect = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of").foregroundColor(.white)
                    Text("\(countries[correctAnswer])").foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            self.buttonTapped(number)
                            animationAmount += 360
                            opacity = 0.25
                        }
                    }, label: {
                        FlagImage {
                            Image(countries[number])
                                .renderingMode(.original)
                        }
                        .accessibility(label: Text(self.labels[self.countries[number], default: "Uknown flag"]))
                    }).rotation3DEffect(
                        .degrees((number == correctAnswer) && tappedCorrect ? animationAmount : 0.0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    ).opacity(((number != correctAnswer) || !tappedCorrect) ? opacity : 1.0)
                }
                Text("Your current score: \(score)")
                    .foregroundColor(.white)
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(alertMsg), dismissButton: .default(Text("OK"), action: {
                askQuestion()
            }))
        }
    }
    
    func buttonTapped(_ number: Int) {
        if number == correctAnswer {
            tappedCorrect = true
            score += 1
            scoreTitle = "Correct"
            alertMsg = "Your score is \(score)"
        } else {
            tappedCorrect = false
            scoreTitle = "Wrong"
            alertMsg = "Ops this is flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        opacity = 1.0
        tappedCorrect = false
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
