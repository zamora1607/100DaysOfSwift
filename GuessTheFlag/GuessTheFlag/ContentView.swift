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
    
    @State private var countries = ["Poland", "Nigeria", "Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMsg = ""
    
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
                        self.buttonTapped(number)
                    }, label: {
                        FlagImage {
                            Image(countries[number])
                                .renderingMode(.original)
                        }
                    })
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
            score += 1
            scoreTitle = "Correct"
            alertMsg = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            alertMsg = "Ops this is flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
