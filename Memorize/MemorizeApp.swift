//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Kirill Pukhov on 22.06.21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
