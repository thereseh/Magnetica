//
//  MagneticaModel.swift
//  Magnetica
//
//  Created by Therese Henriksson (RIT Student) on 3/4/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

protocol MagneticaModel {
    var fontStyle: String { get set }
    var fontSize: Int { get set }
    
    var backgroundImage: UIImage? { get set }
    var backgroundColor: UIColor? { get set }
    
    var selectedTheme: String? { get set }
    var wordPosition: [String]? { get set }
    
    func save()
    func load()
}

// Objective-C naming convention for constants (start with k)
//let kfontStyleKey = "kfontStyleKey"
//let kfontSizeKey = "kfontSizeKey"
//let kfontSizeKey = "kfontSizeKey"
//let kfontSizeKey = "kfontSizeKey"

