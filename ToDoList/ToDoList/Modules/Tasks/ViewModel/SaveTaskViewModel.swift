//
//  SaveTaskViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import FirebaseAuth

struct SaveTaskViewModel {
    //MARK: - Observables
    var title = Observable("")
    var dateTime = Observable(TimeInterval())
    
    var validateFields = Observable(false)
    var taskUpdated = Observable(false)
    var taskUpdateFailed = Observable("")
    
    //MARK: - Properties
    private let networkService: AddTaskNetworkServiceProtcol & UpdateTaskNetworkServiceProtcol
    private var taskModel: TaskModel?
    
    init(_ networkService: AddTaskNetworkServiceProtcol & UpdateTaskNetworkServiceProtcol, taskModel: TaskModel?) {
        self.networkService = networkService
        self.taskModel = taskModel
    }
}

extension SaveTaskViewModel {
    var isEditing:Bool { return taskModel != nil }
    
    func updateFields() {
        if let taskTitle = taskModel?.taskDataModel.title {
            title.value = taskTitle
        }
        if let timeInterval = taskModel?.taskDataModel.timeInterval {
            dateTime.value = timeInterval
        }
        performValidation()
    }
    
    func performValidation() {
        if title.value.isEmpty || dateTime.value == 0.0 {
            validateFields.value = false
        } else  {
            validateFields.value = true
        }
    }
    
    func saveTask() {
        if isEditing {
            let existingTaskDataModel = TaskDataModel(title: title.value, timeInterval: dateTime.value, isComplete: taskModel!.taskDataModel.isComplete)
            let existingTask = TaskModel(taskId: taskModel!.taskId, taskDataModel: existingTaskDataModel)
            networkService.updateTask(existingTask) { result in
                if case .failure( let error) = result {
                    taskUpdateFailed.value = error.localizedDescription
                } else {
                    taskUpdated.value = true
                }
            }
        } else {
            let taskDataModel = TaskDataModel(title: title.value, timeInterval: dateTime.value, isComplete: false)
            let newTask = TaskModel(taskId: "", taskDataModel: taskDataModel)
            
            networkService.saveTask(newTask) { result in
                if case .failure( let error) = result {
                    taskUpdateFailed.value = error.localizedDescription
                } else {
                    taskUpdated.value = true
                }
            }
        }
    }
}
