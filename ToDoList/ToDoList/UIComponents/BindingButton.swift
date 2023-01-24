//
//  BindingButton.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import UIKit

enum UIComponentTheme: Int{
    case filled = 0
    case empty
}

@IBDesignable
class BindingButton: UIButton {
    //MARK: - Variables
    var theme:UIComponentTheme = .filled
    var buttonPressed: () -> Void = { }
    override var isEnabled: Bool { didSet { configureUI() } }
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSelectors()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureSelectors()
        configureUI()
    }
}

//MARK: - Helper Methods
extension BindingButton {
    func configureSelectors() {
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    func configureUI() {
        if isEnabled {
            if theme == .filled {
                setTitleColor(.white, for: .normal)
                backgroundColor = .accentColor
            } else {
                setTitleColor(.accentColor, for: .normal)
                backgroundColor = .white
            }
            
            roundCorners(radius: 8, borderWidth: 1, borderColor: .accentColor)
        } else {
            if theme == .filled {
                setTitleColor(.darkGray, for: .normal)
                backgroundColor = .lightGray
            } else {
                setTitleColor(.darkGray, for: .normal)
                backgroundColor = .white
            }
            
            roundCorners(radius: 8, borderWidth: 1, borderColor: .lightGray)
        }
    }
    
    func bind(callback: @escaping () -> Void) {
        buttonPressed = callback
    }
}

//MARK: - Button Events
extension BindingButton {
    @objc func didTap(_ textField: UITextField) {
        buttonPressed()
    }
}
