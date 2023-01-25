//
//  AppWindowManager.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

enum AppWindowManager {
    static func setupWindow(forScene scene: UIScene) {
        guard let window = (scene as? UIWindowScene) else { return }
        
        let navController = AppFactory.navigationController()
        
        if AuthNetworkService.currentUser == nil {
            navController.viewControllers = [AppFactory.loginViewController()]
        } else {
            navController.viewControllers = [AppFactory.tasksListViewController()]
        }
        
        self.window = UIWindow(windowScene: window)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
    }
}

extension AppWindowManager {
    static var window: UIWindow? {
        get {
            return (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        }
        set {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window = newValue
        }
    }
}
