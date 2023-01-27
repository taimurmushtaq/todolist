//
//  MockAppRouter.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import UIKit

class MockAppRouter: RouterProtocol {
    weak var controller: UIViewController?
    
    required init(_ controller: UIViewController?) {
        self.controller = controller
    }
    
    func goBack(){
        controller?.navigationController?.popViewController(animated: true)
    }
    
    func routeToRegisteration() {
        let nextController = MockAppFactory.registerViewController(router: self)
        controller?.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func routToLogin() {
        AppWindowManager.window?.rootViewController = BaseNavigationController(rootViewController: MockAppFactory.loginViewController())
    }
    
    func routToTasks() {
        AppWindowManager.window?.rootViewController = BaseNavigationController(rootViewController: MockAppFactory.tasksListViewController())
    }
    
    func routToSaveTasks(_ taskViewModel: TaskViewModel?) {
        let nextController = MockAppFactory.saveTaskViewController(router: self, taskViewModel: taskViewModel)
        controller?.navigationController?.pushViewController(nextController, animated: true)
    }
}
