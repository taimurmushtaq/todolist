//
//  SaveTaskPageObject.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import XCTest

class SaveTaskPageObject {
    private var app: XCUIApplication!
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var titleTextField: XCUIElement {
        app.tables["titleTextField"]
    }
    var dateTextField: XCUIElement {
        app.textFields["dateTextField"]
    }
    var saveButton: XCUIElement {
        app.textFields["saveButton"]
    }
}
