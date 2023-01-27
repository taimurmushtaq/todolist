//
//  RegisterUITests.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import XCTest
@testable import ToDoList

enum RegisterElementConent {
    enum Email: String {
        case valid = "taimur.1989@gmail.com"
        case inValid = "taimur"
    }
    enum Password: String {
        case valid = "Password"
        case inValid = "123"
    }
    enum ConfirmPassword: String {
        case valid = "Password"
        case inValid = "123"
    }
}

final class RegisterUITests: XCTestCase {
    var app: XCUIApplication!
    var loginPageObject: LoginPageObject!
    var registerPageObject: RegisterPageObject!
    
    override func setUpWithError() throws {
        try super.setUpWithError()

        app = XCUIApplication()
        app.launchEnvironment = ["ENV": "TEST"]
        
        loginPageObject = LoginPageObject(app: app)
        registerPageObject = RegisterPageObject(app: app)
        
        continueAfterFailure = false
        app.launch()
        
        moveToRegisteration()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app = nil
    }
}

extension RegisterUITests {
    func moveToRegisteration() {
        loginPageObject.registerButton.tap()
    }
}

extension RegisterUITests {
    func test_whenFieldsAreEmpty() {
        registerPageObject.emailTextField.tap()
        registerPageObject.emailTextField.typeText("")
        
        registerPageObject.passwordTextField.tap()
        registerPageObject.passwordTextField.typeText("")
        
        registerPageObject.confirmPasswordTextField.tap()
        registerPageObject.confirmPasswordTextField.typeText("")
        
        XCTAssertEqual(registerPageObject.registerButton.isEnabled, false)
    }
    
    func test_whenInValidDetailsAreEntered() {
        registerPageObject.emailTextField.tap()
        registerPageObject.emailTextField.typeText(RegisterElementConent.Email.inValid.rawValue)
        
        registerPageObject.passwordTextField.tap()
        registerPageObject.passwordTextField.typeText(RegisterElementConent.Password.inValid.rawValue)
        
        registerPageObject.confirmPasswordTextField.tap()
        registerPageObject.confirmPasswordTextField.typeText(RegisterElementConent.ConfirmPassword.inValid.rawValue)
        
        XCTAssertEqual(registerPageObject.registerButton.isEnabled, false)
    }
    
    func test_whenPasswordsDoNotMatch() {
        registerPageObject.emailTextField.tap()
        registerPageObject.emailTextField.typeText(RegisterElementConent.Email.valid.rawValue)
        
        registerPageObject.passwordTextField.tap()
        registerPageObject.passwordTextField.typeText(RegisterElementConent.Password.valid.rawValue)
        
        registerPageObject.confirmPasswordTextField.tap()
        registerPageObject.confirmPasswordTextField.typeText(RegisterElementConent.ConfirmPassword.inValid.rawValue)
        
        XCTAssertEqual(registerPageObject.registerButton.isEnabled, false)
    }
    
    func test_whenValidDetailsAreEntered() {
        registerPageObject.emailTextField.tap()
        registerPageObject.emailTextField.typeText(RegisterElementConent.Email.valid.rawValue)
        
        registerPageObject.passwordTextField.tap()
        registerPageObject.passwordTextField.typeText(RegisterElementConent.Password.valid.rawValue)
        
        registerPageObject.confirmPasswordTextField.tap()
        registerPageObject.confirmPasswordTextField.typeText(RegisterElementConent.ConfirmPassword.valid.rawValue)
        
        XCTAssertEqual(registerPageObject.registerButton.isEnabled, true)
    }
    
    func test_whenRegisterationIsPerformedWithValidCredentials() {
        registerPageObject.emailTextField.tap()
        registerPageObject.emailTextField.typeText(RegisterElementConent.Email.valid.rawValue)
        
        registerPageObject.passwordTextField.tap()
        registerPageObject.passwordTextField.typeText(RegisterElementConent.Password.valid.rawValue)
        
        registerPageObject.confirmPasswordTextField.tap()
        registerPageObject.confirmPasswordTextField.typeText(RegisterElementConent.ConfirmPassword.valid.rawValue)
        
        registerPageObject.registerButton.tap()
        
        let navigationBarTitle = app.staticTexts["To-Do List"]
        XCTAssertTrue(navigationBarTitle.waitForExistence(timeout: 0.5))
    }
}
