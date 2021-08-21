//
//  GameVM.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import Foundation

protocol GameVMDelegate: NSObject {
    func updateCountdownTimer(timeString: String, warning: Bool)
    func updateScore(newScore: String)
    func flipToFront(indexPath: IndexPath)
    func flipBackCards(indexPaths: [IndexPath])
    func cardsMatched(indexPaths: [IndexPath])
    func reloadItems()
    func showAlert(title: String, message: String)
}

class GameVM {
    
    unowned var delegate: GameVMDelegate
    private let cardRepository: CardRepository
    var cardArray: [Card] = []
    private var timer: Timer?
    private var userScore: Int = 0 {
        didSet {
            self.delegate.updateScore(newScore: self.userScore.toString)
        }
    }
    private var firstFlippedCardIndexPath: IndexPath?
    private var remainingTimeInMillis: Float = 60  // 60 seconds default
    private lazy var dcFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter
    }()
    
    init(delegate: GameVMDelegate, cardRepository: CardRepository) {
        self.delegate = delegate
        self.cardRepository = cardRepository
        self.cardArray = cardRepository.getCardData()
    }
    
    
    func scheduleTimer() {
        self.userScore = 0
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo:  nil, repeats: true)
        self.remainingTimeInMillis = 60
    }
    
    @objc func countdown() {
        self.remainingTimeInMillis -= 1
        if self.remainingTimeInMillis <= 0 {
            self.timer?.invalidate()
            self.checkGameState()
        }
        let formattedString = dcFormatter.string(from: TimeInterval(self.remainingTimeInMillis)) ?? "\(self.remainingTimeInMillis)"
        self.delegate.updateCountdownTimer(timeString: formattedString, warning: self.remainingTimeInMillis <= 10)
    }
    
    func restartGame() {
        self.cardArray = cardRepository.getCardData()
        self.scheduleTimer()
        self.delegate.reloadItems()
        self.userScore = 0
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        if remainingTimeInMillis <= 0 {
            return
        }
        let card = cardArray[indexPath.row]
        if card.isFlipped == false && card.isMatched == false {
            self.delegate.flipToFront(indexPath: indexPath)
            card.isFlipped = true
            if firstFlippedCardIndexPath == nil {
                firstFlippedCardIndexPath = indexPath
            } else {
                checkForMatches(indexPath)
            }
        }
    }
    
    func checkForMatches(_ secondFlippedCardIndexPath: IndexPath) {
        let cardOne = cardArray[firstFlippedCardIndexPath!.row]
        let cardTwo = cardArray[secondFlippedCardIndexPath.row]
        if cardOne.unicode == cardTwo.unicode {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            self.delegate.cardsMatched(indexPaths: [firstFlippedCardIndexPath!, secondFlippedCardIndexPath])
            checkGameState()
            self.userScore += 5
        } else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            self.delegate.flipBackCards(indexPaths: [firstFlippedCardIndexPath!, secondFlippedCardIndexPath])
            if self.userScore >= 2 {
                self.userScore -= 2
            }
        }
        firstFlippedCardIndexPath = nil
    }
    
    func checkGameState() {
        if cardArray.first(where: { !$0.isMatched }) == nil {
            if remainingTimeInMillis > 0 {
                timer?.invalidate()
            }
            self.delegate.showAlert(title: "Congrats!", message: "You Won The Game")
        } else {
            if remainingTimeInMillis > 0 {
                return
            }
            self.delegate.showAlert(title: "Time Over", message: "You Lost")
        }
    }
}