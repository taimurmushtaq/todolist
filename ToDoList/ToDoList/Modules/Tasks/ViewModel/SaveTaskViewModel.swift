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
    var successfullySaved = Observable(false)
    
    //MARK: - Properties
    private let networkService: SaveTaskNetworkServiceProtcol
    private let taskViewModel: TaskViewModel?
    
    init(_ networkService: SaveTaskNetworkServiceProtcol, taskViewModel: TaskViewModel?) {
        self.networkService = networkService
        self.taskViewModel = taskViewModel
    }
}

extension SaveTaskViewModel {
    var isEditing:Bool { return taskViewModel != nil }
    
    func updateFields() {
        title.value = taskViewModel?.taskTitle ?? ""
        dateTime.value = taskViewModel?.taskDateTime ?? ""
        validateFields.value.toggle()
    }
    
    func performValidation() {
        if title.value.isEmpty || dateTime.value.isEmpty {
            validateFields.value = false
        } else  {
            validateFields.value = true
        }
    }
    
    func saveTask() { }
}
