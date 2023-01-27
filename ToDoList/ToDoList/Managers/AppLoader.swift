//
//  AppLoader.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import Foundation
import MBProgressHUD

class AppLoader {
    static let instance = AppLoader()
    
    private var hud: MBProgressHUD?
    
    func show() {
        guard let window = AppWindowManager.window else { return }
        
        self.hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud!.mode = .indeterminate
    }
    
    func hide() {
        hud!.hide(animated: true)
    }
}
