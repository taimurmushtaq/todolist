//
//  RegisterationViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import FirebaseAuth

struct RegisterationViewModel {
    //MARK: - Observables
    var email = Observable("")
    var password = Observable("")
    var confirmPassword = Observable("")
    
    var validateFields = Observable(false)
    var RegisterationSuccessfull = Observable(false)
    
    //MARK: - Properties
    private let validator = ValidationManager()
    private let networkService: RegisterationNetworkServiceProtocol
    
    init(_ networkService: RegisterationNetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension RegisterationViewModel {
    func performValidation() {
        if email.value.isEmpty || !validator.isValidEmail(email.value) {
            validateFields.value = false
        } else if password.value.isEmpty || confirmPassword.value.isEmpty  || password.value != confirmPassword.value {
            validateFields.value = false
        } else  {
            validateFields.value = true
        }
    }
    
    func performRegisteration() {
        networkService.performRegisteration(withEmail: email.value, password: password.value, onCompletion: { result in
            switch result {
            case .success(let user):
                ToastManager.showMessage("Login Successfull")
            case .failure(let error):
                ToastManager.showMessage(error.localizedDescription ?? "Some thing went wrong. Please try again")
            }
        })

    }
}
