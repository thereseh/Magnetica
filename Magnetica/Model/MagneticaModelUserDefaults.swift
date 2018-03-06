//
//  WordBankController.swift
//  Magnetica
//
//  Created by Therese Henriksson and Lydia Wu on 2/19/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit


class MagneticaModelUserDefaults: MagneticaModel {
    let defaults: UserDefaults
    
    var fontSize: Int
    var fontStyle: String
    var backgroundColor: UIColor
    var backgroundImage: UIImage?
    var selectedTheme: String
    var wordPosition: [UILabel]?
    var hasBackgroundImage: Bool
    
    // Initializer Dependency Injection with a default value
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        defaults = userDefaults
        
        fontStyle = Constants.MagneticaConstants.defaultFontStyle
        
        if isPad {
            fontSize = Constants.MagneticaConstants.defaultFontSizeiPad
        } else {
            fontSize = Constants.MagneticaConstants.defaultFontSizeiPhone
        }
        
        backgroundColor = Constants.MagneticaConstants.defaultBackgroundColor
        backgroundImage = UIImage(color: .white)
        hasBackgroundImage = Constants.MagneticaConstants.defaultHasBackgroundImage
        
        selectedTheme = Constants.MagneticaConstants.defaultTheme
        wordPosition = Constants.MagneticaConstants.defaultWordPosition
        
        load()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func save() {
        defaults.set(selectedTheme, forKey: Constants.MagneticaConstants.kthemeKey)
        defaults.set(wordPosition, forKey: Constants.MagneticaConstants.kwordsKey)
        
    }
    
    func saveSettings() {
        print(#function)
        defaults.set(fontStyle, forKey: Constants.MagneticaConstants.kfontStyleKey)
        defaults.set(fontSize, forKey: Constants.MagneticaConstants.kfontSizeKey)
        
        defaults.setImage(image: backgroundImage, forKey: Constants.MagneticaConstants.kbackgroundImageKey)
        defaults.setColor(color: backgroundColor, forKey: Constants.MagneticaConstants.kbackgroundColorKey)
        defaults.set(hasBackgroundImage, forKey: Constants.MagneticaConstants.khasBackgroundImageKey)
        
    }
    
    func load() {
        // NOTE: defaults.integer(forKey: ) will default to 0 if key is missing
        
        // FONT SETTINGS
        if let fontStyle = defaults.value(forKey: Constants.MagneticaConstants.kfontStyleKey) as? String {
            self.fontStyle = fontStyle
        } else {
            self.fontStyle = Constants.MagneticaConstants.defaultFontStyle
        }
        
        if let fontSize = defaults.value(forKey: Constants.MagneticaConstants.kfontSizeKey) as? Int {
            self.fontSize = fontSize
        } else {
            if isPad {
                self.fontSize = Constants.MagneticaConstants.defaultFontSizeiPad
            } else {
                self.fontSize = Constants.MagneticaConstants.defaultFontSizeiPhone
            }
            
        }
        
        // BACKGROUND SETTINGS
        if let backgroundColor = defaults.colorForKey(key: Constants.MagneticaConstants.kbackgroundColorKey) {
            self.backgroundColor = backgroundColor
        } else {
            self.backgroundColor = Constants.MagneticaConstants.defaultBackgroundColor
        }
        
        if let backgroundImage = defaults.imageForKey(key: Constants.MagneticaConstants.kbackgroundImageKey) {
            self.backgroundImage = backgroundImage
        } else {
            self.backgroundImage = UIImage(color: .white)
        }
        
        if let hasBackgroundImage = defaults.value(forKey: Constants.MagneticaConstants.khasBackgroundImageKey) {
            self.hasBackgroundImage = hasBackgroundImage as! Bool
        } else {
            self.hasBackgroundImage = Constants.MagneticaConstants.defaultHasBackgroundImage
        }
        
        // SCREEN+WORDS
        if let selectedTheme = defaults.value(forKey: Constants.MagneticaConstants.kthemeKey) as? String {
            self.selectedTheme = selectedTheme
        } else {
            self.selectedTheme = Constants.MagneticaConstants.defaultTheme
        }
        
        if let wordPosition = defaults.value(forKey: Constants.MagneticaConstants.kwordsKey) as? [UILabel] {
            self.wordPosition = wordPosition
        } else {
            self.wordPosition = Constants.MagneticaConstants.defaultWordPosition
        }
        
    }

}


public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

// I got the extension from here: https://www.bobthedeveloper.io/blog/store-uicolor-with-userdefaults-in-swift
extension UserDefaults {
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)// UserDefault Built-in Method into Any?
    }
    
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        set(imageData, forKey: key)// UserDefault Built-in Method into Any?
    }
}

