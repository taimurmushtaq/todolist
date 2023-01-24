//
//  LoginNetworkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth

protocol LoginNetworkServiceProtocol {
    func performLogin(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void)
}

protocol RegisterationNetworkServiceProtocol {
    func performRegisteration(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void)
}

class LoginNetworkService: LoginNetworkServiceProtocol {
    func performLogin(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                onCompletion(.failure(error!))
                return
            }
            
            onCompletion(.success(UserModel(email: email, password: password)))
        }
    }
}

class RegisterationNetworkService: RegisterationNetworkServiceProtocol {
    func performRegisteration(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                onCompletion(.failure(error!))
                return
            }
            
            onCompletion(.success(UserModel(email: email, password: password)))
        }
    }
}








