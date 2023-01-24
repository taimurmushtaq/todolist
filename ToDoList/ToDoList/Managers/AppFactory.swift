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
    static func registerViewController(router: RouterProtocol) -> RegisterationViewController
}

class AppFactory: AppFactoryProtocol {
    static func navigationController() -> UINavigationController {
        let navController = UINavigationController()
        navController.modalPresentationStyle = .fullScreen
        return navController
    }
    
    static func loginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(LoginNetworkService())
        let controller = LoginViewController(viewModel: viewModel)
        controller.router = AppRouter(controller)
        
        return controller
    }
    
    static func registerViewController(router: RouterProtocol) -> RegisterationViewController {
        let viewModel = RegisterationViewModel(RegisterationNetworkService())
        let controller = RegisterationViewController(viewModel: viewModel)
        controller.router = router
        
        return controller
    }
}

