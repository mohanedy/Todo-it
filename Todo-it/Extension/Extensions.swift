//
//  Utils.swift
//  Todo-it
//
//  Created by Mohaned Yossry on 4/18/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

//MARK: - Color Extensions
extension UIColor {
    static var random: UIColor {
            return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
        }
}



