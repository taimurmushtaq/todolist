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
    var registrationSuccessful = Observable(false)
    var registrationFailed = Observable("")
    
    //MARK: - Properties
    private let networkService: RegisterationNetworkServiceProtocol
    
    init(_ networkService: RegisterationNetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension RegisterationViewModel {
    func performValidation() {
        if email.value.isEmpty || !ValidationManager.isValidEmail(email.value) {
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
            case .success(_):
                registrationSuccessful.value.toggle()
            case .failure(let error):
                registrationFailed.value = error.localizedDescription
            }
        })
    }
}
