//
//  AppFactory.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

protocol AppFactoryProtocol {
    static func navigationController() -> UINavigationController
    static func registerViewController() -> RegistrationViewController
}

class AppFactory: AppFactoryProtocol {
    static func navigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.modalPresentationStyle = .fullScreen
        return navController
    }
    
    static func registerViewController() -> RegistrationViewController {
        let viewModel = RegisterationViewModel()
        return RegistrationViewController(viewModel: viewModel)
    }
}

