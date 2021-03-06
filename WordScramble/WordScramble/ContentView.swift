//
//  ContentView.swift
//  WordScramble
//
//  Created by Ania on 02/08/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @State private var userScore = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text("\(word)")
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("\(word), \(word.count) letters"))
                }
                Text("Your score: \(userScore)")
            }.navigationBarTitle(Text("\(rootWord)"))
            .navigationBarItems(leading: Button(action: startGame, label: {
                Text("Restart")
            }))
            .onAppear {
                startGame()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            setErrorAlert(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            setErrorAlert(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            setErrorAlert(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        calculateScore(word: answer)
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func calculateScore(word: String) {
        let wordLength = word.count
        userScore += (wordLength * (usedWords.count+1))
    }
    
    func startGame() {
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let content = try? String(contentsOf: fileURL) {
                let allWords = content.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                userScore = 0
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) && rootWord != word
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspeledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspeledRange.location == NSNotFound
    }
    
    func setErrorAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
