//
//  TaskModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation

struct TaskModel: Codable {
    let taskId: String
    var taskDataModel: TaskDataModel
}

struct TaskDataModel: Codable {
    let title: String
    let timeInterval: TimeInterval
    var isComplete:Bool
    
    mutating func changeTaskStatus() {
        isComplete.toggle()
    }
    
    var taskDate:Date { get { return Date(timeIntervalSince1970: timeInterval) } }
}
