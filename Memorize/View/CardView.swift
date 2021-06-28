//
//  CardView.swift
//  Memorize
//
//  Created by Kirill Pukhov on 27.06.21.
//

import SwiftUI

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            Text(card.content)
                .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                .animation(.linear(duration: 1.5).repeatForever(autoreverses: false))
                .font(.system(size: CardConstants.fontSize))
                .scaleEffect(scale(geometry.size))
                .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(_ size: CGSize) -> CGFloat {
        min(size.height, size.width) / (CardConstants.fontSize / CardConstants.fontScaleFactor)
    }
    
    private struct CardConstants {
        static let fontScaleFactor: CGFloat = 0.65
        static let fontSize: CGFloat = 36.0
    }
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
