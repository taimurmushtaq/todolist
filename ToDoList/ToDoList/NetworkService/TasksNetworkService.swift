//
//  TasksNetworkService.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol TasksNetworkServiceProtocol {
    func fetchTasks(_ onCompletion: @escaping (Result<TaskModel, Error>) -> Void)
    func performLogout() throws
}

class TasksNetworkService: TasksNetworkServiceProtocol {
    private var ref: DatabaseReference!

    init() {
        self.ref = Database.database().reference()
    }
    
    func fetchTasks(_ onCompletion: @escaping (Result<TaskModel, Error>) -> Void) {
        //onCompletion(.failure(NetworkServiceError.dataParsingError))
    }
    
    func performLogout() throws {
        try Auth.auth().signOut()
    }
}
