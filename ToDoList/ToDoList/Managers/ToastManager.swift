//
//  ToastManager.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import UIKit
import MBProgressHUD

enum ToastManager  {
    static func showMessage(_ message: String?) {
        guard let window = AppWindowManager.window,
              let message = message,
              message.count > 0
        else { return }
        
        ToastManager.showMessage(message, time: 2, in: window)
    }
    
    static func showMessage(_ message: String?, time: Int) {
        guard let window = AppWindowManager.window,
              let message = message,
              message.count > 0
        else { return }
        
        ToastManager.showMessage(message, time: time, in: window)
    }
    
    static func showMessage(_ message: String?, time: Int, in view: UIView?) {
        guard let window = AppWindowManager.window,
              let message = message,
              message.count > 0
        else { return }
        
        let hud = MBProgressHUD.showAdded(to: view ?? window, animated: true)
        hud.offset = CGPoint(x: 0, y: (UIScreen.main.bounds.height / 2) - 100)
        hud.margin = 10
        hud.animationType = MBProgressHUDAnimation.fade
        hud.bezelView.color = UIColor.black
        hud.bezelView.alpha = 0.8
        hud.label.font = UIFont.boldSystemFont(ofSize: 14)
        hud.label.numberOfLines = 0
        hud.contentColor = UIColor.white
        hud.isUserInteractionEnabled = false
        hud.mode = MBProgressHUDMode.text
        hud.label.text = message
        hud.hide(animated: true, afterDelay: Double(time))
    }
    
    static func showKeyboardMessage(_ message: String?, time: Int, in view: UIView?) {
        self.showMessage(message, time: time, in: view)
    }
}

