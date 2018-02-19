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
    let wordManager = WordBank()
    var selectedWordTheme:String = "theme1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        let currentTuple = wordThemes[indexPath.row]
        
        let currentTupleName = currentTuple
        
        cell.textLabel?.text = currentTupleName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordTheme = wordThemes[indexPath.row]
        
        let mainViewController:MainViewController? = MainViewController()
        
        mainViewController?.currentTheme = selectedWordTheme
        
        mainViewController?.updateScreen()
        print(selectedWordTheme)
        
        cancelTapped(sender:self)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }


}
