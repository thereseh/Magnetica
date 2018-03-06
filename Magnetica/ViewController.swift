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
let removeBackgroundImageNotification = NSNotification.Name("removeBackgroundImageNotification")


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
    var draggedLabels: [UILabel] = []
    
    var saveTimer: Timer!
    
    // Outlets
    @IBOutlet weak var labelHolderView: UIView!
    @IBOutlet weak var moreLabelsButton: UIButton!
    @IBOutlet weak var hideLabelHolderView: UIButton!
    @IBOutlet weak var trashcanButton: UIButton!
    
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
        nCenter.addObserver(self, selector: #selector(removeBackgroundImage), name: removeBackgroundImageNotification, object: nil)
        
        saveTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(timedSave), userInfo: nil, repeats: true)
        
        setLabelViewSize()
        placeWords()
        drawLabelsOnView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveTimer.invalidate()
    }
    
    //MARK: - Cleanup -
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // IBActions
    @IBAction func getMoreLabels(_ sender: UIButton) {
        clearScreen()
        placeWords()
    }
    
    @IBAction func hideAndShowLabelView(_ sender: Any) {
        // Animations to hide and display the view containing the words
        // also toggles the image used in the show/hide button
        
        if labelViewIsHidden {
            labelViewIsHidden = false
            UIView.animate(withDuration: 0.8, animations: {
                
                self.labelHolderView.frame.size.height = (super.view.frame.height / 4.0)
                self.moreLabelsButton.center.y = (super.view.frame.height / 4.0) + 32 + self.moreLabelsButton.frame.height
                self.hideLabelHolderView.center.y = (super.view.frame.height / 4.0) + 32 + self.moreLabelsButton.frame.height
                
            }, completion: {finished in
                
                self.hideLabelHolderView.setBackgroundImage(UIImage(named: "hideButton"), for: .normal)
                self.placeWords()
                self.moreLabelsButton.isHidden = false
                
            })
            
        } else {
            clearScreen()
            labelViewIsHidden = true
            UIView.animate(withDuration: 0.8, animations: {
                
                self.labelHolderView.frame.size.height = 20
                self.moreLabelsButton.center.y = 20 + 32 + self.moreLabelsButton.frame.height
                self.hideLabelHolderView.center.y = 20 + 32 + self.moreLabelsButton.frame.height
                self.moreLabelsButton.isHidden = true
                
            }, completion: {finished in
                self.hideLabelHolderView.setBackgroundImage(UIImage(named: "showButton"), for: .normal)
            })
        }
    }
    
    @IBAction func share(_ sender: AnyObject) {
        let image = self.view.takeSnapshot()
        let textToShare = "Look at this poem that I made, just for you!\n"
        let igmWebsite = NSURL(string: "http://igm.rit.edu/")
        let objectsToShare:[AnyObject] = [textToShare as AnyObject, igmWebsite!, image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        
        activityVC.popoverPresentationController?.sourceView = self.view
        
        let popoverMenuViewController = activityVC.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .any
        popoverMenuViewController?.barButtonItem = sender as? UIBarButtonItem
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    
    //MARK - Draw Action functions -
    func placeWords() {
        
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
        
        let wordsInSelectedTheme:[WordModel] = wordManager.wordBank[magneticaVC.selectedTheme]!
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
            
            addDropShadowHelper(label: currentLabel)
            
            currentLabel.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
            currentLabel.addGestureRecognizer(panGesture)
            count += 1
        }
        
    }
    
    func drawLabelsOnView() {
        for label in magneticaVC.wordPosition {
            addDropShadowHelper(label: label)
            view.addSubview(label)
        }
    }
    
    
    //MARK: - Helper methods -
    func copyDraggedLabel(label: UILabel) {
        // Takes a label from the label view and creates a copy
        // to be drawn on the main view
        let copyLabel = label.createCopy()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(doPanGesture))
        
        // add drag gesture to new copy
        copyLabel.addGestureRecognizer(panGesture)
        
        addDropShadowHelper(label: copyLabel)
        magneticaVC.wordPosition.append(copyLabel)
        
        view.addSubview(copyLabel)
        
        // remove original label
        label.removeFromSuperview()
    }
    
    func resetTimer() {
        saveTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(timedSave), userInfo: nil, repeats: true)
    }
    
    func addDropShadowHelper(label: AnyObject) {
        // add dropshadow
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 1.0
        label.layer.shadowOpacity = 0.8
        label.layer.shadowOffset = CGSize(width:1, height: 1)
        label.layer.masksToBounds = false
    }
    
    func clearScreen() {
        for v in labelHolderView.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }
        }
    }
    
    func setLabelViewSize() {
        
        labelHolderView.frame = CGRect(x: 0, y: 32, width: view.frame.width, height: (view.frame.height / 4.0))
        
        addDropShadowHelper(label: labelHolderView)
        
        
        // make buttons bigger if iPad
        if isPad {
            let size = moreLabelsButton.frame.size.height + 8
            moreLabelsButton.frame.size = CGSize(width: size, height: size)
            hideLabelHolderView.frame.size = CGSize(width: size, height: size)
            trashcanButton.frame.size = CGSize(width: size, height: size)
            
        }
        
        let xPos = view.frame.width - moreLabelsButton.frame.width
        let yPos = (view.frame.height / 4.0) + 32 + moreLabelsButton.frame.height
        
        // Set position of buttons
        moreLabelsButton.center = CGPoint(x: xPos, y: yPos)
        hideLabelHolderView.center = CGPoint(x: xPos - hideLabelHolderView.frame.width * 2, y: yPos)
        trashcanButton.center = CGPoint(x: 32, y: view.frame.size.height - 44 - trashcanButton.frame.size.height)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showThemeSegue" {
            let wordsVC = segue.destination.childViewControllers[0] as! WordsTableVC
            wordsVC.title = "Choose a theme"
        }
        
        if segue.identifier == "showSettingsSegue" {
        }
    }
    
    @objc func timedSave() {
        magneticaVC.save()
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
    }
    
    @objc func updateFontSize(n:Notification) {
        let data = n.userInfo!
        magneticaVC.fontSize = data["Size"] as! Int
    }
    
    @objc func updateBackgroundColor(n:Notification) {
        let data = n.userInfo!
        
        magneticaVC.backgroundColor = (data["Color"] as! UIColor)
    }
    
    @objc func updateTheme(n:Notification) {
        let data = n.userInfo!
        magneticaVC.selectedTheme = (data["Theme"] as! String)
        print(magneticaVC.selectedTheme)
        updateScreen()
    }
    
    @objc func updateScreen() {
        magneticaVC.saveSettings()
        clearScreen()
        placeWords()
    }
    
    @objc func removeBackgroundImage() {
        magneticaVC.hasBackgroundImage = false
        (self.view as! UIImageView).image = nil
    }
    
    //MARK: - GestureRecognizer-
    @objc func doPanGesture(panGeture:UIPanGestureRecognizer) {
        let label = panGeture.view as! UILabel
        let position = panGeture.location(in: view)
        label.center = position
        
        if panGeture.state == UIGestureRecognizerState.ended {
            
            if label.superview == labelHolderView {
                if position.y > labelHolderView.frame.height + label.frame.size.height {
                    copyDraggedLabel(label: label)
                    
                }
            }
            
            // remove label if over trashcan on release
            if label.superview == view {
                if position.x <= trashcanButton.center.x + (trashcanButton.frame.size.width/2) &&
                    position.x >= trashcanButton.center.x - (trashcanButton.frame.size.width/2) &&
                    position.y <= trashcanButton.center.y + (trashcanButton.frame.size.height/2) &&
                    position.y >= trashcanButton.center.y - (trashcanButton.frame.size.height/2) {
                    label.removeFromSuperview()
                }
            }
        }
        
        // when dragging, animate trashcan button
        if label.superview == view {
            
            if position.x <= trashcanButton.center.x + (trashcanButton.frame.size.width/2) &&
                position.x >= trashcanButton.center.x - (trashcanButton.frame.size.width/2) &&
                position.y <= trashcanButton.center.y + (trashcanButton.frame.size.height/2) &&
                position.y >= trashcanButton.center.y - (trashcanButton.frame.size.height/2) {
                trashcanButton.shake()
            }
            
            
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

extension UILabel {
    func createCopy() -> UILabel {
        let archivedData = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: archivedData) as! UILabel
    }
}


// http://seanallen.co/posts/uibutton-animations
extension UIButton {
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true

        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue

        layer.add(shake, forKey: "position")
    }
}

