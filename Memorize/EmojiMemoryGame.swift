//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by Kirill Pukhov on 23.06.21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🐔", "🐧", "🐦", "🐥", "🦆", "🦅", "🦉", "🐺", "🐗", "🐴", "🦄"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 8) { emojis[$0] }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<Card> { model.cards }
    
    func choose(_ card: Card) { model.choose(card) }
    
    func shuffle() { model.shuffle() }
    
    func restart() { model = EmojiMemoryGame.createMemoryGame() }
}
