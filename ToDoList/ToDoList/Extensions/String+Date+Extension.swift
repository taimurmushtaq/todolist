//
//  String+Extension.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation

enum DateFormats: String {
    case simpleFormat = "dd/MM/yyyy"
}

extension String {
    func convertToDate(withFormat format: String?) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? DateFormats.simpleFormat.rawValue
        dateFormatter.locale = Locale(identifier: "ar_AE")
        
        return dateFormatter.date(from: self)
    }
}

extension Date {
    func convertToString(withFormat format: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format ?? DateFormats.simpleFormat.rawValue
        dateFormatter.locale = Locale(identifier: "ar_AE")
        
        return dateFormatter.string(from: self)
    }
}
