//
//  CardStuff.swift
//  Card Matching Game
//
//  Created by Brett Bax on 11/7/21.
//

import SwiftUI

struct CardStuff: AnimatableModifier {
    
    var rotate: Double
    
    init(isFaceUp: Bool) {
        rotate = !isFaceUp ? 180 : 0
    }
    
    var animatableData: Double {
        get { rotate }
        set { rotate = newValue }
    }
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: CGFloat(8))
            if rotate < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: CGFloat(4))
            } else {
                shape.fill()
            }
            content
                .opacity(rotate < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotate), axis: (0, 1, 0))
    }
    
 
}

extension View {
    func cardStuff(isFaceUp: Bool) -> some View {
        self.modifier(CardStuff(isFaceUp: isFaceUp))
    }
    
}
