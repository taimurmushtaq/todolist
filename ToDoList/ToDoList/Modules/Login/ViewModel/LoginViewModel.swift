//
//  LoginViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation

struct LoginViewModel {
    //MARK: - Observables
    var email = Observable("")
    var password = Observable("")
    var validateFields = Observable(false)
    
    //MARK: - Properties
    private let validator = ValidationManager()
}

extension LoginViewModel {
    func performValidation() {
        if email.value.isEmpty || !validator.isValidEmail(email.value) {
            validateFields.value = false
        } else if password.value.isEmpty {
            validateFields.value = false
        } else  {
            validateFields.value = true
        }
    }
}
