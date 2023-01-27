//
//  LoginUITests.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import XCTest
@testable import ToDoList

enum LoginElementConent: String {
    case validEmail = "taimur.1989@gmail.com"
    case inValidEmail = "taimur"
    case validPassword = "Password"
    case inValidPassword = "123"
}

final class LoginUITests: XCTestCase {
    var app: XCUIApplication!
    var loginPageObject: LoginPageObject!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        loginPageObject = LoginPageObject(app: app)
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
    }
}

extension LoginUITests {
    func test_whenFieldsAreEmpty() {
        loginPageObject.emailTextField.tap()
        loginPageObject.emailTextField.typeText("")
        
        loginPageObject.passwordTextField.tap()
        loginPageObject.passwordTextField.typeText("")
        
        XCTAssertEqual(loginPageObject.loginButton.isEnabled, false)
    }
    
    func test_whenInValidDetailsAreEntered() {
        loginPageObject.emailTextField.tap()
        loginPageObject.emailTextField.typeText(LoginElementConent.inValidEmail.rawValue)
        
        loginPageObject.passwordTextField.tap()
        loginPageObject.passwordTextField.typeText(LoginElementConent.inValidPassword.rawValue)
        
        XCTAssertEqual(loginPageObject.loginButton.isEnabled, false)
    }
    
    func test_whenValidDetailsAreEntered() {
        loginPageObject.emailTextField.tap()
        loginPageObject.emailTextField.typeText(LoginElementConent.validEmail.rawValue)
        
        loginPageObject.passwordTextField.tap()
        loginPageObject.passwordTextField.typeText(LoginElementConent.validPassword.rawValue)
        
        XCTAssertEqual(loginPageObject.loginButton.isEnabled, true)
    }
    
    func test_whenLoginIsPerformedWithValidCredentials() {
        loginPageObject.emailTextField.tap()
        loginPageObject.emailTextField.typeText(LoginElementConent.validEmail.rawValue)
        
        loginPageObject.passwordTextField.tap()
        loginPageObject.passwordTextField.typeText(LoginElementConent.validPassword.rawValue)
        
        loginPageObject.loginButton.tap()
        
        let navigationBarTitle = app.staticTexts["To-Do List"]
        XCTAssertTrue(navigationBarTitle.waitForExistence(timeout: 0.5))
    }
}

