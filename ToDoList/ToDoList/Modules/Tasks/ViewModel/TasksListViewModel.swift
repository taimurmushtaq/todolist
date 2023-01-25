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
    
    
    //MARK: - Properties
    private let taskNetworkService: TasksNetworkServiceProtocol
    private let authNetworkService: AuthNetworkServiceProtocol
    var tasksArray = [TaskViewModel]()
    
    init(_ taskNetworkService: TasksNetworkServiceProtocol, _ authNetworkService: AuthNetworkServiceProtocol) {
        self.taskNetworkService = taskNetworkService
        self.authNetworkService = authNetworkService
    }
    
    func setTask(array: [TaskViewModel]) {
        tasksArray = array
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
}

extension TasksListViewModel {
    func fetchTasks() {
        taskNetworkService.fetchTasks { [weak self] result in
            switch result {
            case .success(let tasks):
                self?.setTask(array: tasks.map(TaskViewModel.init))
                self?.refreshTasks.value = ""
            case .failure(let error):
                ToastManager.showMessage(error.localizedDescription)
            }
        }
    }
    
    func changeTaskStatus(indexPath: IndexPath) {
        if let item = item(atIndex: indexPath) {
            item.changeTaskStatus()
            refreshTasks.value = ""
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
