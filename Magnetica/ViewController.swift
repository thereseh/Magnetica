//
//  MainViewController.swift
//  Magnetica
//
//  Created by Therese Henriksson and Yanchun Wu on 2/5/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit
let myWordThemeChangedNotification = NSNotification.Name("themeChangedNotification")
let isPad = UIDevice.current.userInterfaceIdiom == .pad

class ViewController: UIViewController {
    
    var prevWord = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("main viewDidLoad")
        prevWord.append(0)
        prevWord.append(0)
        
        let nCenter = NotificationCenter.default
        nCenter.addObserver(self, selector: #selector(updateScreen), name: myWordThemeChangedNotification, object: nil)
        
       // placeWords(theme: "theme1"
    }
    
    //MARK: - Cleanup -
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func placeWords(theme: [String]) {
        view.backgroundColor = UIColor.orange
        
        let margin: CGFloat = 40
        let width: CGFloat = view.frame.width - margin

        var count: CGFloat = 0
        var row: CGFloat = 0
        
        //var currentWords:[String]! = []
        
        for word in theme {
            let currentLabel = UILabel()
            currentLabel.backgroundColor = UIColor.white
            currentLabel.text = word
            currentLabel.sizeToFit()
            
            // resize the labels
            currentLabel.frame.size.height = 30
            currentLabel.frame.size.width = currentLabel.frame.size.width + 15
            
            var x: CGFloat = 0
            var y: CGFloat = 0
            
            if count == 0 {
                
                x = margin + ( currentLabel.frame.size.width / 2 )
                y = margin
                
            } else {
                // (previous X position) + (half width of previous word) + (half width of current word)
                // would place each word next to each other, then add 10 units of space
                let nextSize: CGFloat = ( ( prevWord[0] + ( prevWord[1] / 2 ) ) + ( currentLabel.frame.size.width / 2 ) ) + 15
                
                // if it's more than width, then wrap around again
                if nextSize > CGFloat( width ) {
                    
                    x = margin + ( currentLabel.frame.size.width / 2 )
                    row = row + 1.0
                    
                } else {
                    x = nextSize
                }

                y = margin + ( currentLabel.frame.size.height * row ) + ( 15 * row )
        
            }
            
            // add current word into array for next word to use
            prevWord[0] = x
            prevWord[1] = currentLabel.frame.size.width

            currentLabel.center = CGPoint( x:x, y:y )
            currentLabel.textAlignment = .center
            view.addSubview(currentLabel)
            
            // add dropshadow
            currentLabel.layer.shadowColor = UIColor.black.cgColor
            currentLabel.layer.shadowRadius = 1.0
            currentLabel.layer.shadowOpacity = 0.8
            currentLabel.layer.shadowOffset = CGSize(width:1, height: 1)
            currentLabel.layer.masksToBounds = false
            
            currentLabel.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            currentLabel.addGestureRecognizer(panGesture)
            count += 1
        }
    }
    
    // MARK: - Notifications -
    @objc func updateScreen(n:Notification) {
        print("updateScreen called")
        let data = n.userInfo!
        
        let currentTheme:[String] = data["Theme"] as! [String]
        print(currentTheme)
        clearScreen()
        
        placeWords(theme: currentTheme)
    }
    
    func clearScreen() {
        for v in view.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue" {
            let wordsVC = segue.destination.childViewControllers[0] as! WordsTableVC
            wordsVC.title = "Choose a theme"
        }
    }
    
    @objc func doPanGesture(panGeture:UIPanGestureRecognizer) {
        let label = panGeture.view as! UILabel
        let position = panGeture.location(in: view)
        label.center = position
    }

}

