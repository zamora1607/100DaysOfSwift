//
//  ContentView.swift
//  RPS
//
//  Created by Ania on 22/07/2020.
//

import SwiftUI

struct ContentView: View {
    
    var moves = ["Rock", "Paper", "Scisors"]
    
    @State var appChoice = Int.random(in: 0...2)
    @State var winLose = Bool.random()
    
    @State var score = 0
    @State var numberOfMoves = 0
    
    @State var isEnd = false
    
    var body: some View {
        VStack {
            Text("Your current score is \(score)").padding(.bottom, 30)
            Text("App choice: \(moves[appChoice])")
                .fontWeight(.heavy)
                .font(.title)
            Text("You need to \(winLose ? "win": "lose")!")
                .foregroundColor(winLose ? .green : .red)
                .bold()
                .padding(.all, 20)
            
            HStack {
                ForEach(0..<3) { number in
                    Button(action: {
                            check(number: number)
                    }, label: {
                        Text(moves[number])
                    })
                    .frame(width: 70, height: 70, alignment: .center)
                    .padding(.all, 20)
                    .border(Color.blue, width: 3)
                }
            }
        }.alert(isPresented: $isEnd) {
            Alert(title: Text("End"), message: Text("Congratulation! Your score is \(score)!"), dismissButton: .default(Text("OK")))
        }
    }
    
    func check(number: Int) {
        numberOfMoves += 1
        //simplyfiy to numbers instead of string //kazdy kolejny z array wygrywa z poprzednim
        switch moves[appChoice] {
        case "Rock":
            if (moves[number] == "Paper" && winLose) {
                score += 1
            } else if (moves[number] != "Paper" && !winLose) {
                score += 1
            }
        case "Paper":
            if (moves[number] == "Scisors" && winLose) {
                score += 1
            } else if (moves[number] != "Scisors" && !winLose) {
                score += 1
            }
        default: //scisors
            if (moves[number] == "Rock" && winLose) {
                score += 1
            } else if (moves[number] != "Rock" && !winLose) {
                score += 1
            }
        }
        
        if (numberOfMoves >= 10) {
            isEnd = true
        }
        
        appChoice = Int.random(in: 0...2)
        winLose = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
