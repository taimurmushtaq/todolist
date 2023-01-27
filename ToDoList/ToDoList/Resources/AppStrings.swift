//
//  AppStrings.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import Foundation

enum AppStrings {
    enum buttonTitles: String {
        case yes = "Yes"
        case no = "No"
        case cancel = "Cancel"
        case login = "Login"
        case register = "Register"
        case update = "Update"
        case add = "Add"
        case addTask = "Add Task"
    }
    
    enum labelText: String {
        case noTaskFound = "No Task Found"
    }
    
    enum alertTitle: String {
        case logout = "Logout"
        case completeTask = "Complete Task"
        case unDoTaskCompletion = "Undo Task Completion"
        case deleteTask = "Delete Task"
    }
    
    enum alertMessages: String {
        case logoutConfirmation = "Are you sure you want to logout?"
        case taskCompletionConfirmation = "Are you sure you want to mark this task complete?"
        case taskDeletionConfirmation = "Are you sure you want to delete this task?"
        case undoTaskCompletionConfirmation = "Are you sure you want to mark this task incomplete?"
    }
    
    enum controllerTitles: String {
        case signup = "SIGN UP"
        case toDoList = "To-Do List"
        case updateTask = "Update Task"
        case addTask = "Add Task"
    }
    
    enum notificationContent: String {
        case body = "Your task is due at"
    }
}
