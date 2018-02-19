//
//  WordBank.swift
//  Magnetica
//
//  Created by Therese Henriksson and Lydia Wu on 2/19/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import Foundation

class WordBank{
    var wordBank: [(name: String, value: [String])]
    
    init(){
        wordBank = []
        initWordThemes()
    }
    
    func initWordThemes(){
        let theme1: [String] = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
        let emojis: [String] = ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿","😾", "😀", "😁", "😂", "🤣","😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎", "😍", "😘", "😗", "😙", "😚", "☺️", "🙂", "🤗", "🤔", "😐", "😑", "😶", "🙄", "😏", "😣", "😥"]
        let theme2: [String] = ["she", "sinister", "smart", "so", "soft", "some", "source", "space"]
        let theme3: [String] = ["good", "goodness", "grease", "has", "have", "he", "hear", "heart", "her"]
        let theme4: [String] = ["Star Wars"]
        
        
        wordBank.append((name: "Harry Potter", value: theme1))
        wordBank.append((name: "Marvel", value: theme2))
        wordBank.append((name: "Overwatch", value: theme3))
        wordBank.append((name: "Star Wars", value: theme4))
        wordBank.append((name: "emojis", value: emojis))
    }
}
