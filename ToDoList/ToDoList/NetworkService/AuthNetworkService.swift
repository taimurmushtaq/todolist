//
//  AuthManager.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth

protocol AuthNetworkServiceProtocol {
    static var currentUser: UserModel? { get }
    func handleAuthState(_ onCompletion: @escaping (Result<UserModel, NetworkServiceError>) -> Void)
}

class AuthNetworkService: AuthNetworkServiceProtocol {
    static var currentUser: UserModel? {
        get {
            if let user = Auth.auth().currentUser {
                return UserModel(uid: user.uid, email: user.email!, displayName: user.displayName)
            }
            return nil
        }
    }
    func handleAuthState(_ onCompletion: @escaping (Result<UserModel, NetworkServiceError>) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if let user = auth.currentUser {
                onCompletion(.success(UserModel(uid: user.uid, email: user.email!, displayName: user.displayName)))
            } else {
                onCompletion(.failure(NetworkServiceError.unknown))
            }
        }
    }
}


