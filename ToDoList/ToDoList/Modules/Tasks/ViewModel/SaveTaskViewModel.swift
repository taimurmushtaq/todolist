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
    var dateTime = Observable("")
    
    var validateFields = Observable(false)
    var taskSaved = Observable(false)
    var taskFailed = Observable("")
    
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
        title.value = taskModel?.taskDataModel.title ?? ""
        dateTime.value = taskModel?.taskDataModel.dateTime ?? ""
        performValidation()
    }
    
    func performValidation() {
        if title.value.isEmpty || dateTime.value.isEmpty {
            validateFields.value = false
        } else  {
            validateFields.value = true
        }
    }
    
    func saveTask() {
        if isEditing {
            let existingTaskDataModel = TaskDataModel(title: title.value, dateTime: dateTime.value, isComplete: taskModel!.taskDataModel.isComplete)
            let existingTask = TaskModel(taskId: taskModel!.taskId, taskDataModel: existingTaskDataModel)
            networkService.updateTask(existingTask) { result in
                if case .failure( let error) = result {
                    taskFailed.value = error.localizedDescription
                } else {
                    taskSaved.value = true
                }
            }
        } else {
            let taskDataModel = TaskDataModel(title: title.value, dateTime: dateTime.value, isComplete: false)
            let newTask = TaskModel(taskId: "", taskDataModel: taskDataModel)
            
            networkService.saveTask(newTask) { result in
                if case .failure( let error) = result {
                    taskFailed.value = error.localizedDescription
                } else {
                    taskSaved.value = true
                }
            }
        }
    }
}
