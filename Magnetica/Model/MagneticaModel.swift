//
//  MagneticaModel.swift
//  Magnetica
//
//  Created by Therese Henriksson and Lydia Wu on 3/4/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

protocol MagneticaModel {
    var fontStyle: String { get set }
    var fontSize: Int { get set }
    
    var backgroundImage: UIImage? { get set }
    var backgroundColor: UIColor { get set }
    
    var selectedTheme: String { get set }
    var wordPosition: [UILabel] { get set }
    
    var hasBackgroundImage: Bool { get set }
    
    func save()
    func saveSettings()
    func load()
}



