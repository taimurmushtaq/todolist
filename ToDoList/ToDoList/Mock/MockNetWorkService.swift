//
//  MockNetWorkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import UIKit

class MockNetworkService {
    static let instance = MockNetworkService()
    private init() { }
    
    var taskArray = [TaskModel]()
    var taskObserver: (Result<[TaskModel], Error>) -> Void = { _ in }
    var authStateObserver: (Result<UserModel, ResultErrors>) -> Void = { _ in }
    
    func addTask() {
        let timeInterval = "11:12 PM, 27 Jan 2023".convertToDate(withFormat: DateFormats.taskTimerFormat.rawValue)!.timeIntervalSince1970
        let taskDataModel = TaskDataModel(title: "Innovation Factory Task", timeInterval: timeInterval, isComplete: false)
        let taskModel = TaskModel(taskId: UUID().uuidString, taskDataModel: taskDataModel)
        
        taskArray.append(taskModel)
    }
    
    func clealAllTasks() {
        taskArray.removeAll()
    }
}

extension MockNetworkService: AuthNetworkServiceProtocol {
    static var currentUser: UserModel? {
        return UserModel(uid: UUID().uuidString, email: "taimur.1989@gmail.com", displayName: "Taimur Mushtaq")
    }
    
    func handleAuthState(_ onCompletion: @escaping (Result<UserModel, ResultErrors>) -> Void) {
        authStateObserver = onCompletion
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
    func performLogout() throws {
        authStateObserver(.failure(ResultErrors.unknown))
    }
    
    func observeTasks(_ onCompletion: @escaping (Result<[TaskModel], Error>) -> Void) {
        taskObserver = onCompletion
    }
    
    func deleteTask(_ taskId: String, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        taskArray.removeAll { model in return model.taskId == taskId }
        
        onCompletion(.success(()))
        taskObserver(.success(taskArray))
    }
}

extension MockNetworkService: AddTaskNetworkServiceProtcol {
    func saveTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        addTask()
        onCompletion(.success(()))
        taskObserver(.success(taskArray))
    }
}

extension MockNetworkService: UpdateTaskNetworkServiceProtcol {
    func updateTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        taskModel.taskDataModel.changeTaskStatus()
        
        onCompletion(.success(()))
        taskObserver(.success(taskArray))
    }
}
