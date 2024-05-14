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
        List(names, id: \.self) {
            Text("Hello, world! \($0)")
        }
        .listStyle(.grouped)
    }
}

#Preview {
    ContentView()
}
