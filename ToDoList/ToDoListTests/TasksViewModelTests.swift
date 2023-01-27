//
//  TasksViewModelTests.swift
//  ToDoListTests
//
//  Created by Taimur Mushtaq on 28/01/2023.
//

import XCTest
@testable import ToDoList

final class TasksViewModelTests: XCTestCase {
    var sut: TaskViewModel!
    
    var successfullySignOut = false
    var refreshTasks = ""
    var taskUpdate = ""
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        MockNetworkService.instance.clealAllTasks()
        MockNetworkService.instance.addTask()
        
        sut = TaskViewModel(taskModel: MockNetworkService.instance.taskArray.first!)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
}

extension TasksViewModelTests {
    func test_tableViewDataSourceMethods() {
        XCTAssertTrue(!sut.isTaskComplete)
        
        sut.changeTaskStatus()
        XCTAssertTrue(sut.isTaskComplete)
        
        sut.changeTaskStatus()
        XCTAssertTrue(!sut.isTaskComplete)
    }
}

