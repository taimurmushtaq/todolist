//
//  Array+Extension.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import Foundation

extension Array {
    func toJSONString() -> String? {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: []) {
            return String(data: theJSONData,encoding: .utf8)
        }
        
        return nil
    }
    
    func toModel <T: Decodable> (ofType type: T.Type) -> T? {
        return self.toJSONString()?.toModel(ofType: T.self)
    }
}

extension Array where Element: Equatable & Hashable {
    static func == (lhs: [Element], rhs: [Element]) -> Bool {
        if lhs.count != rhs.count {
            return false
        }
        
        var lhsHash = [Element: Bool]()
        
        for item in lhs {
            lhsHash[item] = false
        }
        
        for item in rhs {
            if lhsHash[item] == false {
                return false
            }
        }
        
        return true
    }
}
