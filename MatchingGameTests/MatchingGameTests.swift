//
//  MatchingGameTests.swift
//  MatchingGameTests
//
//  Created by Moosa Baloch on 22/08/2021.
//

import XCTest
@testable import MatchingGame

class MatchingGameTests: XCTestCase {
    var gameViewModel: GameVM!
    var cardMatchExpectation: XCTestExpectation?
    var scoreChangeExpectations: XCTestExpectation?
    var cardMismatchExpectation: XCTestExpectation?
    override func setUpWithError() throws {
        gameViewModel = GameVM(delegate: self, cardRepository: CardRepository(isMocked: true, numberOfCards: 16), defaults: Defaults.shared)
    }

    override func tearDownWithError() throws {}

    var matchedCards:[IndexPath] = []
    func testCardMathing() throws {
        gameViewModel.restartGame()
        let firstCard = IndexPath(row: 0, section: 0)
        let secondCard = IndexPath(row: 1, section: 0)
        cardMatchExpectation = expectation(description: "Card 0 and Card 1 Matches")
        gameViewModel.didSelectItemAt(indexPath: firstCard)
        gameViewModel.didSelectItemAt(indexPath: secondCard)
        waitForExpectations(timeout: 1)
        XCTAssertEqual(matchedCards.filter({$0.row == firstCard.row}).count,1)
        XCTAssertEqual(matchedCards.filter({$0.row == secondCard.row}).count,1)
    }
    
    
    var newScoreInt = 0
    func testScoreChange() throws {
        gameViewModel.restartGame()
        // Score increment
        scoreChangeExpectations = expectation(description: "Score Update on Card Match")
        let firstCard = IndexPath(row: 0, section: 0)
        let secondCard = IndexPath(row: 1, section: 0)
        gameViewModel.didSelectItemAt(indexPath: firstCard)
        gameViewModel.didSelectItemAt(indexPath: secondCard)
        waitForExpectations(timeout: 1)
        XCTAssertEqual(newScoreInt, 5) // 5 for 1 match
        // Score decrement
        scoreChangeExpectations = expectation(description: "Score Update on Card Match")
        let thirdCard = IndexPath(row: 2, section: 0)
        let fifthCard = IndexPath(row: 4, section: 0)
        gameViewModel.didSelectItemAt(indexPath: thirdCard)
        gameViewModel.didSelectItemAt(indexPath: fifthCard)
        waitForExpectations(timeout: 1)
        XCTAssertEqual(newScoreInt, 3) // 5 for 1 match -> -2 for no match
    }
    
    var cardsFlipBack: [IndexPath] = []
    func testFlipBackMismatchCards() {
        self.gameViewModel.restartGame()
        cardMismatchExpectation = expectation(description: "Card mismatch flip back")
        let thirdCard = IndexPath(row: 2, section: 0)
        let fifthCard = IndexPath(row: 4, section: 0)
        gameViewModel.didSelectItemAt(indexPath: thirdCard)
        gameViewModel.didSelectItemAt(indexPath: fifthCard)
        waitForExpectations(timeout: 1)
        XCTAssertEqual(cardsFlipBack.filter({$0.row == thirdCard.row}).count,1)
        XCTAssertEqual(cardsFlipBack.filter({$0.row == fifthCard.row}).count,1)
    }
}

extension MatchingGameTests: GameVMDelegate {
    func updateCountdownTimer(timeString: String, warning: Bool) {
        
    }
    
    func updateScore(newScore: String) {
        self.newScoreInt = Int(newScore) ?? 0
        self.scoreChangeExpectations?.fulfill()
        self.scoreChangeExpectations = nil
    }
    
    func flipToFront(indexPath: IndexPath) {
        
    }
    
    func flipBackCards(indexPaths: [IndexPath]) {
        self.cardsFlipBack = indexPaths
        self.cardMismatchExpectation?.fulfill()
        self.cardMismatchExpectation = nil
    }
    
    func cardsMatched(indexPaths: [IndexPath]) {
        self.matchedCards = indexPaths
        self.cardMatchExpectation?.fulfill()
        self.cardMatchExpectation = nil
    }
    
    func reloadItems() {}
    func showAlert(title: String, message: String, actionTitle: String) {}
}
