//
//  AppState.swift
//  CineWatch
//
//  Created by Andika on 29/10/21.
//

import Foundation
import Network

enum TabItems {
    case discover
    case nowPlaying
    case upcoming
    case search
}

class AppState: ObservableObject {
    @Published var connection: NWPath.Status = .satisfied
    @Published var passedOnBoarding: Bool

    init() {
        if !UserDefaults.standard.bool(forKey: "cw.state.launched") {
            UserDefaults.standard.set(true, forKey: "cw.state.launched")
            passedOnBoarding = true
        } else {
            passedOnBoarding = false
        }
    }

    func passOnboarding() {
        UserDefaults.standard.set(true, forKey: "cw.state.launched")
    }
}
