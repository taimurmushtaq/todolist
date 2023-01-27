//
//  RegisterPageObject.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import XCTest

class RegisterPageObject {
    private var app: XCUIApplication!
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var emailTextField: XCUIElement {
        app.tables["emailTextField"]
    }
    var passwordTextField: XCUIElement {
        app.textFields["passwordTextField"]
    }
    var confirmPasswordTextField: XCUIElement {
        app.textFields["confirmPasswordTextField"]
    }
    var registerButton: XCUIElement {
        app.buttons["registerButton"]
    }
}
