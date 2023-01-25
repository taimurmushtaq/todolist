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
