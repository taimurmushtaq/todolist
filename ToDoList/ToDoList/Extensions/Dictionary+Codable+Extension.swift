//
//  Dictionary+Extension.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 05/08/2021.
//  Copyright © 2021 Easypaisa. All rights reserved.
//

import Foundation

extension Dictionary {
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
