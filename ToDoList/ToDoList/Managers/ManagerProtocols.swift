//
//  ManagerProtocols.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import UIKit

protocol AppFactoryProtocol {
    static func loginViewController() -> LoginViewController
    static func registerViewController(router: RouterProtocol) -> RegisterationViewController
    static func tasksListViewController() -> TasksListViewController
    static func saveTaskViewController(router: RouterProtocol, taskViewModel: TaskViewModel?) -> SaveTaskViewController
}

protocol RouterProtocol: AnyObject {
    var controller: UIViewController? { get set }
    init(_ controller: UIViewController?)
    
    func routeToRegisteration()
    func routToLogin()
    func routToTasks()
    func routToSaveTasks(_ taskViewModel: TaskViewModel?)
    func goBack()
}
