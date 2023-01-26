//
//  TasksListViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation

class TasksListViewModel {
    //MARK: - Observables
    var successfullySignOut = Observable(false)
    var refreshTasks = Observable("")
    var taskSaved = Observable(false)
    var taskFailed = Observable("")
    
    //MARK: - Properties
    private let taskNetworkService: TasksNetworkServiceProtocol
    private let updateTaskNetworkService: UpdateTaskNetworkServiceProtcol
    private let authNetworkService: AuthNetworkServiceProtocol
    var tasksArray = [TaskViewModel]()
    
    init(_ taskNetworkService: TasksNetworkServiceProtocol, _ updateTaskNetworkService: UpdateTaskNetworkServiceProtcol, _ authNetworkService: AuthNetworkServiceProtocol) {
        self.taskNetworkService = taskNetworkService
        self.updateTaskNetworkService = updateTaskNetworkService
        self.authNetworkService = authNetworkService
    }
}

extension TasksListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func item(atIndex indexPath: IndexPath) -> TaskViewModel? {
        if indexPath.row < tasksArray.count {
            return tasksArray[indexPath.row]
        }
        
        return nil
    }
    
    func canEditRow(atIndex indexPath: IndexPath) -> Bool {
        return true
    }
}

extension TasksListViewModel {
    func observeTasks() {
        taskNetworkService.observeTasks { [weak self] result in
            switch result {
            case .success(let tasks):
                self?.tasksArray = tasks.map(TaskViewModel.init)
                self?.refreshTasks.value = ""
            case .failure(let error):
                ToastManager.showMessage(error.localizedDescription)
            }
        }
    }
    
    func deleteTask(indexPath: IndexPath) {
        if let item = item(atIndex: indexPath) {
            taskNetworkService.deleteTask(item.taskId) { [weak self] result in
                self?.tasksArray.remove(at: indexPath.row)
                self?.refreshTasks.value = ""
            }
        }
    }
    
    func changeTaskStatus(indexPath: IndexPath) {
        if let item = item(atIndex: indexPath) {
            item.changeTaskStatus()
            
            let existingTaskDataModel = TaskDataModel(title: item.taskTitle,
                                                      dateTime: item.taskDateTime,
                                                      isComplete: item.isTaskComplete)
            let existingTask = TaskModel(taskId: item.taskId, taskDataModel: existingTaskDataModel)
            updateTaskNetworkService.updateTask(existingTask) { [weak self] result in
                if case .failure( let error) = result {
                    self?.taskFailed.value = error.localizedDescription
                } else {
                    self?.refreshTasks.value = ""
                }
            }
        }
    }
    
    func performLogut() {
        do {
            try taskNetworkService.performLogout()
        } catch { }
    }
    
    func handleAuthState() {
        authNetworkService.handleAuthState { result in
            if case .failure(_) = result {
                self.successfullySignOut.value.toggle()
            }
        }
    }
}
