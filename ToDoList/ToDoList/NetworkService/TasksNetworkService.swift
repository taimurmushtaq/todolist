//
//  TasksNetworkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth

protocol TasksNetworkServiceProtocol {
    func observeTasks(_ onCompletion: @escaping (Result<[TaskModel], ResultErrors>) -> Void)
    func deleteTask(_ taskId: String, onCompletion: @escaping (Result<Void, Error>) -> Void)
    func performLogout() throws
}

protocol AddTaskNetworkServiceProtcol {
    func saveTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void)
}

protocol UpdateTaskNetworkServiceProtcol {
    func updateTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void)
}

class TasksNetworkService: TasksNetworkServiceProtocol {
    let dataBaseManager = FireBaseDataBaseManager()
    
    func observeTasks(_ onCompletion: @escaping (Result<[TaskModel], ResultErrors>) -> Void) {
        dataBaseManager.observeTasks { result in
            if case .success(let value) = result,
               let object = value as? [String: [String: Any]] {
                
                let tasks = object.map { key, value in
                    return TaskModel(taskId: key, taskDataModel: value.toModel(ofType: TaskDataModel.self)!)
                }
                
                onCompletion(.success(tasks))
            }
        }
    }
    
    func deleteTask(_ taskId: String, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        dataBaseManager.deleteTask(taskId: taskId) { result in
            if case .failure(let error) = result {
                onCompletion(.failure(error))
            } else {
                onCompletion(.success(()))
            }
        }
    }
    
    func performLogout() throws {
        try Auth.auth().signOut()
    }
}

class SaveTaskNetworkService: AddTaskNetworkServiceProtcol, UpdateTaskNetworkServiceProtcol {
    let dataBaseManager = FireBaseDataBaseManager()
    
    func saveTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        if let taskDict = taskModel.taskDataModel.toObject() as? [String: Any] {
            dataBaseManager.saveTask(taskModelDict: taskDict) { result in
                if case .failure(let error) = result {
                    onCompletion(.failure(error))
                } else {
                    onCompletion(.success(()))
                }
            }
        }
    }
    
    func updateTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        if let taskDict = taskModel.taskDataModel.toObject() as? [String: Any] {
            dataBaseManager.updateTask(taskId: taskModel.taskId, taskModelDict: taskDict) { result in
                if case .failure(let error) = result {
                    onCompletion(.failure(error))
                } else {
                    onCompletion(.success(()))
                }
            }
        }
        
    }
}
