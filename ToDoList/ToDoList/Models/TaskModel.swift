//
//  TaskModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation

struct TaskModel: Codable {
    let taskId: String
    let title: String
    let dateTime: String
    var isComplete:Bool
}

extension TaskModel: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(taskId)
    }
    
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        return lhs.taskId == rhs.taskId
    }
}
