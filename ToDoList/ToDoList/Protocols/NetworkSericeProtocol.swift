//
//  NetworkSericeProtocol.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import Foundation

protocol AuthNetworkServiceProtocol {
    static var currentUser: UserModel? { get }
    func handleAuthState(_ onCompletion: @escaping (Result<UserModel, ResultErrors>) -> Void)
}

protocol LoginNetworkServiceProtocol {
    func performLogin(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void)
}

protocol RegisterationNetworkServiceProtocol {
    func performRegisteration(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void)
}

protocol TasksNetworkServiceProtocol {
    func observeTasks(_ onCompletion: @escaping (Result<[TaskModel], Error>) -> Void)
    func deleteTask(_ taskId: String, onCompletion: @escaping (Result<Void, Error>) -> Void)
    func performLogout() throws
}

protocol AddTaskNetworkServiceProtcol {
    func saveTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void)
}

protocol UpdateTaskNetworkServiceProtcol {
    func updateTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void)
}
