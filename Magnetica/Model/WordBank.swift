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
        let strings1: [String] = ["&", "And", "Are", "the","is", "will", "have","be","has","and", "at", "did", "about", "does", "do", "am", "I", "you", "but","so", "such", "to", "too", "then", "was", "were", "had", "which", "would", "his","your", "my", "her", "yours", "mine", "already", "been", "as", "could", "play", "come", "came", "s", "can", "love", "hate", "dead", "back", "death", "die", "fought", "fight", "with", "by","hero", "world", "win", "lose", "friend", "school", "wizard", "witch", "magic", "animal", "beast", "chamber", "sorcerer", "stone", "Azkaban", "goblet", "deathly", "wand", "invisibility", "brooms", "horcrux", "galleon", "Howler", "Quidditch", "elder", "station", "Resurrection", "Hogwarts", "Gryffindor", "lion", "Slytherin", "snake", "Ravenclaw", "hawk", "Hufflepuff", "badger", "yellow", "blue", "green", "silver", "red", "black", "dairy", "secret", "sorting", "hat", "cup", "potion", "Voldemort", "Lord"]
        let strings2: [String] = ["&", "and", "are", "the", "is", "will", "have", "be", "has", "and", "at", "did", "about", "does", "do", "am", "I", "you", "but", "so", "such", "to", "too", "then", "was", "were", "had", "which", "would", "his", "your", "my", "her", "yours", "mine", "already", "been", "girl", "boy", "spider", "Spiderman","Iron", "man", "fly", "could", "come", "came", "s", "can", "red", "black", "white", "blue", "Captain", "America", "Winter",  "Soldier", "Deadpool", "Cable","Hulk", "Thor", "Loki", "Widow", "X", "Professor", "Magneto", "Quicksilver", "Scarlet", "Witch", "Vision", "Gambit", "Beast", "Storm", "Wolverine", "love", "hate", "dead", "Death", "die", "fought", "fight", "college", "student", "power", "STARK", "Doctor", "weapon", "suit", "Strange", "Panther", "Earth", "Civil", "War", "universe", "with", "by", "Super", "hero", "Shield", "gone", "this", "save", "world", "Gwen"]
        let strings3: [String] = ["&", "and", "are", "the", "is", "will", "have", "be", "has", "and", "at", "did", "about", "does", "do", "am", "I", "you", "but", "so", "such", "to", "too", "then", "was", "were", "had", "which", "would", "his", "your", "my", "her", "yours", "mine", "already", "been", "as", "could", "play", "come", "came", "s", "can", "love", "hate", "dead", "back", "die", "fought", "fight", "with", "by", "hero", "world", "win", "lose", "Mercy", "Genji", "Hanzo", "Reaper", "Soldier", "76", "Tracer", "Widowmaker", "D.Va", "Mei", "Winston", "Doomfist", "Bastion", "Orisa", "Torbjorn", "Junkrat", "Roadhog", "Zarya", "Winston", "Ana", "Lucio", "Moria", "Zenyatta", "Symmetra", "China", "Japan", "in", "on", "USA", "Jack", "Morrison", "Gabriel", "Reye", "Talon", "Jesse", "McCree", "Shimada", "Pharah", "Amari", "Egypt", "Australia", "Russia", "Reinhardt", "Germany","aiming", "payload"]
        let strings4: [String] = ["&", "and", "are", "than", "is", "will", "have", "be", "has","and", "at", "did", "about", "does", "do", "am", "I", "you", "but", "so", "such", "to", "too", "then", "was", "were", "had", "which”", "would", "his", "your", "my", "her", "yours", "mine", "already", "been", "girl", "boy", "man", "woman", "s", "space", "ship", "Darth", "Vader", "Skywalker", "Luke", "Anakin", "hate", "love", "dead", "Death", "die", "fought", "fight", "Millennium", "Falcon", "come", "came", "student", "s", "weapon", "suit", "Han", "Solo", "Rogue", "One", "white", "silver", "black", "Leia", "Stormtrooper", "Force", "with", "may", "the", "Jedi", "sit", "Kylo", "Ren", "Ray", "Obi", "Wan", "Kenobi", "Qui", "Gon", "Jinn", "go", "goes", "went", "Republic", "galaxy", "star", "war"]

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
