//
//  TasksListViewModel.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation

struct TasksListViewModel {
    //MARK: - Observables
    var successfullySignOut = Observable(false)
    
    //MARK: - Properties
    private let taskNetworkService: TasksNetworkServiceProtocol
    private let authNetworkService: AuthNetworkServiceProtocol
    
    init(_ taskNetworkService: TasksNetworkServiceProtocol, _ authNetworkService: AuthNetworkServiceProtocol) {
        self.taskNetworkService = taskNetworkService
        self.authNetworkService = authNetworkService
    }
}

extension TasksListViewModel {
    func fetchTasks() {
        taskNetworkService.fetchTasks { result in
            switch result {
            case .success(let taskModel):
                break
            case .failure(let error):
                ToastManager.showMessage(error.localizedDescription)
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
                successfullySignOut.value.toggle()
            }
        }
    }
}
