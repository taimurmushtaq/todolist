//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class TaskViewModel {
    var taskModel: TaskModel
    
    var taskId:String { return taskModel.taskId }
    var taskTimeInterval:TimeInterval { return taskModel.taskDataModel.timeInterval }
    var taskTitle:String { return taskModel.taskDataModel.title }
    var taskDate:Date { return taskModel.taskDataModel.taskDate }
    var isTaskComplete:Bool { return taskModel.taskDataModel.isComplete }
    
    var taskDateTimeString:String { return taskDate.convertToString(withFormat: DateFormats.taskTimerFormat.rawValue)}
    
    init(taskModel: TaskModel) {
        self.taskModel = taskModel
    }
    
    func changeTaskStatus() {
        taskModel.taskDataModel.isComplete.toggle()
    }
}

extension TaskViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(taskId)
    }
    
    static func == (lhs: TaskViewModel, rhs: TaskViewModel) -> Bool {
        lhs.taskId == rhs.taskId
    }
}
