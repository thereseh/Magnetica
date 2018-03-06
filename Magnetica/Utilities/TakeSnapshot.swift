//
//  TakeSnapshot.swift
//  Magnetica
//
//  Created by Therese Henriksson (RIT Student) on 3/5/18.
//  Copyright © 2018 Therese Henriksson. All rights reserved.
//

import UIKit

extension UIView {
    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

