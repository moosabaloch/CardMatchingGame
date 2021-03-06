//
//  CardRepository.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import Foundation

protocol CardRepository {
    var numberOfCards: Int { get set }
    func getCardData() -> [Card]
}

class CardRepositoryImp: CardRepository {
    var numberOfCards: Int
    
    init(numberOfCards: Int = 16) {
        self.numberOfCards = numberOfCards
    }
    
    func getCardData() -> [Card] {
        let emojiRanges: [Int] = ([0x1F601...0x1F64F] + [0x1F680...0x1F6B0]).flatMap({$0})
        var cardsArray = [Card]()
        while cardsArray.count < self.numberOfCards {
            let random = Int.random(in: 0..<emojiRanges.count)
            let currentEmojiUnicode = emojiRanges[random]
            if cardsArray.first(where: { $0.unicode == currentEmojiUnicode }) == nil {
                if let scalarValue = UnicodeScalar(currentEmojiUnicode) {
                    let emojiString = String(scalarValue)
                    let card1 = Card()
                    card1.emoji = emojiString
                    card1.unicode = currentEmojiUnicode
                    cardsArray.append(card1)
                    let card2 = Card()
                    card2.emoji = emojiString
                    card2.unicode = currentEmojiUnicode
                    cardsArray.append(card2)
                }
            }
        }
        cardsArray.shuffle()
        return cardsArray
    }
}
