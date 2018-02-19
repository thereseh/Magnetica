//
//  ViewController.swift
//  Magnetica
//
//  Created by Therese Henriksson and Yanchun Wu on 2/5/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write","while"]
    
    var prevWord = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prevWord.append(0)
        prevWord.append(0)
        
        placeWords()
       
    }
    
    func placeWords() {
        view.backgroundColor = UIColor.orange
        let margin: CGFloat = 40
        let width: CGFloat = view.frame.width - margin

        var count: CGFloat = 0
        var row: CGFloat = 0
        
        for word in words {
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
    
    @objc func doPanGesture(panGeture:UIPanGestureRecognizer) {
        let label = panGeture.view as! UILabel
        let position = panGeture.location(in: view)
        label.center = position
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue" {
            let wordsVC = segue.destination.childViewControllers[0] as! WordsTableVC
            wordsVC.title = "Choose a theme"
        }
    }



}

