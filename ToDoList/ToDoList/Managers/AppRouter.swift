//
//  AppRouter.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

class AppRouter: RouterProtocol {
    weak var controller: UIViewController?
    
    required init(_ controller: UIViewController?) {
        self.controller = controller
    }
    
    func goBack(){
        controller?.navigationController?.popViewController(animated: true)
    }
    
    func routeToRegisteration() {
        let nextController = AppFactory.registerViewController(router: self)
        controller?.navigationController?.pushViewController(nextController, animated: true)
    }
    
    func routToLogin() {
        AppWindowManager.window?.rootViewController = BaseNavigationController(rootViewController: AppFactory.loginViewController())
    }
    
    func routToTasks() {
        AppWindowManager.window?.rootViewController = BaseNavigationController(rootViewController: AppFactory.tasksListViewController())
    }
    
    func routToSaveTasks(_ taskViewModel: TaskViewModel?) {
        let nextController = AppFactory.saveTaskViewController(router: self, taskViewModel: taskViewModel)
        controller?.navigationController?.pushViewController(nextController, animated: true)
    }
}
