//
//  AppWindowManager.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit

enum AppWindowManager {
    static func setupWindow(withRootController controller: UINavigationController) {
        let window = self.window ?? UIWindow.init(frame: windowFrame)
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        //If appdelegate window is nil, then assigning newly created window
        if self.window == nil {
            self.window = window
        }
    }
}

private extension AppWindowManager {
    static var window: UIWindow? {
        get {
            return (UIApplication.shared.delegate as? AppDelegate)?.window
        }
        set {
            (UIApplication.shared.delegate as? AppDelegate)?.window = newValue
        }
    }

    static var windowFrame: CGRect {
        return UIScreen.main.bounds
    }
}
