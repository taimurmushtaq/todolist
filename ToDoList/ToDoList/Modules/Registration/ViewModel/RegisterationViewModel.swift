//
//  RegisterationViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation

struct RegisterationViewModel {
    //MARK: - Observables
    var name = Observable("")
    var email = Observable("")
    var password = Observable("")
    var confirmPassword = Observable("")
    
    var validateFields = Observable(false)
    
    //MARK: - Properties
    private let validator = ValidationManager()
}

extension RegisterationViewModel {
    func performValidation() {
        if name.value.isEmpty {
            validateFields.value = false
        } else if email.value.isEmpty || !validator.isValidEmail(email.value) {
            validateFields.value = false
        } else if password.value.isEmpty || confirmPassword.value.isEmpty  || password.value != confirmPassword.value {
            validateFields.value = false
        } else  {
            validateFields.value = true
        }
    }
}
