//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Kirill Pukhov on 23.06.21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var previousChosenCardIndex: Int?
    
    mutating func choose(_ card: Card) {
        if let choosenCardIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[choosenCardIndex].isFaceUp,
           !cards[choosenCardIndex].isMatched
        {
            if let previousChosenCardIndex = previousChosenCardIndex {
                if cards[previousChosenCardIndex].content == cards[choosenCardIndex].content {
                    cards[previousChosenCardIndex].isMatched = true
                    cards[choosenCardIndex].isMatched = true
                }
                
                self.previousChosenCardIndex = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                self.previousChosenCardIndex = choosenCardIndex
            }
            cards[choosenCardIndex].isFaceUp.toggle()
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        
        var id: Int
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
}
