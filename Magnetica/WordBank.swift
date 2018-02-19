//
//  WordBank.swift
//  Magnetica
//
//  Created by Therese Henriksson (RIT Student) on 2/19/18.
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
        //Word Sets
        let theme1: [String] = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
        let emojis: [String] = ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿","😾", "😀", "😁", "😂", "🤣","😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎", "😍", "😘", "😗", "😙", "😚", "☺️", "🙂", "🤗", "🤔", "😐", "😑", "😶", "🙄", "😏", "😣", "😥"]
        let theme2: [String] = ["she", "sinister", "smart", "so", "soft", "some", "source", "space"]
        let theme3: [String] = ["good", "goodness", "grease", "has", "have", "he", "hear", "heart", "her"]
        
        
        wordBank.append((name: "theme1", value: theme1))
        wordBank.append((name: "theme2", value: theme2))
        wordBank.append((name: "theme3", value: theme3))
        wordBank.append((name: "emojis", value: emojis))
    }
}
