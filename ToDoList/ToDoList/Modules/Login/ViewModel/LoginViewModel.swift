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
    private let networkService: LoginNetworkServiceProtocol
    
    init(_ networkService: LoginNetworkServiceProtocol) {
        self.networkService = networkService
    }
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
    
    func performLogin() {
        networkService.performLogin(withEmail: email.value, password: password.value, onCompletion: { result in
            switch result {
            case .success(let user):
                ToastManager.showMessage("Login Successfull")
            case .failure(let error):
                ToastManager.showMessage(error.localizedDescription ?? "Some thing went wrong. Please try again")
            }
        })
    }
}
