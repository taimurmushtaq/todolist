//
//  BindingTextField.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import UIKit

class BindingTextField: PaddingTextField {
    //MARK: - Variables
    var textChanged: (String) -> Void = { _ in }
    var didEndEditing: () -> Void = { }
    
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
extension BindingTextField {
    func configureSelectors() {
        addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    func configureUI() {
        roundCorners(radius: 8, borderWidth: 1, borderColor: isEnabled ? UIColor.accentColor : UIColor.disableColor)
        clearButtonMode = .whileEditing
    }
    
    func bind(callback: @escaping (String) -> Void) {
        textChanged = callback
    }
    func bindEndEditing(callback: @escaping () -> Void) {
        didEndEditing = callback
    }
}

//MARK: - Textfield Events
extension BindingTextField {
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if let text = textField.text {
            textChanged(text)
        }
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        didEndEditing()
    }
}
