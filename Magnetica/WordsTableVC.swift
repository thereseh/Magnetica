//
//  WordsTableVC.swift
//  Magnetica
//
//  Created by Therese Henriksson on 2/18/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

class WordsTableVC: UITableViewController {
    
    var wordThemes:[String] = []
    var selectedWordTheme:String = "theme1"
    var wordManager: WordBank!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordManager = WordBank()
        for wordTheme in wordManager.wordBank {
            
            wordThemes.append(wordTheme.name)
       }
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wordThemes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = wordThemes[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordTheme = wordThemes[indexPath.row]
        
        let nCenter = NotificationCenter.default
            
        let data = ["Theme": selectedWordTheme]
        
        for wordTheme in wordManager.wordBank {
            
            if (wordTheme.name == selectedWordTheme) {
                let data = ["Theme": wordTheme.value]
                nCenter.post(name: myWordThemeChangedNotification, object: self, userInfo: data)
            }
        }
        
        cancelTapped(sender: self)
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    


}
