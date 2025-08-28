//
//  ContentView.swift
//  Memorize
//
//  Created by Christine Chen on 8/28/25.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 5) {
            CardView(isFaceUp: false, character: "🤣")
            CardView(isFaceUp: true, character: "🤣")
            CardView(isFaceUp: false, character: "🤣")
            CardView(isFaceUp: true, character: "🤣")
        }
        .padding()
    }
}





struct CardView: View {
    var isFaceUp: Bool
    var character: String
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 10).strokeBorder(lineWidth: 1)
                Text(character).font(.largeTitle).padding()
            } else {
                RoundedRectangle(cornerRadius: 10)
            }
        }
        .foregroundColor(.blue)
    }
}
















#Preview {
    ContentView()
}
