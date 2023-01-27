//
//  RegisterViewModelTests.swift
//  RegisterViewModelTests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import XCTest
@testable import ToDoList

final class RegisterViewModelTests: XCTestCase {
    var sut: RegisterationViewModel!
    
    var email = ""
    var password = ""
    var confirmPassword = ""
    var validateFields = false
    var registrationSuccessful = false
    var registrationFailed = ""
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = RegisterationViewModel(MockNetworkService.instance)
        bindViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
}

extension RegisterViewModelTests {
    func bindViewModel() {
        sut.email.bind { value in
            self.email = value
        }
        sut.password.bind { value in
            self.password = value
        }
        sut.confirmPassword.bind { value in
            self.confirmPassword = value
        }
        sut.validateFields.bind { value in
            self.validateFields = value
        }
        sut.registrationSuccessful.bind { value in
            self.registrationSuccessful = value
        }
        sut.registrationFailed.bind { value in
            self.registrationFailed = value
        }
    }
}

extension RegisterViewModelTests {
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
    
    func test_whenConfirmPasswordIsChanged() {
        sut.confirmPassword.value = ""
        XCTAssertEqual(confirmPassword, "")
        
        sut.confirmPassword.value = "Password"
        XCTAssertEqual(confirmPassword, "Password")
    }
    
    func test_whenInvalidCredentialsAreEntered() {
        sut.email.value = ""
        sut.password.value = ""
        sut.confirmPassword.value = ""
        sut.performValidation()
        
        XCTAssertFalse(validateFields)
    }
    
    func test_whenPasswordsDoNotMatch() {
        sut.email.value = "taimur.1989@gmail.com"
        sut.password.value = "Password1"
        sut.confirmPassword.value = "Password2"
        sut.performValidation()
        
        XCTAssertFalse(validateFields)
    }
    
    func test_whenValidCredentialsAreEntered() {
        sut.email.value = "taimur.1989@gmail.com"
        sut.password.value = "Password"
        sut.confirmPassword.value = "Password"
        sut.performValidation()
        
        XCTAssertTrue(validateFields)
    }
    
    func test_whenRegistrationPerformedWithInvalidCredentials() {
        sut.email.value = ""
        sut.password.value = ""
        sut.confirmPassword.value = ""
        sut.performRegisteration()
        
        XCTAssertTrue(!registrationSuccessful)
        XCTAssertTrue(!registrationFailed.isEmpty)
    }
    
    func test_whenLoginPerformedWithValidCredentials() {
        sut.email.value = "taimur.1989@gmail.com"
        sut.password.value = "Password"
        sut.confirmPassword.value = "Password"
        sut.performRegisteration()
        
        XCTAssertTrue(registrationSuccessful)
        XCTAssertTrue(registrationFailed.isEmpty)
    }
}

