//
//  MemoryGame.swift
//  Memorize
//
//  Created by Adrian Szewczak on 22/05/2022.
//

import Foundation


struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private var score: Int = 0
    private var indexOfTheOneAndOnlyUpCard: Int?
    private(set) var matchedPairs: Int = 0
    private(set) var isGameDone: Bool = false
    
    mutating func choose(_ card: Card){
        if let chosenCard = cards.firstIndex(where: {$0.id == card.id}),
            !cards[chosenCard].isFaceUp,
            !cards[chosenCard].isMatched{
            if let potentialMatch = indexOfTheOneAndOnlyUpCard{
                if cards[chosenCard].content == cards[potentialMatch].content{
                    cards[chosenCard].isMatched = true
                    cards[potentialMatch].isMatched = true
                    score += 2
                    matchedPairs += 1
                    if(matchedPairs*2 == cards.count){
                        isGameDone = true
                    }
                }else{
                    score -= 1
                }
                indexOfTheOneAndOnlyUpCard = nil
            }else{
                for index in cards.indices{
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyUpCard = chosenCard
            }
            cards[chosenCard].isFaceUp.toggle()
        }
        
    }
    func returnScore() -> Int{
        return score
    }
    init(numberOfPairsOfCards: Int,color: String, createCardContent: (Int)->CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(id: pairIndex*2,content: content, color: color))
            cards.append(Card(id: pairIndex*2+1, content: content, color: color))
        }
        cards.shuffle()
        isGameDone = false
    }
    
    
    struct Card: Identifiable{
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        private(set) var color: String?
    }
    
}
