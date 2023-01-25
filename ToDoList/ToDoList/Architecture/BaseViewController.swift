//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    deinit {
        print("deinit \(String(describing: self))")
    }
}
