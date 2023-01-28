//
//  TaskModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation

class TaskModel: Codable {
    let taskId: String
    var taskDataModel: TaskDataModel
    
    init(taskId: String, taskDataModel: TaskDataModel) {
        self.taskId = taskId
        self.taskDataModel = taskDataModel
    }
}

class TaskDataModel: Codable {
    let title: String
    let timeInterval: TimeInterval
    var isComplete:Bool
    
    init(title: String, timeInterval: TimeInterval, isComplete: Bool) {
        self.title = title
        self.timeInterval = timeInterval
        self.isComplete = isComplete
    }
    
    func changeTaskStatus() {
        isComplete.toggle()
    }
    
    var taskDate:Date { get { return Date(timeIntervalSince1970: timeInterval) } }
}

extension TaskDataModel: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(timeInterval)
        hasher.combine(isComplete)
    }

    static func == (lhs: TaskDataModel, rhs: TaskDataModel) -> Bool {
        return lhs.timeInterval == rhs.timeInterval && lhs.title == rhs.title && lhs.isComplete == rhs.isComplete
    }
    
    
}
