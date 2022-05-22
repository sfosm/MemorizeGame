//
//  Theme.swift
//  Memorize
//
//  Created by Adrian Szewczak on 22/05/2022.
//

import Foundation


struct ThemeHolder{
    private var themesList: Array<Theme<String>>
    private var actualTheme: Theme<String>?
    
    init(givenThemeList: () -> (Array<ThemeHolder.Theme<String>>)){
        themesList = givenThemeList()
    }
    
    func getThemesList() -> Array<Theme<String>>{
        return themesList
    }
    
    func getActualTheme() -> Theme<String>?{
        return actualTheme ?? nil
    }
    
    mutating func chooseActualTheme(_ theme:Theme<String>){
        actualTheme = theme
    }
    
    
    
    
    struct Theme<Content>:Identifiable{
        var id: Int
        private let themeContent: Array<Content>
        private let themeColor: String?
        private let themeName: String
        
        init(_ content: Array<Content>, color: String?, name: String, gid: Int){
            id = gid
            themeContent = content
            themeColor = color
            themeName = name
        }
        
        func getThemeContent() -> Array<Content>{
            return themeContent
        }
        
        func getThemeColor() -> String?{
            return themeColor ?? "blue"
        }
        
        func getThemeName() -> String{
            return themeName
        }
        
    }
    
}
