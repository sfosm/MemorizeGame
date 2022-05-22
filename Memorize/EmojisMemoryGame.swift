//
//  EmojisMemoryGame.swift
//  Memorize
//
//  Created by Adrian Szewczak on 22/05/2022.
//

import Foundation
import SwiftUI


class EmojisMemoryGame: ObservableObject{
    
    static let peopleEmojis: [String] = ["👶🏻","👧🏻","🧒🏻","👦🏻","👩🏻","🧑🏻","👨🏻","👩🏻‍🦱","🧑🏻‍🦱","👨🏻‍🦱","👩🏻‍🦰"]
    static let flagsEmojis: [String] = ["🇨🇮","🏴","🏴‍☠️","🏁","🚩","🏳️‍🌈","🏳️‍⚧️","🇺🇳","🇦🇫","🇦🇱","🇩🇿","🇦🇩"]
    static let animalsEmojis: [String] = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨"]
    static var actualTheme: ThemeHolder.Theme<String>?
    @Published private var themesModel: ThemeHolder = createThemeList()
    @Published private var cardsModel: MemoryGame<String> = createMemoryGame()
    
    
    
    
    static func createThemeList() -> ThemeHolder{
        ThemeHolder(givenThemeList: {
            [ThemeHolder.Theme<String>(peopleEmojis, color: "red", name:"People Theme", gid: 0),
                    ThemeHolder.Theme<String>(flagsEmojis, color: "cyan", name:"Flags Theme", gid: 1),
                    ThemeHolder.Theme<String>(animalsEmojis, color: "green", name:"Animals Theme", gid: 2)]
        })
    }
    static func createMemoryGame() -> MemoryGame<String>{
        MemoryGame<String>(numberOfPairsOfCards: actualTheme?.getThemeContent().count ?? 0,
                           color: actualTheme?.getThemeColor() ?? ""){ pairIndex in
            actualTheme?.getThemeContent()[pairIndex] ?? ""
        }
    }
    
    
    
    
    var cards: Array<MemoryGame<String>.Card>{
        cardsModel.cards
    }
    
    var themes: Array<ThemeHolder.Theme<String>>{
        themesModel.getThemesList()
    }
    
    
    
    func colorParser(_ color: String) -> Color{
        switch(color){
        case "red":
            return Color.red
        case "cyan":
            return Color.cyan
        case "green":
            return Color.green
        default:
            return Color.blue
        }
    }
    
    func returnScore() -> Int{
        cardsModel.returnScore()
    }
    
    func isGameDone() -> Bool{
        return cardsModel.isGameDone
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        cardsModel.choose(card)
    }
    
    func chooseTheme(_ theme: ThemeHolder.Theme<String>){
        themesModel.chooseActualTheme(theme)
        EmojisMemoryGame.actualTheme = theme
        cardsModel = EmojisMemoryGame.createMemoryGame()
    }
    
    func getActualTheme() -> ThemeHolder.Theme<String>?{
        themesModel.getActualTheme()
    }
    
}
