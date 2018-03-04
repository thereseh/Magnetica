//
//  WordBank.swift
//  Magnetica
//
//  Created by Therese Henriksson and Lydia Wu on 2/19/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import Foundation

class WordBank {
    
    // dictionary
    var wordBank = [String: [WordModel]]()
    
    init() {
        initWordThemes()
    }
    
    // functions
    func initWordThemes() {
        let strings1: [String] = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
        let strings2: [String] = ["she", "sinister", "smart", "so", "soft", "some", "source", "space"]
        let strings3: [String] = ["good", "goodness", "grease", "has", "have", "he", "hear", "heart", "her"]
        let strings4: [String] = ["Star Wars"]
        let icons: [String] = ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿","😾", "😀", "😁", "😂", "🤣","😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎", "😍", "😘", "😗", "😙", "😚", "☺️", "🙂", "🤗", "🤔", "😐", "😑", "😶", "🙄", "😏", "😣", "😥"]
        
        let theme1: [WordModel] = createWordModelArrays(array: strings1)
        let theme2: [WordModel] = createWordModelArrays(array: strings2)
        let theme3: [WordModel] = createWordModelArrays(array: strings3)
        let theme4: [WordModel] = createWordModelArrays(array: strings4)
        let emojis: [WordModel] = createWordModelArrays(array: icons)
    
        
        wordBank["Harry Potter"] = theme1
        wordBank["Marvel"] = theme2
        wordBank["Overwatch"] = theme3
        wordBank["Star Wars"] = theme4
        wordBank["Emojis"] = emojis
    }
    
    func createWordModelArrays(array: [String]) -> [WordModel] {
        var arrayOfWordModelObjects = [WordModel]()
        for word in array {
            arrayOfWordModelObjects.append(WordModel(word: word))
        }
        return arrayOfWordModelObjects
    }
}
