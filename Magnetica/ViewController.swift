//
//  MainViewController.swift
//  Magnetica
//
//  Created by Therese Henriksson and Lydia Wu on 2/5/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit
let myWordThemeChangedNotification = NSNotification.Name("themeChangedNotification")
let backgroundImageChangedNotification = NSNotification.Name("backgroundImageChangedNotification")
let fontStyleChangedNotification = NSNotification.Name("fontStyleChangedNotification")
let fontSizeChangedNotification = NSNotification.Name("fontSizeChangedNotification")
let backgroundColorChangedNotification = NSNotification.Name("backgroundColorChangedNotification")
let updateScreenNotification = NSNotification.Name("updateScreenNotification")

let isPad = UIDevice.current.userInterfaceIdiom == .pad

class ViewController: UIViewController {
    
    // ivar
    var previousLabel = [CGFloat]()
    var prevLabelXPos:CGFloat = 0
    var prevLabelWidth:CGFloat = 0
    var prevLabelYPos:CGFloat = 0
    
    var wordManager: WordBank!
    var magneticaVC: MagneticaVC!
    
    var backgroundImage:UIImage?
    var backgroundColor:UIColor?
    
    var fontStyle: String = ""
    var fontSize: Int = 0
    var labelViewIsHidden = false
    
    var currentTheme: [WordModel] = []
    
    // Outlets
    @IBOutlet weak var labelHolderView: UIView!
    @IBOutlet weak var moreLabelsButton: UIButton!
    @IBOutlet weak var hideLabelHolderView: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordManager = WordBank()
        
        assert(magneticaVC != nil, "MagneticaVC must be set before using property via dependency injection")
        
        
        let nCenter = NotificationCenter.default
        nCenter.addObserver(self, selector: #selector(updateScreen), name: updateScreenNotification, object: nil)
        nCenter.addObserver(self, selector: #selector(updateBackground), name: backgroundImageChangedNotification, object: nil)
        nCenter.addObserver(self, selector: #selector(updateFontStyle), name: fontStyleChangedNotification, object: nil)
        nCenter.addObserver(self, selector: #selector(updateFontSize), name: fontSizeChangedNotification, object: nil)
        nCenter.addObserver(self, selector: #selector(updateBackgroundColor), name: backgroundColorChangedNotification, object: nil)
        nCenter.addObserver(self, selector: #selector(updateTheme), name: myWordThemeChangedNotification, object: nil)
        
        setLabelViewSize()
        placeWords()
    }
    
    //MARK: - Cleanup -
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func placeWords() {
        print(#function)
        if magneticaVC.hasBackgroundImage {
            magneticaVC.backgroundColor = UIColor.clear
            let image: UIImage? = magneticaVC.backgroundImage
            (self.view as! UIImageView).contentMode = .scaleAspectFill
            (self.view as! UIImageView).image = image
        } else {
            view.backgroundColor = magneticaVC.backgroundColor
        }
        
        if magneticaVC.backgroundColor == UIColor.lightGray  {
           labelHolderView.backgroundColor = UIColor.darkGray
        } else {
           labelHolderView.backgroundColor = UIColor.lightGray
        }
        
        let wordsInSelectedTheme:[WordModel] = wordManager.wordBank[Constants.MagneticaConstants.defaultTheme]!
        let margin: CGFloat = 40
        let currentLabelwidth: CGFloat = labelHolderView.frame.width - margin

        var count: CGFloat = 0
        var row: CGFloat = 0
        
        var currLabelXPos: CGFloat = 0
        var currLabelYPos: CGFloat = 0
        
        while prevLabelYPos + 10 < labelHolderView.frame.height - margin/2 {
            let currentLabel = UILabel()
            currentLabel.backgroundColor = UIColor.white
            currentLabel.text = wordsInSelectedTheme.randomItem()?.word
            currentLabel.font = UIFont(name: magneticaVC.fontStyle, size: CGFloat(magneticaVC.fontSize))
            currentLabel.sizeToFit()
            
            // resize the labels
            currentLabel.frame.size.height = CGFloat(magneticaVC.fontSize + 10)
            currentLabel.frame.size.width = currentLabel.frame.size.width + 15
            
            if count == 0 {
                
                currLabelXPos = margin + ( currentLabel.frame.size.width / 2 )
                currLabelYPos = margin + 10
                
            } else {
                // (previous X position) + (half width of previous word) + (half width of current word)
                // would place each word next to each other, then add 10 units of space
                let nextSize: CGFloat = ((prevLabelXPos + (prevLabelWidth / 2)  + (currentLabel.frame.size.width / 2))) + 15
                
                // if it's more than width, then wrap around again
                if nextSize + 10 > CGFloat(currentLabelwidth) {
                    
                    currLabelXPos = margin + (currentLabel.frame.size.width / 2)
                    row = row + 1.0
                    
                } else {
                    currLabelXPos = nextSize
                }
                
                currLabelYPos = margin + 10 + (currentLabel.frame.size.height * row) + (15 * row)
                
                // just one extra catch
                if currLabelYPos + 10 > labelHolderView.frame.height - margin/2 {
                    break
                }
                
            }
            
            // add current word into array for next word to use
            prevLabelXPos = currLabelXPos
            prevLabelWidth = currentLabel.frame.size.width
            prevLabelYPos = currLabelYPos
            
            currentLabel.center = CGPoint( x:currLabelXPos, y:currLabelYPos )
            currentLabel.textAlignment = .center
            labelHolderView.addSubview(currentLabel)
            
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
    
    func setLabelViewSize() {
        
        labelHolderView.frame = CGRect(x: 0, y: 32, width: view.frame.width, height: (view.frame.height / 4.0))
        
        let xPos = view.frame.width - moreLabelsButton.frame.width
        let yPos = (view.frame.height / 4.0) + 32 + moreLabelsButton.frame.height
        
        // Set position of buttons
        moreLabelsButton.center = CGPoint(x: xPos, y: yPos)
        hideLabelHolderView.center = CGPoint(x: xPos - hideLabelHolderView.frame.width * 2, y: yPos)
        hideLabelHolderView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        
        // Style them
        moreLabelsButton.backgroundColor = UIColor.white
        hideLabelHolderView.backgroundColor = UIColor.white
        
        moreLabelsButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        moreLabelsButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        moreLabelsButton.layer.shadowOpacity = 1.0
        moreLabelsButton.layer.shadowRadius = 0.5
        
        hideLabelHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        hideLabelHolderView.layer.shadowOffset = CGSize(width: -1, height: 1)
        hideLabelHolderView.layer.shadowOpacity = 1.0
        hideLabelHolderView.layer.shadowRadius = 0.5
        
    }
    
    func clearScreen() {
        for v in labelHolderView.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Notifications -
    @objc func updateBackground(n:Notification) {
        var data = n.userInfo!
        
        let image:UIImage = data[UIImagePickerControllerEditedImage] as! UIImage
        
        magneticaVC.backgroundImage = image
        magneticaVC.hasBackgroundImage = true
        
        updateScreen()
    }
    
    
    @objc func updateFontStyle(n:Notification) {
        let data = n.userInfo!
        
        magneticaVC.fontStyle = data["Style"] as! String
        
        print("Fontstyle: \(fontStyle)")
    }
    
    @objc func updateFontSize(n:Notification) {
        let data = n.userInfo!
        magneticaVC.fontSize = data["Size"] as! Int
        
        print("Size: \(fontSize)")
    }
    
    @objc func updateBackgroundColor(n:Notification) {
        let data = n.userInfo!
        
        magneticaVC.backgroundColor = (data["Color"] as! UIColor)
    }
    
    @objc func updateTheme(n:Notification) {
        let data = n.userInfo!
        magneticaVC.selectedTheme = (data["Theme"] as! String)
        
        updateScreen()
    }
    
    @objc func updateScreen() {
        magneticaVC.saveSettings()
        clearScreen()
        placeWords()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue" {
            let wordsVC = segue.destination.childViewControllers[0] as! WordsTableVC
            wordsVC.title = "Choose a theme"
        }
        
        if segue.identifier == "showSettingsSegue" {
        }
    }
    
    
    
    @objc func doPanGesture(panGeture:UIPanGestureRecognizer) {
        let label = panGeture.view as! UILabel
        let position = panGeture.location(in: view)
        label.center = position
    }
    
    // IBActions
    @IBAction func getMoreLabels(_ sender: UIButton) {
        clearScreen()
        placeWords()
    }
    
    @IBAction func hideAndShowLabelView(_ sender: Any) {
        if labelViewIsHidden {
            labelViewIsHidden = false
            UIView.animate(withDuration: 0.8, animations: {
                self.labelHolderView.frame.size.height = (super.view.frame.height / 4.0)
            })
            placeWords()
        } else {
            clearScreen()
            labelViewIsHidden = true
            UIView.animate(withDuration: 0.8, animations: {
                self.labelHolderView.frame.size.height = 20
            })
        }
    }
    
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

