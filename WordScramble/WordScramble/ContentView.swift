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
                }
                Section {
                    ForEach(usedWords, id: \.self) {
                        Text($0)
                    }
                }
            }
        }
        .navigationTitle(rootWord)
    }
    
    private func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else { return }
        
        // more validation here
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
}

#Preview {
    ContentView()
}
