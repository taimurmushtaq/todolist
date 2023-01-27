//
//  TasksListViewModelTests.swift
//  ToDoListTests
//
//  Created by Taimur Mushtaq on 28/01/2023.
//

import XCTest
@testable import ToDoList

final class TasksListViewModelTests: XCTestCase {
    var sut: TasksListViewModel!
    
    var successfullySignOut = false
    var refreshTasks = ""
    var taskUpdate = ""
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        MockNetworkService.instance.clealAllTasks()
        
        sut = TasksListViewModel(MockNetworkService.instance, MockNetworkService.instance, MockNetworkService.instance)
        sut.observeTasks()
        sut.handleAuthState()
        bindViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
}

extension TasksListViewModelTests {
    func bindViewModel() {
        sut.successfullySignOut.bind { value in
            self.successfullySignOut = value
        }
        sut.refreshTasks.bind { value in
            self.refreshTasks = value
        }
        sut.taskUpdate.bind { value in
            self.taskUpdate = value
        }
    }
    
    func addTask() {
        MockNetworkService.instance.addTask()
        MockNetworkService.instance.taskObserver(.success(MockNetworkService.instance.taskArray))
    }
}

extension TasksListViewModelTests {
    func test_tableViewDataSourceMethods() {
        XCTAssertTrue(sut.numberOfSections == 1)
        XCTAssertTrue(sut.numberOfRows(inSection: 0) == 0)
        
        addTask()
        XCTAssertTrue(sut.numberOfRows(inSection: 0) == 1)
        XCTAssertTrue(sut.item(atIndex: IndexPath(row: 0, section: 0)) == sut.tasksArray.first!)
    }
}

extension TasksListViewModelTests {
    func test_whenControllerOpens() {
        XCTAssertTrue(refreshTasks.isEmpty)
    }
    
    func test_whenTaskIsDeleted() {
        addTask()
        
        sut.deleteTask(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(taskUpdate.isEmpty)
        
        sut.deleteTask(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(!taskUpdate.isEmpty)
    }
    
    func test_whenThereAreNoTasksAndChangeStatusIsCalledOnAnyRow() {
        sut.changeTaskStatus(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(!taskUpdate.isEmpty)
    }
    
    func test_whenTaskStatusIsChanged() {
        addTask()
        
        sut.changeTaskStatus(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(taskUpdate.isEmpty)
        XCTAssertTrue(MockNetworkService.instance.taskArray.first!.taskDataModel.isComplete)
        
        sut.changeTaskStatus(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertTrue(taskUpdate.isEmpty)
        XCTAssertTrue(!MockNetworkService.instance.taskArray.first!.taskDataModel.isComplete)
    }
    
    func test_whenLogoutIsPerformed() {
        sut.performLogut()
        
        XCTAssertTrue(successfullySignOut)
    }
}
