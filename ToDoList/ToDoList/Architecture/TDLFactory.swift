//
//  TDLFactory.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

enum TDLFactory {
    static func RegisterViewController() -> TDLRegistrationViewController {
        return TDLRegistrationViewController()
    }
}
