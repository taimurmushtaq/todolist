//
//  SaveTaskNetworkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth

protocol AddTaskNetworkServiceProtcol {
    func saveTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void)
}

protocol UpdateTaskNetworkServiceProtcol {
    func updateTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void)
}

class SaveTaskNetworkService: AddTaskNetworkServiceProtcol, UpdateTaskNetworkServiceProtcol {
    func saveTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        onCompletion(.success(()))
    }
    
    func updateTask(_ taskModel: TaskModel, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        onCompletion(.failure(NetworkServiceError.dataParsingError))
    }
}
