//
//  SpringBoardPageObject.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import XCTest

class SpringBoardPageObject {
    let app = XCUIApplication()
    let springBoard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    var appIcon: XCUIElement {
        springBoard.icons.matching(identifier: "To-Do List").firstMatch
    }
    
    var removeAppButton: XCUIElement {
        springBoard.buttons["Remove App"].firstMatch
    }
    
    var deleteAppButton: XCUIElement {
        springBoard.alerts.buttons["Delete App"].firstMatch
    }
    
    var deleteButton: XCUIElement {
        springBoard.alerts.buttons["Delete"].firstMatch
    }
}
