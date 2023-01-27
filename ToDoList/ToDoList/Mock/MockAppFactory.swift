//
//  MockAppFactory.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class MockAppFactory: AppFactoryProtocol {
    static func loginViewController() -> LoginViewController {
        let viewModel = LoginViewModel(MockNetworkService.instance)
        let controller = LoginViewController(viewModel: viewModel)
        controller.router = MockAppRouter(controller)
        
        return controller
    }
    
    static func registerViewController(router: RouterProtocol) -> RegisterationViewController {
        let viewModel = RegisterationViewModel(MockNetworkService.instance)
        let controller = RegisterationViewController(viewModel: viewModel)
        controller.router = router
        
        return controller
    }
    
    static func tasksListViewController() -> TasksListViewController {
        let viewModel = TasksListViewModel(MockNetworkService.instance, MockNetworkService.instance, MockNetworkService.instance)
        let controller = TasksListViewController(viewModel: viewModel)
        controller.router = MockAppRouter(controller)

        return controller
    }
    
    static func saveTaskViewController(router: RouterProtocol, taskViewModel: TaskViewModel?) -> SaveTaskViewController {
        let viewModel = SaveTaskViewModel(MockNetworkService.instance, taskModel: taskViewModel?.taskModel)
        let controller = SaveTaskViewController(viewModel: viewModel)
        controller.router = router
        
        return controller
    }
}

