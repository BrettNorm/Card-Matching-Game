//
//  EmojiMatchingGame.swift
//  Card Matching Game
//
//  Created by Brett Bax on 11/1/21.
//

import SwiftUI

class EmojiMatchingGame: ObservableObject {
    typealias Card = MatchingGame<String>.Card
    
    static var cardPairs = 8
    
    private static let emojis = ["😎", "💦", "😂", "🍕", "😀", "😍", "😝", "🤩", "😙", "🥶", "👽", "😼", "🥸", "🧐", "💀", "🤬", "🤞🏻", "😶‍🌫️", "🍏", "🍓", "🥐", "🍟", "🍧", "🍿", "⚽️", "🏏", "🥊", "⛸", "🎯", "🎰", "⚾️", "🏐", "🎫", "🛰", "🚋", "🎆"]
    
    static func makeMatchingGame() -> MatchingGame<String> {
        
        MatchingGame<String>(numPairs: EmojiMatchingGame.cardPairs) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = makeMatchingGame()
        
    var cards: Array<Card> {
        model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMatchingGame.makeMatchingGame()
    }
}
