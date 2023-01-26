//
//  String+Codable+Extension.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import Foundation

extension Encodable {
    func toObject() -> Any? {
        if let data = try? JSONEncoder().encode(self) {
            return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        }
        
        return nil
    }
}

extension String {
    func toModel <T: Decodable> (ofType type: T.Type) -> T? {
        guard let data = self.data(using: .utf8) else { return nil }
        
        return try? JSONDecoder().decode(type.self, from: data)
    }
}
