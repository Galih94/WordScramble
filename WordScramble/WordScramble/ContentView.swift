//
//  ContentView.swift
//  WordScramble
//
//  Created by Galih Samudra on 14/05/24.
//

import SwiftUI

struct ContentView: View {
    var names = ["Galih", "Samodra", "Wicaksono"]
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
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
        }
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else { return }
        
        // more validation here
        withAnimation {
            usedWords.insert(answer, at: 0)
            newWord = ""
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
}

#Preview {
    ContentView()
}
