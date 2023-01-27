//
//  LoginPageObject.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import XCTest

class LoginPageObject {
    private var app: XCUIApplication!
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var emailTextField: XCUIElement {
        app.textFields["emailTextField"]
    }
    var passwordTextField: XCUIElement {
        app.secureTextFields["passwordTextField"]
    }
    var loginButton: XCUIElement {
        app.buttons["loginButton"]
    }
    var registerButton: XCUIElement {
        app.buttons["registerButton"]
    }
}
