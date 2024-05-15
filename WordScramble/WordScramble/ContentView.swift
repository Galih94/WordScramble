//
//  ContentView.swift
//  WordScramble
//
//  Created by Galih Samudra on 14/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var alertShowing = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .onSubmit(addNewWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: {
                startGame()
            })
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Score: \(score)")
                        .font(.title3)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New Game") {
                        resetGame()
                        startGame()
                    }
                }
            })
            .alert(alertTitle, isPresented: $alertShowing) {
                Button("OK") {}
            } message: {
                Text(alertMsg)
            }
        }
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else { return }
        
        guard isOriginalWord(answer) else {
            showAlert(title: "Error Original Word", message: "`\(answer)` has been added")
            return
        }
        
        guard isPossibleWord(answer) else {
            showAlert(title: "Error Possible Word", message: "`\(answer)` cannot be spelled from word `\(rootWord)`")
            return
        }
        
        guard isRealWord(answer) else {
            showAlert(title: "Error Real Word", message: "`\(answer)` is not a real word")
            return
        }
        
        guard isWordTooShort(answer) else {
            showAlert(title: "Error Short Word", message: "`\(answer)` is too short for an answer word")
            return
        }
        
        guard isTheSameAsRootWord(answer) else {
            showAlert(title: "Error Same Word", message: "answer `\(answer)` is same as word `\(rootWord)`")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            newWord = ""
            score += answer.count
        }
    }
    
    private func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWord = try? String(contentsOf: startWordsURL) else {
            fatalError("Could not load start.txt from bundle.")
        }
        let allWords = startWord.components(separatedBy: "\n")
        if let word = allWords.randomElement() {
            rootWord =  word
        } else {
            fatalError("Could not find any word inside start.txt from bundle.")
        }
        
    }
    
    private func resetGame() {
        usedWords = []
        score = 0
    }
    
    // MARK: Alert
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMsg = message
        alertShowing = true
    }
    
    // MARK: Validation
    private func isOriginalWord(_ word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    private func isPossibleWord(_ word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let index = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isRealWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func isTheSameAsRootWord(_ word: String) -> Bool {
        return word != rootWord
    }
    
    private func isWordTooShort(_ word: String) -> Bool {
        return word.count >= 3
    }
}

#Preview {
    ContentView()
}
