//
//  AppFactory.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class AppFactory: AppFactoryProtocol {
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
    
    static func tasksListViewController() -> TasksListViewController {
        let viewModel = TasksListViewModel(TasksNetworkService(), SaveTaskNetworkService(), AuthNetworkService())
        let controller = TasksListViewController(viewModel: viewModel)
        controller.router = AppRouter(controller)

        return controller
    }
    
    static func saveTaskViewController(router: RouterProtocol, taskViewModel: TaskViewModel?) -> SaveTaskViewController {
        let viewModel = SaveTaskViewModel(SaveTaskNetworkService(), taskModel: taskViewModel?.taskModel)
        let controller = SaveTaskViewController(viewModel: viewModel)
        controller.router = router
        
        return controller
    }
}
