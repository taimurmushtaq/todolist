//
//  SpringBoard.swift
//  ToDoListUITests
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation
import XCTest

class SpringBoard {
    static let pageObject = SpringBoardPageObject()
    
    class func deleteApp() {
        pageObject.app.terminate()
        pageObject.springBoard.activate()
        
        pageObject.appIcon.press(forDuration: 1.3)
        
        if pageObject.removeAppButton.waitForExistence(timeout: 1.0) {
            pageObject.removeAppButton.tap()
            
            if pageObject.deleteAppButton.waitForExistence(timeout: 1.0) {
                pageObject.deleteAppButton.tap()
                
                if pageObject.deleteButton.waitForExistence(timeout: 1.0) {
                    pageObject.deleteButton.tap()
                }
            }
        }
    }
}
