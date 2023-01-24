//
//  CommonModules.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

struct UserModel: Codable {
    let email: String
    let password: String
}

extension UserModel: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.email == rhs.email
    }
}
