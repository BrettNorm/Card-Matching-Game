//
//  ContentView.swift
//  Card Matching Game
//
//  Created by Brett Bax on 10/31/21.
//



import SwiftUI

struct EmojiMatchingGameView: View {
   
    @State var showSettings: Bool = false
    @ObservedObject var game: EmojiMatchingGame
    @Namespace private var dealingNamespace
    
    
    // Primary view of card matching game
    var body: some View {
        
        ZStack(){
            // Taste the rainbow
            LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .purple, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack {
                gameBody
                
                // Bottom row of buttons
                HStack {
                    restart
                    settings
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody
        }
    }
    
    @State private var cardDealt = Set<Int>()
    
    
    var gameBody: some View {
        
        // Grid housing our game
        
        cardGrid(items: game.cards, aspectRatio: 2/3) { card in
            if (card.matched) {
                // Can't make them stay
                // (insert joke about my mom)
            }
            else if cardUndealt(card) {
                Color.clear
            }
            else {
                CardView(card: card)
                    .padding(3)
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
    }
    
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(cardUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .opacity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CGFloat(60), height: CGFloat(90))
        .foregroundColor(Color.black)
        .onTapGesture {
            for card in game.cards {
                    deal(card)
            }
        }
    }
    
    private func deal(_ card: EmojiMatchingGame.Card) {
        cardDealt.insert(card.id)
        game.shuffle()
    }
    
    private func cardUndealt(_ card: EmojiMatchingGame.Card) -> Bool {
        !cardDealt.contains(card.id)
    }

    
    private func zIndex(of card: EmojiMatchingGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    

    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
        .buttonStyle(BlackGrowingButton())
    }

    var restart: some View {
        Button("Restart") {
                cardDealt = []
                game.restart()
        }
        .buttonStyle(BlackGrowingButton())
    }

    var settings: some View {
            Button("Settings") {
                showSettings.toggle()
            }
            .buttonStyle(BlackGrowingButton())
            .sheet(isPresented: $showSettings) {
                SettingsView(game: game)
            }
        }
}


struct CardView: View {
    var card: EmojiMatchingGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text(card.cardContent)
                    .font(Font.system(size: CGFloat(32)))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardStuff(isFaceUp: card.faceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (CGFloat(32) / CGFloat(0.7))
    }
    
}


struct EmojiMatchingGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMatchingGame()
        game.choose(game.cards.first!)
        return EmojiMatchingGameView(game: game)
    }
}
