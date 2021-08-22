//
//  Constants.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

extension UIImage {
    static var appBackground: UIImage? {
        return UIImage(named: "appBackground")
    }
    
    static var icon: UIImage? {
        return UIImage(named: "icon")
    }
}

extension String {
    static let congrats = "Congrats!"
    static let playAgain = "Play Again"
    static let timeOver = "Time Over"
    static let youLostTheGame = "You lost the game."
    static let tryAgain = "Try Again"
    static func youWonTheGame(withScore score: String) -> String { return "You Won The Game!\nYour Score is \(score)." }
}
