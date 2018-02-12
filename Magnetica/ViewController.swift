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
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.text = word
            l.sizeToFit()
            
            // resize the labels
            l.frame.size.height = 30
            l.frame.size.width = l.frame.size.width + 15
            
            var x: CGFloat = 0
            var y: CGFloat = 0
            
            if count == 0 {
                
                x = margin + ( l.frame.size.width / 2 )
                y = margin
                
            } else {
                // (previous X position) + (half width of previous word) + (half width of current word)
                // would place each word next to each other, then add 10 units of space
                let test: CGFloat = ( ( prevWord[0] + ( prevWord[1] / 2 ) ) + ( l.frame.size.width / 2 ) ) + 15
                
                // if it's more than width, then wrap around again
                if test > CGFloat( width ) {
                    
                    x = margin + ( l.frame.size.width / 2 )
                    row = row + 1.0
                    
                } else {
                    x = test
                }

                y = margin + ( l.frame.size.height * row ) + ( 15 * row )
        
            }
            
            // add current word into array for next word to use
            prevWord[0] = x
            prevWord[1] = l.frame.size.width

            l.center = CGPoint( x:x, y:y )
            l.textAlignment = .center
            view.addSubview(l)
            
            // add dropshadow
            l.layer.shadowColor = UIColor.black.cgColor
            l.layer.shadowRadius = 1.0
            l.layer.shadowOpacity = 0.8
            l.layer.shadowOffset = CGSize(width:1, height: 1)
            l.layer.masksToBounds = false
            
            l.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            l.addGestureRecognizer(panGesture)
            count += 1
        }
    }
    
    @objc func doPanGesture(panGeture:UIPanGestureRecognizer) {
        let label = panGeture.view as! UILabel
        let position = panGeture.location(in: view)
        label.center = position
    }



}

