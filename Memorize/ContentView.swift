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
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let fruits = ["🍎", "🍒", "🍑", "🍇", "🍉","🥭","🍍","🫐"]
    
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 5) {
            ForEach(fruits, id: \.self) { fruit in
                CardView(character: fruit)
            }
        }
        .padding()
        .foregroundColor(.green)
    }
}





struct CardView: View {
    @State var isFaceUp = false
    var character: String
    
    var body: some View {
        ZStack {
            let baseSahpe = RoundedRectangle(cornerRadius: 10)
            var opacity: Double { isFaceUp ? 1 : 0 }
            
            if isFaceUp {
                baseSahpe.fill(.white)
                baseSahpe.strokeBorder(lineWidth: 1)
            } else {
                baseSahpe.fill()
            }
            
            Text(character).font(.largeTitle).padding().opacity(opacity)
            
        }
        .onTapGesture { self.isFaceUp.toggle()}
    }
}

















#Preview {
    ContentView()
}
