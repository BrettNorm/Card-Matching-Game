//
//  Card_Matching_GameApp.swift
//  Card Matching Game
//
//  Created by Brett Bax on 11/4/21.
//

import SwiftUI

@main
struct Card_Matching_GameApp: App {
    private let game = EmojiMatchingGame()
    
    
    var body: some Scene {
        WindowGroup {
            EmojiMatchingGameView(game: game)
        }
    }
}
