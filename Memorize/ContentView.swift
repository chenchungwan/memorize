//
//  ContentView.swift
//  Memorize
//
//  Created by Christine Chen on 8/28/25.
//

import SwiftUI


struct ContentView: View {
    let fruits = ["🍎", "🍒", "🍑", "🍇", "🍉","🥭","🍍","🫐"]
    let cars = ["🚗", "🚛", "🚕", "🚙", "🚐","🚒","🛻","🏎️","🛺","🚑","🛵","🚔"]
    let animals = ["🐶", "🐱", "🐥", "🐵", "🐧","🐔","🐞","🐬","🦉","🐳","🪼","🐝","🦩","🦥","🐷","🐸"]
     
    @State var theme = "fruits"
    
    @State var cardCount = 0

    @State var emojis :[String] = []
    
    var themeColor: Color {
        switch theme {
        case "fruits": return .green
        case "animals": return .brown
        case "cars": return .blue
        default: return .red
        }
    }
    
    func setEmojis() -> [String]{
        var twoPairs:[String] = []
        switch theme {
        case "fruits":
                self.cardCount = Int.random(in: 1...fruits.count)
                twoPairs = Array(fruits[0..<cardCount])
        case "cars":
            self.cardCount = Int.random(in: 1...cars.count)
            twoPairs = Array(cars[0..<cardCount])
        case "animals":
            self.cardCount = Int.random(in: 1...animals.count)
            twoPairs = Array(animals[0..<cardCount])
        default:
            self.cardCount = Int.random(in: 1...fruits.count)
            twoPairs = Array(fruits[0..<cardCount])
        }
        twoPairs += twoPairs
        return twoPairs.shuffled()
    }
    
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle).fontWeight(.bold).foregroundColor(.red)
            ScrollView {
                cards()
            }
            Spacer()
            themeChooser()
//            buttons()
        }
    }
    
    func cards() -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 5) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(character: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.padding().foregroundColor(themeColor)
    }
    
    func getThemeButton(themeName: String, symbol: String) -> some View {
        Button(action: {
            self.theme = themeName
            self.emojis = setEmojis()
        }, label: {
            VStack{
                Image(systemName: symbol).imageScale(.large).font(.largeTitle)
                Text(themeName)
            }
        })
    }
    
    
    func themeChooser() -> some View {
        HStack {
            getThemeButton(themeName: "fruits", symbol: "carrot").foregroundColor(.green).padding(.leading)
            Spacer()
            getThemeButton(themeName: "cars", symbol: "car").foregroundColor(.blue)
            Spacer()
            getThemeButton(themeName: "animals", symbol: "dog").foregroundColor(.brown).padding(.trailing)
        }
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
