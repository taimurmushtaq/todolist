//
//  MockNetWorkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import UIKit

class MockNetworkService { }

extension MockNetworkService: AuthNetworkServiceProtocol {
    static var currentUser: UserModel? {
        return UserModel(uid: UUID().uuidString, email: "taimur.1989@gmail.com", displayName: "Taimur Mushtaq")
    }
    
    func handleAuthState(_ onCompletion: @escaping (Result<UserModel, ResultErrors>) -> Void) {
        onCompletion(.success(MockNetworkService.currentUser!))
    }
}

extension MockNetworkService: LoginNetworkServiceProtocol {
    func performLogin(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void) {
        if email == "taimur.1989@gmail.com" && password == "Password" {
            onCompletion(.success(MockNetworkService.currentUser!))
        } else {
            onCompletion(.failure(ResultErrors.invalidCredentials as Error))
        }
    }
}

extension MockNetworkService: RegisterationNetworkServiceProtocol {
    func performRegisteration(withEmail email: String, password: String, onCompletion: @escaping (Result<UserModel, Error>) -> Void) {
        if email == "taimur.1989@gmail.com" && password == "Password" {
            onCompletion(.success(MockNetworkService.currentUser!))
        } else {
            onCompletion(.failure(ResultErrors.invalidCredentials as Error))
        }
    }
}

extension MockNetworkService: TasksNetworkServiceProtocol {
    func observeTasks(_ onCompletion: @escaping (Result<[TaskModel], Error>) -> Void) {
        
    }
    
    func deleteTask(_ taskId: String, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func performLogout() throws {
        
    }
}

extension MockNetworkService: AddTaskNetworkServiceProtcol {
    func saveTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}

extension MockNetworkService: UpdateTaskNetworkServiceProtcol {
    func updateTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}
