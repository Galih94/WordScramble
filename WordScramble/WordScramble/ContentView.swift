//
//  ContentView.swift
//  WordScramble
//
//  Created by Galih Samudra on 14/05/24.
//

import SwiftUI

struct ContentView: View {
    var names = ["Galih", "Samodra", "Wicaksono"]
    var body: some View {
        List {
            Text("Hello, world! ")
            ForEach(names, id: \.self) {
                Text("Hello, world! \($0)")
            }
        }
        .listStyle(.grouped)
    }
    
    private func testString() {
        let input = "a b c"
        let letters = input.components(separatedBy: " ") // ["a", "b", "c"]
        let input2 = """
        a
        b
        c
        """
        let letters2 = input2.components(separatedBy: "\n") // ["a", "b", "c"]
        let randomLetter = letters.randomElement() ?? "not found" // "a"
    }
    
    private func testBundle() {
        if let fileURL = Bundle.main.url(forResource: "nameFIle", withExtension: "txt") {
            if let file = try? String(contentsOf: fileURL) {
                // loaded fileURL into string
            }
        }
    }
}

#Preview {
    ContentView()
}
