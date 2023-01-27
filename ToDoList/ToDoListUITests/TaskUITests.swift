//
//  TaskUITests.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import XCTest
@testable import ToDoList

enum TaskCellElementConent: String {
    case title = "Innovation Factory Task"
    case dateTime = "11:12 PM, 27 Jan 2023"
}

final class TaskUITests: XCTestCase {
    var app: XCUIApplication!
    
    var loginPageObject: LoginPageObject!
    var listPageObject: TaskListPageObject!
    var alertPageObject: AlertPageObject!
    var saveTaskPageObject: SaveTaskPageObject!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        
        loginPageObject = LoginPageObject(app: app)
        listPageObject = TaskListPageObject(app: app)
        alertPageObject = AlertPageObject(app: app)
        saveTaskPageObject = SaveTaskPageObject(app: app)
        
        continueAfterFailure = false
        app.launch()
        
        performLogin()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
    }
}

extension TaskUITests {
    func performLogin() {
        loginPageObject.emailTextField.tap()
        loginPageObject.emailTextField.typeText(LoginElementConent.validEmail.rawValue)
        
        loginPageObject.passwordTextField.tap()
        loginPageObject.passwordTextField.typeText(LoginElementConent.validPassword.rawValue)
        
        loginPageObject.loginButton.tap()
    }
    
    func addTask() {
        listPageObject.addTaskButton.tap()
        
        saveTaskPageObject.titleTextField.tap()
        saveTaskPageObject.titleTextField.typeText(TaskCellElementConent.title.rawValue)
        
        saveTaskPageObject.dateTextField.tap()
        let pickerWheels = saveTaskPageObject.datePickerView.pickerWheels
        
        pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "Jan 28")
        pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "11")
        pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "00")
        pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "AM")
        
        saveTaskPageObject.doneButton.tap()
        saveTaskPageObject.saveButton.tap()
    }
}

extension TaskUITests {
    func test_whenAddButtonIsPressed() {
        listPageObject.addTaskButton.tap()
        
        let navigationBarTitle = app.staticTexts["Add Task"]
        XCTAssertTrue(navigationBarTitle.waitForExistence(timeout: 0.5))
    }
    
    func test_whenNoButtonIsPressedOfLogoutAlert() {
        listPageObject.logoutButton.tap()
        
        if alertPageObject.noButton.waitForExistence(timeout: 1.0) {
            alertPageObject.noButton.tap()
            
            let navigationBarTitle = app.staticTexts["Add Task"]
            XCTAssertTrue(navigationBarTitle.waitForExistence(timeout: 0.5))
        }
    }
    
    func test_whenYesButtonIsPressedOfLogoutAlert() {
        listPageObject.logoutButton.tap()
        
        if alertPageObject.yesButton.waitForExistence(timeout: 1.0) {
            alertPageObject.yesButton.tap()
            
            let navigationBarTitle = app.staticTexts["To-Do List"]
            XCTAssertTrue(navigationBarTitle.waitForExistence(timeout: 0.5))
        }
    }
}

extension TaskUITests {
    func test_whenTaskListIsLaunched() {
        XCTAssertEqual(listPageObject.taskList.cells.count, 0)
    }
    
    func test_whenANewTaskIsAdded() {
        addTask()
        XCTAssertTrue(listPageObject.taskList.cells.count > 0)
    }
    
    //TODO: - Need to fix below UI Tests
    /*
    func test_whenTaskStatusIsChanged() {
        addTask()
        let cell = listPageObject.cell(identifier: "TaskTableViewCell_0_0")
        cell.buttons["radioButton"].tap()
        
        if alertPageObject.yesButton.waitForExistence(timeout: 1.0) {
            alertPageObject.yesButton.tap()
            
            //sleep(2)
            XCTAssertTrue(cell.buttons["radioButton"].images["check"].exists)
                
            cell.buttons["radioButton"].tap()
            if alertPageObject.yesButton.waitForExistence(timeout: 1.0) {
                alertPageObject.yesButton.tap()
                
                //sleep(2)
                XCTAssertTrue(cell.buttons["radioButton"].images["un_check"].exists)
            }
        }
    }
    
    func test_whenTaskIsDeleted() {
        addTask()

        let cell = listPageObject.cell(identifier: "TaskTableViewCell_0_0")
        cell.swipeLeft()
        listPageObject.cellDeleteButon.tap()

        if alertPageObject.yesButton.waitForExistence(timeout: 1.0) {
            alertPageObject.yesButton.tap()
            
            sleep(2)
            XCTAssertFalse(cell.exists)
        }
    }
    */
}
