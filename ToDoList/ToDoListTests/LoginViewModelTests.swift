//
//  LoginViewModelTests.swift
//  LoginViewModelTests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import XCTest
@testable import ToDoList

final class LoginViewModelTests: XCTestCase {
    var sut: LoginViewModel!
    
    var email = ""
    var password = ""
    var validateFields = false
    var signInSuccessful = false
    var signInFailed = ""
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = LoginViewModel(MockNetworkService.instance)
        bindViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
}

extension LoginViewModelTests {
    func bindViewModel() {
        sut.email.bind { value in
            self.email = value
        }
        sut.password.bind { value in
            self.password = value
        }
        sut.validateFields.bind { value in
            self.validateFields = value
        }
        sut.signInSuccessful.bind { value in
            self.signInSuccessful = value
        }
        sut.signInFailed.bind { value in
            self.signInFailed = value
        }
    }
}

extension LoginViewModelTests {
    func test_whenEmailIsChanged() {
        sut.email.value = ""
        XCTAssertEqual(email, sut.email.value)
        
        sut.email.value = "taimur.1989@gmail.com"
        XCTAssertEqual(email, sut.email.value)
    }
    
    func test_whenPasswordIsChanged() {
        sut.password.value = ""
        XCTAssertEqual(password, "")
        
        sut.password.value = "Password"
        XCTAssertEqual(password, "Password")
    }
    
    func test_whenInvalidCredentialsAreEntered() {
        sut.email.value = ""
        sut.password.value = ""
        sut.performValidation()
        
        XCTAssertFalse(validateFields)
    }
    
    func test_whenValidCredentialsAreEntered() {
        sut.email.value = "taimur.1989@gmail.com"
        sut.password.value = "Password"
        sut.performValidation()
        
        XCTAssertTrue(validateFields)
    }
    
    func test_whenLoginPerformedWithInvalidCredentials() {
        sut.email.value = ""
        sut.password.value = ""
        sut.performLogin()
        
        XCTAssertTrue(!signInSuccessful)
        XCTAssertTrue(!signInFailed.isEmpty)
    }
    
    func test_whenLoginPerformedWithValidCredentials() {
        sut.email.value = "taimur.1989@gmail.com"
        sut.password.value = "Password"
        sut.performLogin()
        
        XCTAssertTrue(signInSuccessful)
        XCTAssertTrue(signInFailed.isEmpty)
    }
}

