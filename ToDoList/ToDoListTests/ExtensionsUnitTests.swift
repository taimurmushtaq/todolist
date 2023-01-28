//
//  ExtensionsUnitTests.swift
//  ToDoListTests
//
//  Created by Taimur Mushtaq on 28/01/2023.
//

import XCTest
@testable import ToDoList

final class ExtensionsUnitTests: XCTestCase {
    
    func test_whenArrayIsConvertedToModel() {
        let object = ["isComplete": true, "timeInterval": 1674816645, "title": "Current task"] as [String : Any]
        let model = TaskDataModel(title: "Current task", timeInterval: 1674816645, isComplete: true)
        
        let array = Array([object])
        
        XCTAssertTrue(array.toModel(ofType: [TaskDataModel].self) == [model])
    }
    
    func test_whenDictionaryIsConvertedToModel() {
        let object = ["isComplete": true, "timeInterval": 1674816645, "title": "Current task"] as [String : Any]
        let model = TaskDataModel(title: "Current task", timeInterval: 1674816645, isComplete: true)
        
        XCTAssertTrue(object.toModel(ofType: TaskDataModel.self) == model)
    }
    
    func test_whenStringIsConvertedToModel() {
        let jsonString = "{\"isComplete\":true,\"timeInterval\":1674816645,\"title\":\"Current task\"}"
        let model = TaskDataModel(title: "Current task", timeInterval: 1674816645, isComplete: true)
        
        XCTAssertTrue(jsonString.toModel(ofType: TaskDataModel.self) == model)
    }
}
