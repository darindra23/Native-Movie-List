//
//  UIView.swift
//  Native Movie List
//
//  Created by Darindra R on 24/07/21.
//

import UIKit

extension UIView {
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

}
