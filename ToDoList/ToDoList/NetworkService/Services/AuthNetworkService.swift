//
//  AuthManager.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth

class AuthNetworkService: AuthNetworkServiceProtocol {
    static var currentUser: UserModel? {
        get {
            if let user = Auth.auth().currentUser {
                return UserModel(uid: user.uid, email: user.email!, displayName: user.displayName)
            }
            return nil
        }
    }
    
    func handleAuthState(_ onCompletion: @escaping (Result<UserModel, ResultErrors>) -> Void) {
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if let user = user {
                onCompletion(.success(UserModel(uid: user.uid, email: user.email!, displayName: user.displayName)))
            } else {
                onCompletion(.failure(ResultErrors.unknown))
            }
        }
    }
}
