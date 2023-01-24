//
//  Oberveable.swift
//  EasyPaisa
//  ToDoList
//
//  Created by Taimur Mushtaq on 24/01/2023.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
