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
}
