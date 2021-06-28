//
//  ContentView.swift
//  Memorize
//
//  Created by Kirill Pukhov on 22.06.21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                AspectVGrid(items: game.cards, aspectRatio: EMGConstants.aspectRatio) { card in
                    if !isDealt(card) || card.isMatched && !card.isFaceUp {
                        Color.clear
                    } else {
                        CardView(card)
                            .foregroundColor(EMGConstants.cardColor)
                            .zIndex(calcZIndex(for: card))
                            .padding(4)
                            .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                            .transition(.asymmetric(insertion: .identity, removal: .scale))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    game.choose(card)
                                }
                            }
                    }
                }
                Spacer()
                HStack {
                    restartButton
                    Spacer()
                    shuffleButton
                }
            }
            deck
                .foregroundColor(EMGConstants.cardColor)
        }
        .padding()
    }
    
    private var shuffleButton: some View {
        Button {
            withAnimation { game.shuffle() }
        } label: {
            Text("Shuffle")
        }
    }
    
    private var restartButton: some View {
        Button {
            withAnimation {
                dealtCards = []
                game.restart()
            }
        } label: {
            Text("Restart")
        }
    }
    
    @State var dealtCards = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealtCards.insert(card.id)
    }
    
    private func isDealt(_ card: EmojiMemoryGame.Card) -> Bool {
        dealtCards.contains(card.id)
    }
    
    private var deck: some View {
        ZStack {
            ForEach(game.cards.filter({!isDealt($0)})) { card in
                CardView(card)
                    .zIndex(calcZIndex(for: card))
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .opacity, removal: .identity))
            }
        }
        .frame(width: EMGConstants.deckWidth, height: EMGConstants.deckHeight)
        .onTapGesture {
            for card in game.cards {
                withAnimation(.easeInOut(duration: EMGConstants.totalDealDelay).delay(calcDelay(for: card))) {
                    deal(card)
                }
            }
        }
    }
    
    private func calcZIndex(for card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    private func calcDelay(for card: EmojiMemoryGame.Card) -> Double {
        var delay: Double
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (EMGConstants.totalDealDelay / Double(game.cards.count))
        } else  {
            delay = 0
        }
        return delay
    }
    
    private struct EMGConstants {
        static let totalDealDelay: Double = 1.5
        static let aspectRatio: CGFloat = 2/3
        static let deckWidth: CGFloat = 85.0
        static let deckHeight: CGFloat = deckWidth / aspectRatio
        static let cardColor: Color = .red
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(game: EmojiMemoryGame())
            .previewDevice("iPhone 12")
            .preferredColorScheme(.dark)
    }
}
