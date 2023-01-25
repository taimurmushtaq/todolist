//
//  UIView+Extension.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat = 0, borderWidth: CGFloat, borderColor:UIColor) {
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.masksToBounds = true
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 5.0
        layer.shadowOffset = .zero
        layer.masksToBounds = false
    }
    
    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0
        layer.shadowRadius = 0
        layer.shadowOffset = .zero
        layer.masksToBounds = true
    }
}
