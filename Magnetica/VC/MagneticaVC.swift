//
//  MagneticaVC.swift
//  Magnetica
//
//  Created by Therese Henriksson and Lydia Wu on 3/4/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

class MagneticaVC {
    private var magneticaModel: MagneticaModel
    
    var fontStyle: String {
        get {
            return magneticaModel.fontStyle
        }
        set {
            magneticaModel.fontStyle = newValue
        }
    }
    
    var fontSize: Int {
        get {
            return magneticaModel.fontSize
        }
        set {
            magneticaModel.fontSize = newValue
        }
    }
    
    var backgroundImage: UIImage {
        get {
            return magneticaModel.backgroundImage!
        }
        set {
            magneticaModel.backgroundImage = newValue
        }
    }
    
    var hasBackgroundImage: Bool {
        get {
            return magneticaModel.hasBackgroundImage
        }
        set {
            magneticaModel.hasBackgroundImage = newValue
        }
    }
    
    var backgroundColor: UIColor {
        get {
            return magneticaModel.backgroundColor
        }
        set {
            magneticaModel.backgroundColor = newValue
        }
    }
    
    var selectedTheme: String {
        get {
            return magneticaModel.selectedTheme
        }
        set {
            magneticaModel.selectedTheme = newValue
        }
    }
    
    var wordPosition: [UILabel] {
        get {
            return magneticaModel.wordPosition
        }
        set {
            magneticaModel.wordPosition = newValue
        }
    }
    
    init(magneticaModel: MagneticaModel = MagneticaModelUserDefaults()) {
        self.magneticaModel = magneticaModel
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterBackground(_:)), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func save() {
        magneticaModel.save()
    }
    
    func saveSettings() {
        magneticaModel.saveSettings()
    }
    
    @objc func applicationWillEnterBackground(_ application: UIApplication) {
        magneticaModel.save()
    }
}
