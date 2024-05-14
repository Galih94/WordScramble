//
//  ContentView.swift
//  WordScramble
//
//  Created by Galih Samudra on 14/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            ForEach(0..<5) {
                Text("Hello, world! \($0)")
            }
        }
    }
}

#Preview {
    ContentView()
}
