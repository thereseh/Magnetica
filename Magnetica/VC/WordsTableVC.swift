//
//  WordsTableVC.swift
//  Magnetica
//
//  Created by Therese Henriksson and Lydia Wu on 2/18/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

class WordsTableVC: UITableViewController {
    
    var listOfThemesToDisplay:[String] = []
    var selectedWordTheme:String = "Harry Potter"
    var wordManager: WordBank!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordManager = WordBank()
        
        listOfThemesToDisplay = Array(wordManager.wordBank.keys)
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listOfThemesToDisplay.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeIdentifier", for: indexPath)
        
        cell.textLabel?.text = listOfThemesToDisplay[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordTheme = listOfThemesToDisplay[indexPath.row]
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneTapped(sender: AnyObject) {
        let nCenter = NotificationCenter.default
        
        let data = ["Theme": wordManager.wordBank[selectedWordTheme]!]

        nCenter.post(name: myWordThemeChangedNotification, object: self, userInfo: data)

        dismiss(animated: true, completion: nil)
    }
    
}
