//
//  TaskListUITests.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import XCTest
@testable import ToDoList

final class TaskListUITests: XCTestCase {
    var app: XCUIApplication!
    var loginPageObject: LoginPageObject!
    var listPageObject: TaskListPageObject!
    var alertPageObject: AlertPageObject!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        
        loginPageObject = LoginPageObject(app: app)
        listPageObject = TaskListPageObject(app: app)
        alertPageObject = AlertPageObject(app: app)
        
        continueAfterFailure = false
        app.launch()
        
        performLogin()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
    }
}

extension TaskListUITests {
    func performLogin() {
        loginPageObject.emailTextField.tap()
        loginPageObject.emailTextField.typeText(LoginElementConent.validEmail.rawValue)
        
        loginPageObject.passwordTextField.tap()
        loginPageObject.passwordTextField.typeText(LoginElementConent.validPassword.rawValue)
        
        loginPageObject.loginButton.tap()
    }
}

extension TaskListUITests {
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
