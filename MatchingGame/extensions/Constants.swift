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
    public static let congrats = "Congrats!"
    public static let playAgain = "Play Again"
    public static let timeOver = "Time Over"
    public static let youLostTheGame = "You lost the game."
    public static let tryAgain = "Try Again"
    public static func youWonTheGame(withScore score: String) -> String { return "You Won The Game!\nYour Score is \(score)." }
}
