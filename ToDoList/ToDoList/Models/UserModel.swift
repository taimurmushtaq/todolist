//
//  CommonModules.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

struct UserModel: Codable {
    let uid: String
    let email: String
    let displayName: String?
}

extension UserModel: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
        hasher.combine(email)
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.uid == rhs.uid && lhs.email == rhs.email
    }
}
