//
//  MainThreadChecker.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation

@propertyWrapper
struct MainThread<Data> {
    var closure: ((Data) -> Void)?
    var wrappedValue: ((_ newDataToDisplay: Data) -> Void)? {
        get {
            return { newDataToDisplay in
                DispatchQueue.main.async {
                    closure?(newDataToDisplay)
                }
            }
        }
        set {
            closure = newValue
        }
    }
}
