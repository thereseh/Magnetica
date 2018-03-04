//
//  WordModel.swift
//  Magnetica
//
//  Created by Therese Henriksson (RIT Student) on 3/4/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import Foundation

class WordModel {
    
    var word: String?
    var xPosition: Int = 0
    var yPosition: Int = 0
    var dragged: Bool = false
    var rotation: Int = 0
    
    init(word: String) {
       self.word = word
    }
}
