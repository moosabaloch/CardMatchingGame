//
//  Defaults.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import Foundation
class Defaults {
    private let userDefaults = UserDefaults.standard
    static let shared = Defaults()
    private init() {}
    private let countdownTimeKey = "countdownTimeKey"
    
    func saveCountDownTimerDefaultTime(timeInSeconds seconds: Int) {
        userDefaults.setValue(seconds, forKey: countdownTimeKey)
        userDefaults.synchronize()
    }
    
    func getCountDownTimerDefaultTime() -> Int? {
        let seconds = userDefaults.integer(forKey: countdownTimeKey)
        if seconds == 0 { return nil }
        return seconds
    }
}
