//
//  AppLibrary.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//
import FirebaseCore
import IQKeyboardManagerSwift

enum AppLibManager {
    static func configure() {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
    }
}
