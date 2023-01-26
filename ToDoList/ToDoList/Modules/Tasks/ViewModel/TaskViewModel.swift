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
    var taskTitle:String { return taskModel.taskDataModel.title }
    var taskDateTime:String { return taskModel.taskDataModel.dateTime }
    var isTaskComplete:Bool { return taskModel.taskDataModel.isComplete }
    
    init(taskModel: TaskModel) {
        self.taskModel = taskModel
    }
    
    func changeTaskStatus() {
        taskModel.taskDataModel.isComplete.toggle()
    }
}
