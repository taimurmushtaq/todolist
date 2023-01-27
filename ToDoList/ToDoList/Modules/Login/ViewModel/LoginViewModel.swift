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
    var signInSuccessFul = Observable(false)
    var signInFailed = Observable("")
    
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
            case .success(_):
                signInSuccessFul.value.toggle()
            case .failure(let error):
                signInFailed.value = error.localizedDescription
            }
        })
    }
}
