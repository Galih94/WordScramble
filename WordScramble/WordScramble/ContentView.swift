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
            Section("Section 1") {
                Text("Header")
                ForEach(0..<5) {
                    Text("Hello, world! \($0)")
                }
                Text("Footer")
            }
            
            Section("Section 2") {
                Text("Header")
                ForEach(0..<2) {
                    Text("Hello, world! \($0)")
                }
                Text("Footer")
            }
            
            Section("Section 3") {
                Text("Header")
                ForEach(0..<1) {
                    Text("Hello, world! \($0)")
                }
                Text("Footer")
            }
        }
    }
}

#Preview {
    ContentView()
}
