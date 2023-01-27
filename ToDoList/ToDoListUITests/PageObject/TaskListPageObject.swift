//
//  TaskListPageObject.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import XCTest

class TaskListPageObject {
    private var app: XCUIApplication!
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var taskList: XCUIElement {
        app.tables["taskListTableView"]
    }
    var addTaskButton: XCUIElement {
        app.buttons["addTaskButton"]
    }
    var logoutButton: XCUIElement {
        app.navigationBars.buttons["logoutButton"]
    }
    func cell(label: String) -> XCUIElement {
        return taskList.cells[label]
    }
}

class AlertPageObject {
    private var app: XCUIApplication!
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var yesButton: XCUIElement {
        app.buttons["Yes"].firstMatch
    }
    
    var noButton: XCUIElement {
        app.buttons["No"].firstMatch
    }
}

