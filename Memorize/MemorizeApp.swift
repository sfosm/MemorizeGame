//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Adrian Szewczak on 15/05/2022.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojisMemoryGame()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
