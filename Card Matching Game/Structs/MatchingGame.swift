//
//  MatchingGame.swift
//  Card Matching Game
//
//  Created by Brett Bax on 11/2/21.
//

import Foundation

struct MatchingGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var faceUpCard: Int? {
        get {
            cards.indices.filter({ cards[$0].faceUp }).onlyCardChosen
        }
        set {
            cards.indices.forEach { cards[$0].faceUp = ($0 == newValue) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenCard = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenCard].faceUp, !cards[chosenCard].matched
        {
            if let possibleMatch = faceUpCard {
                if cards[chosenCard].cardContent == cards[possibleMatch].cardContent {
                    cards[chosenCard].matched = true
                    cards[possibleMatch].matched = true
                    cards[chosenCard].faceUp = true
                    cards[possibleMatch].faceUp = true
                }
                cards[chosenCard].faceUp = true
            } else {
                faceUpCard = chosenCard
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    init(numPairs: Int, makeCard: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numPairs {
            let content = makeCard(pairIndex)
            cards.append(Card(cardContent: content, id: pairIndex * 2))
            cards.append(Card(cardContent: content, id: pairIndex * 2 + 1))
        }
    }
    
    struct Card: Identifiable {
        var matched = false
        var faceUp = false
        let cardContent: CardContent
        let id: Int
    }
}


extension Array {
    var onlyCardChosen: Element? {
        if count != 1 {
            return nil
        } else {
            return first
        }
    }
}
