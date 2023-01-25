//
//  AppRouter.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

protocol RouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    init(_ controller: UIViewController?)
    
    func routeToRegisteration()
    func routToLogin()
    func routToTasks()
    func routToSaveTasks(_ taskViewModel: TaskViewModel?)
    func goBack()
}

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
        let navController = AppFactory.navigationController()
        navController.viewControllers = [AppFactory.loginViewController()]
        
        AppWindowManager.window?.rootViewController = navController
    }
    
    func routToTasks() {
        let navController = AppFactory.navigationController()
        navController.viewControllers = [AppFactory.tasksListViewController()]
        
        AppWindowManager.window?.rootViewController = navController
    }
    
    func routToSaveTasks(_ taskViewModel: TaskViewModel?) {
        let nextController = AppFactory.saveTaskViewController(router: self, taskViewModel: taskViewModel)
        controller?.navigationController?.pushViewController(nextController, animated: true)
    }
}
