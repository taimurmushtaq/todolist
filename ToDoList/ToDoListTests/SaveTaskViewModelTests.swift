//
//  SaveTaskViewModel.swift
//  ToDoListTests
//
//  Created by Taimur Mushtaq on 28/01/2023.
//

import XCTest

import XCTest
@testable import ToDoList

final class SaveTaskViewModelTests: XCTestCase {
    var sut: SaveTaskViewModel!
    
    var title = ""
    var dateTime: TimeInterval = 0.0
    var validateFields = false
    var taskUpdate = ""
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        MockNetworkService.instance.clealAllTasks()
        
        configureForAddNewTask()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
}

extension SaveTaskViewModelTests {
    func bindViewModel() {
        sut.title.bind { value in
            self.title = value
        }
        sut.dateTime.bind { value in
            self.dateTime = value
        }
        sut.validateFields.bind { value in
            self.validateFields = value
        }
        sut.taskUpdate.bind { value in
            self.taskUpdate = value
        }
    }
    
    func configureForAddNewTask() {
        sut = SaveTaskViewModel(MockNetworkService.instance, taskModel: nil)
        bindViewModel()
    }
    
    func configureForUpdateTask() {
        MockNetworkService.instance.addTask()
        sut = SaveTaskViewModel(MockNetworkService.instance, taskModel: taskModel)
        bindViewModel()
    }
    
    var taskModel: TaskModel { get { return MockNetworkService.instance.taskArray.first! } }
    
    var dateTimeInterval: TimeInterval {
        return "11:12 PM, 27 Jan 2023".convertToDate(withFormat: DateFormats.taskTimerFormat.rawValue)!.timeIntervalSince1970
    }
}

extension SaveTaskViewModelTests {
    func test_whenWeAreAddingNewTask() {
        XCTAssertTrue(!sut.isEditing)
    }
    
    func test_whenWeAreUpdatingTask() {
        configureForUpdateTask()
        XCTAssertTrue(sut.isEditing)
    }
    
    func test_whenTitleIsChanged() {
        sut.title.value = ""
        XCTAssertEqual(title, "")
        
        sut.title.value = "New Task"
        XCTAssertEqual(title, "New Task")
    }
    
    func test_whenDateTimeIsChanged() {
        sut.dateTime.value = 0.0
        XCTAssertEqual(dateTime, 0.0)
        
        sut.dateTime.value = dateTimeInterval
        XCTAssertEqual(dateTime, dateTimeInterval)
    }
    
    func test_whenInValidDataIsEntered() {
        sut.title.value = ""
        sut.dateTime.value = 0.0
        sut.performValidation()
        
        XCTAssertEqual(validateFields, false)
    }
    
    func test_whenValidDataIsEntered() {
        sut.title.value = "New Task"
        sut.dateTime.value = dateTimeInterval
        sut.performValidation()
        
        XCTAssertEqual(validateFields, true)
    }
    
    func test_whenTaskIsSavedWithValidData() {
        sut.title.value = "New Task"
        sut.dateTime.value = dateTimeInterval
        sut.saveTask()
        
        XCTAssertTrue(taskUpdate.isEmpty)
    }
    
    func test_whenExistingTaskIsPassed() {
        configureForUpdateTask()
        sut.updateFields()
        
        XCTAssertEqual(title, taskModel.taskDataModel.title)
        XCTAssertEqual(dateTime, taskModel.taskDataModel.timeInterval)
    }
    
    func test_whenExistingTaskIsUpdated() {
        configureForUpdateTask()
        
        sut.title.value = "Updated Task"
        sut.dateTime.value = "11:00 PM, 28 Jan 2023".convertToDate(withFormat: DateFormats.taskTimerFormat.rawValue)!.timeIntervalSince1970
        sut.saveTask()
        
        XCTAssertTrue(taskUpdate.isEmpty)
        XCTAssertNotEqual(taskModel.taskDataModel.taskDate.timeIntervalSince1970,
                       "11:00 PM, 28 Jan 2023".convertToDate(withFormat: DateFormats.taskTimerFormat.rawValue)!.timeIntervalSince1970)
    }
}
