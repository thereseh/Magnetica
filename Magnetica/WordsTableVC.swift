//
//  WordsTableVC.swift
//  Magnetica
//
//  Created by Therese Henriksson on 2/18/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

class WordsTableVC: UITableViewController {

    let word1:[String] = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    let word2 = ["she", "sinister", "smart", "so", "soft", "some", "source", "space"]
    let word3 = ["good", "goodness", "grease", "has", "have", "he", "hear", "heart", "her"]
    
    var wordThemes:[(name: String, value: [String])] = []
    
    var selectedWordTheme:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wordThemes.append((name: "Theme1", value: word1))
        wordThemes.append(contentsOf: [(name: "Theme2", value: word2)])
        wordThemes += [(name: "Theme3", value: word3)]
        
        selectedWordTheme = word1
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wordThemes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let currentTuple = wordThemes[indexPath.row]
        
        let currentTupleName = currentTuple.name
        
        cell.textLabel?.text = currentTupleName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordTheme = wordThemes[indexPath.row].value
        print(selectedWordTheme)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }


}
