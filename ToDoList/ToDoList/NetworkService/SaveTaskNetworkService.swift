//
//  SaveTaskNetworkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth

protocol SaveTaskNetworkServiceProtcol {
    func saveTask(_ title: String, dateTime: String, isComplete:Bool, onCompletion: @escaping (Result<TaskModel, Error>) -> Void)
    func updateTask(_ title: String, dateTime: String, isComplete:Bool, onCompletion: @escaping (Result<TaskModel, Error>) -> Void)
}

class SaveTaskNetworkService: SaveTaskNetworkServiceProtcol {
    func saveTask(_ title: String, dateTime: String, isComplete:Bool, onCompletion: @escaping (Result<TaskModel, Error>) -> Void) {
        
    }
    func updateTask(_ title: String, dateTime: String, isComplete:Bool, onCompletion: @escaping (Result<TaskModel, Error>) -> Void) {
        
    }
}
