//
//  MemoryGame.swift
//  memorize
//
//  Created by Ken Hsieh on 2026/3/30.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: [Card]
    var score: Int = 0
    
    init(numberOfPairsOfCards: Int,
         createCardContent: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPairsOfCards {
            let cardContent: CardContent = createCardContent(index)
            cards.append(Card(content: cardContent, id: "\(index)a"))
            cards.append(Card(content: cardContent, id: "\(index)b"))
        }
        shuffle()
    }
    
    var lastFaceUpIndex: Int?
    mutating func choose(_ card: Card) {
        if let chosenIndex = index(of: card), !cards[chosenIndex].isMatched, chosenIndex != lastFaceUpIndex {
            if let lastIndex = lastFaceUpIndex {
                if cards[lastIndex].content == cards[chosenIndex].content {
                    cards[lastIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                    score += 2
                } else {
                    let penalty = (cards[lastIndex].hasBeenFlipped ? 1 : 0) + (cards[chosenIndex].hasBeenFlipped ? 1 : 0)
                    score -= penalty
                }
                cards[lastIndex].hasBeenFlipped = true
                cards[chosenIndex].hasBeenFlipped = true
                cards[chosenIndex].isFaceUp = true
                lastFaceUpIndex = nil
            } else {
                for i in cards.indices {
                    cards[i].isFaceUp = false
                }
                cards[chosenIndex].isFaceUp = true
                cards[chosenIndex].hasBeenFlipped = true
                lastFaceUpIndex = chosenIndex
            }
        }
        print("cards: \(cards)")
        print("score: \(score)")
    }
    
    func index(of card: Card) -> Int? {
        for i in 0..<cards.count {
            if cards[i].id == card.id {
                return i
            }
        }
        return nil
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print("shuffle cards: \(cards)")
    }
    
    struct Card: Equatable, Identifiable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.id == rhs.id
        }
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var hasBeenFlipped: Bool = false
        var content: CardContent
        
        var id: String
    }
}
