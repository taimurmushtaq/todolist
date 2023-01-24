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
    
    func routeToRegistration()
}

class AppRouter: RouterProtocol {
    weak var controller: UIViewController?
    
    required init(_ controller: UIViewController?) {
        self.controller = controller
    }
    
    func routeToRegistration() {
        let nextController = AppFactory.registerViewController(router: self)
        controller?.navigationController?.pushViewController(nextController, animated: true)
    }
}
