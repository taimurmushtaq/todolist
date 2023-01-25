//
//  RegisterNetworkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth

protocol RegisterationNetworkServiceProtocol {
    func performRegisteration(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void)
}

class RegisterationNetworkService: RegisterationNetworkServiceProtocol {
    func performRegisteration(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                onCompletion(.failure(error!))
                return
            }
            
            onCompletion(.success(UserModel(uid:user.uid, email: user.email!, displayName: user.displayName)))
        }
    }
}
