//
//  ContentView.swift
//  Memorize
//
//  Created by Christine Chen on 8/28/25.
//

import SwiftUI


struct ContentView: View {
    let fruits = ["🍎", "🍒", "🍑", "🍇", "🍉","🥭","🍍","🫐"]
    let cars = ["🚗", "🚛", "🚕", "🚙", "🚐","🚒","🛻","🏎️"]
    let animals = ["🐶", "🐱", "🐥", "🐵", "🐧","🐔","🐞","🐬"]
     
    
    @State var theme = "fruits"
    
    @State var cardCount = 16

    
    var themeColor: Color {
        switch theme {
        case "fruits": return .green
        case "animals": return .brown
        case "cars": return .blue
        default: return .red
        }
    }
    
    var emojis: [String] {
        var twoPairs :[String] = []
        switch theme {
        case "fruits": twoPairs = fruits + fruits
        case "animals": twoPairs = animals + animals
        case "cars": twoPairs = cars + cars
        default: twoPairs = fruits + fruits
        }
        return twoPairs
    }
    
    
    var body: some View {
      
        VStack {
            Text("Memorize").font(.largeTitle).fontWeight(.bold).foregroundColor(.red)
            themeChooser()
            ScrollView {
                cards()
            }
            Spacer()
            buttons()
        }
    }
    
    func cards() -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 5) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(character: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.padding().foregroundColor(themeColor)
    }
    
    func buttons() -> some View {
        HStack {
            cardAjuster(by: +1, symbol: "plus.rectangle.portrait").padding(.leading)
            Spacer()
            cardAjuster(by: -1, symbol: "minus.rectangle.portrait").padding(.trailing)
        }.imageScale(.large).font(.largeTitle).foregroundColor(themeColor)
    }
    
    func cardAjuster(by offset: Int, symbol:String) -> some View {
        Button (action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    
    func themeChooser() -> some View {
        HStack {
            Button(action: {
                self.theme = "fruits"
            }, label: {
                Image(systemName: "carrot")
            }).foregroundColor(.green)
            Button(action: {
                self.theme = "cars"
            }, label: {
                Image(systemName: "car")
            }).foregroundColor(.blue)
            Button(action: {
                self.theme = "animals"
            }, label: {
                Image(systemName: "dog")
            }).foregroundColor(.brown)
        }.imageScale(.large).font(.largeTitle)
    }
            
        
    
}//end of content view struct


struct CardView: View {
    let character: String
    @State var isFaceUp = false
  
    
    var body: some View {
        ZStack {
            let baseShape = RoundedRectangle(cornerRadius: 10)
            baseShape.strokeBorder(lineWidth: 2)
            Text(character).font(.largeTitle)
            baseShape.fill().opacity(isFaceUp ? 1 : 0)
        }
        .onTapGesture { self.isFaceUp.toggle()}
    }
}// end of CardView struct

















#Preview {
    ContentView()
}
