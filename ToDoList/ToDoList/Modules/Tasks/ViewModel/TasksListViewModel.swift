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
    var taskUpdated = Observable(false)
    var taskUpdateFailed = Observable("")
    
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
    
    func configureLocalNotification() {
        LocalNotificationManager.cancelAllNotification()
        for task in tasksArray {
            if !task.isTaskComplete, task.taskDate > Date() {
                LocalNotificationManager.addNotification(withTitle: task.taskTitle,
                                                    identifier: task.taskId,
                                                    onDate: task.taskDate)
            }
        }
    }
}

extension TasksListViewModel {
    func observeTasks() {
        taskNetworkService.observeTasks { [weak self] result in
            switch result {
            case .success(let tasks):
                self?.tasksArray = tasks.map(TaskViewModel.init)
                self?.refreshTasks.value = ""
                self?.configureLocalNotification()
            case .failure(let error):
                self?.refreshTasks.value = error.localizedDescription
            }
        }
    }
    
    func deleteTask(indexPath: IndexPath) {
        if let item = item(atIndex: indexPath) {
            taskNetworkService.deleteTask(item.taskId) { [weak self] result in
                if case .failure( let error) = result {
                    self?.taskUpdateFailed.value = error.localizedDescription
                } else {
                    self?.taskUpdated.value.toggle()
                }
            }
        }
    }
    
    func changeTaskStatus(indexPath: IndexPath) {
        if let item = item(atIndex: indexPath) {
            item.changeTaskStatus()
            
            let existingTaskDataModel = TaskDataModel(title: item.taskTitle,
                                                      timeInterval: item.taskTimeInterval,
                                                      isComplete: item.isTaskComplete)
            let existingTask = TaskModel(taskId: item.taskId, taskDataModel: existingTaskDataModel)
            updateTaskNetworkService.updateTask(existingTask) { [weak self] result in
                if case .failure( let error) = result {
                    self?.taskUpdateFailed.value = error.localizedDescription
                } else {
                    self?.taskUpdated.value.toggle()
                }
            }
        } else {
            taskUpdateFailed.value = ResultErrors.unknown.description
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
