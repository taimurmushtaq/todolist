//
//  FireBaseDataBaseManager.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import Foundation
import FirebaseDatabase

enum FireBaseDataBasePath: String {
    case tasks = "Tasks"
}

class FireBaseDataBaseManager {
    private var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference(withPath: FireBaseDataBasePath.tasks.rawValue)
    }
}

extension FireBaseDataBaseManager {
    func observeTasks(onCompletion: @escaping (Result<Any?, Error>) -> Void) {
        ref.observe(.value) { snapShot in
            onCompletion(.success(snapShot.value))
        }
    }
    
    func saveTask(taskModelDict: [String: Any], onCompletion: @escaping (Result<Void, Error>) -> Void) {
        ref.childByAutoId().setValue(taskModelDict) { error, _ in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                onCompletion(.success(()))
            }
        }
    }
    
    func updateTask(taskId: String, taskModelDict: [String: Any], onCompletion: @escaping (Result<Void, Error>) -> Void) {
        ref.child(taskId).updateChildValues(taskModelDict) { error, _ in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                onCompletion(.success(()))
            }
        }
    }
    
    func deleteTask(taskId: String, onCompletion: @escaping (Result<Void, Error>) -> Void) {
        ref.child(taskId).removeValue { error, _ in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                onCompletion(.success(()))
            }
        }
    }
}
