//
//  Settings.swift
//  Card Matching Game
//
//  Created by Brett Bax on 11/8/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var game: EmojiMatchingGame
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.label))
                        .imageScale(.large)
                        .frame(width: 44, height: 44)
                }
            }
            .padding()
            
            Spacer()
         
            
            Text("Select Game Size")
                .font(.title)
                .fontWeight(.heavy)

            Spacer()
            VStack(spacing: 40) {
                fourCards
                sixteenCards
                thirtySixCards
                
            }
            Spacer()
        }
        
    }
    
    
    var fourCards: some View {
        Button("2 x 2") {
            EmojiMatchingGame.cardPairs = 2
        }
        .buttonStyle(BlueGrowingButton())
    }
    
    var sixteenCards: some View {
        Button("4 x 4") {
            EmojiMatchingGame.cardPairs = 8
        }
        .buttonStyle(BlueGrowingButton())
    }
    
    var thirtySixCards: some View {
        Button("6 x 6") {
            EmojiMatchingGame.cardPairs = 18
            print("\(EmojiMatchingGame.cardPairs)")
        }
        .buttonStyle(BlueGrowingButton())
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMatchingGame()
        return SettingsView(game: game)
    }
}
