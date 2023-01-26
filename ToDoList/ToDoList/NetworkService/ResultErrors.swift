//
//  ResultErrors.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 25/01/2023.
//

import Foundation

enum ResultErrors: Error {
    case networkError
    case dataParsingError
    case dataSavingError
    case dataUpdationError
    case dataDeletionError
    case unknown
    
    var description: String {
        switch self {
        case .networkError: return "Please check your internet connection"
        case .dataParsingError: return "Data parsing failed. Please try again later."
        case .dataSavingError: return "Unble to save Task. Please try again later."
        case .dataUpdationError: return "Unble to update Task. Please try again later."
        case .dataDeletionError: return "Unble to delete Task. Please try again later."
        default: return "Something went wront. Please try in few minutes"
        }
    }
}
