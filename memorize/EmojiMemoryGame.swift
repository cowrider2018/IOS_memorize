//
//  EmojiMemoryGame.swift
//  memorize
//
//  Created by Ken Hsieh on 2026/3/30.
//

import SwiftUI
import Combine

class EmojiMemoryGame: ObservableObject {
    
    private static var emojis = ["鼠", "牛", "虎","兔", "🚚", "✈️", "🚡", "🛰", "🚅", "🚗", "🚕", "🚌", "🚎", "🚓", "🚑", "🚒", "🛵", "🚜", "🛴", "🏍", "🛺", "🚨", "🚃", "🛳", "🛥", "🚤", "⛵️", "🛶"]

    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4, createCardContent: {index in EmojiMemoryGame.emojis[index] })
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - intent
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
