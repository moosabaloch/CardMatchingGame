//
//  AppDelegate.swift
//  MatchingGame
//
//  Created by Moosa Baloch on 22/08/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

/*
 - When the user opens the app, the user will see the game configuration screen.
 - The only required thing to be configurable here is the gaming timeout timer.
 - The gaming timeout timer should default to 1 minute on first start.
 - When a timeout is selected by the user, the app should remember this on next start.
 - This "Matching Game" should consist of a 4x4 grid of cards on the screen.
 - The 4x4 grid of cards is showing their "back side" (which looks the same for all cards) on start of the game.
 - When the user selects a card, the card flips and shows an image. The card stays flipped until the user selects another card.
 - If the second card matches, both cards will stay flipped on their front side and the user score will be increased by 5 points, else both cards flip back and the user points are decreased by 2 points (but never below 0 points).
 - There should be a "Restart" button on the game screen to restart the game with the timer reset and 0 points at any time.
 - When the timer is over or when all cards are flipped open correctly, the user sees a summary of his score & how much time left for the game. There should also be a button to start a new game.
 - You are free to use any animations you like. But that's just a "nice-to-have", not a requirement. Put more emphasis on the code part than on the UI. The UI should work.
 - The task should be completed within 7 days after you received it. It should be done within a maximum of ~8 hours of active work (you can split the work on multiple days if needed).
 - Please prioritize your work so that in case you can't complete the task in ~8 hours, as much as possible works even if not everything. Document the unfinished parts properly.
 - The code should be shared with us including the Git history. So please beware that we will also check the Git commits. For example, it could be posted on GitHub or GitLab with an invitation sent to username "Jeehut" or the repository made public.
 */
