//
//  AppFactory.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

protocol AppFactoryProtocol {
    static func navigationController() -> UINavigationController
    static func loginViewController() -> LoginViewController
    static func registerViewController(router: RouterProtocol) -> RegistrationViewController
}

class AppFactory: AppFactoryProtocol {
    static func navigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.modalPresentationStyle = .fullScreen
        return navController
    }
    
    static func loginViewController() -> LoginViewController {
        let viewModel = LoginViewModel()
        let controller = LoginViewController(viewModel: viewModel)
        controller.router = AppRouter(controller)
        
        return controller
    }
    
    static func registerViewController(router: RouterProtocol) -> RegistrationViewController {
        let viewModel = RegisterationViewModel()
        let controller = RegistrationViewController(viewModel: viewModel)
        controller.router = router
        
        return controller
    }
}

