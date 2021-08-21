//
//  UIViewController+Ext.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit


// MARK: Init VC from Storyboards with viewController static func instatiate
protocol Storyboarded {
    /// This function initialise the ViewController based on it's identifier from the storyboard you specify
    /// - Parameter storyboard: Pass the storyboard instance that conatins the viewController to be initialise
    static func instantiate(storyboard: UIStoryboard ) -> Self
    static func instantiate(withIdentifier identifier: String, storyboard: UIStoryboard ) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboard: UIStoryboard) -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)
        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")
            .count > 1 ? fullName.components(separatedBy: ".")[1] : fullName
        // instantiate a view controller with that identifier, and force cast as the type that was requested
        guard let vc = storyboard.instantiateViewController(withIdentifier: className) as? Self else {
            fatalError("Storyboard \(storyboard) doesn't have any UIViewController with identifier \(className).")
        }
        return vc
    }
    
    static func instantiate(withIdentifier identifier: String, storyboard: UIStoryboard) -> Self {
        return storyboard.instantiateViewController(withIdentifier: identifier) as? Self ?? Self()
    }
}

extension UIViewController: Storyboarded {} // Since all of VC's are using storyboard, No Need to implement on all VC's
