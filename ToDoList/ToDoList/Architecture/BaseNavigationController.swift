//
//  BaseNavigationController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
