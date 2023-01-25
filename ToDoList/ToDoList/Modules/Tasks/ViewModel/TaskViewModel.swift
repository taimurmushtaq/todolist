//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import UIKit

class TaskViewModel {
    var taskModel: TaskModel
    
    var taskTitle:String { return taskModel.title }
    var taskDateTime:String { return taskModel.dateTime }
    var isTaskComplete:Bool { return taskModel.isComplete }
    
    init(taskModel: TaskModel) {
        self.taskModel = taskModel
    }
    
    func changeTaskStatus() {
        taskModel.isComplete.toggle()
    }
}
