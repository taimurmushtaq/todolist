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
    func fetchTasks(_ onCompletion: @escaping (Result<[TaskModel], Error>) -> Void)
    func performLogout() throws
}

class TasksNetworkService {
    private var ref: DatabaseReference!
    
    init() {
        self.ref = Database.database().reference()
    }
}

extension TasksNetworkService: TasksNetworkServiceProtocol {
    
    func fetchTasks(_ onCompletion: @escaping (Result<[TaskModel], Error>) -> Void) {
        let tasks = TaskModel(taskId: UUID().uuidString,
                              title: "Innovation Factory Application Task",
                              dateTime: Date().convertToString(withFormat: DateFormats.taskTimerFormat.rawValue) ,
                              isComplete: false)
        onCompletion(.success([tasks, tasks, tasks, tasks, tasks, tasks, tasks, tasks, tasks, tasks, tasks, tasks]))
    }
    
    func performLogout() throws {
        try Auth.auth().signOut()
    }
}


