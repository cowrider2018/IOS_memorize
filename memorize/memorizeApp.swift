//
//  memorizeApp.swift
//  memorize
//
//  Created by Ken Hsieh on 2026/3/16.
//

import SwiftUI

@main
struct memorizeApp: App {
    var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
