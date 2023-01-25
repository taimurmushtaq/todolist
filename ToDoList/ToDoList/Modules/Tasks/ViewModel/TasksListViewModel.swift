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
    private let networkService: TasksNetworkServiceProtocol
    
    init(_ networkService: TasksNetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension TasksListViewModel {
    func performLogut() {
        do {
            try networkService.performLogout()
            successfullySignOut.value.toggle()
        } catch (let error){
            ToastManager.showMessage(error.localizedDescription)
        }
    }
}
