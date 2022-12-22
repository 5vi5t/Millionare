//
//  OrderQuestions.swift
//  Millionare
//
//  Created by Константин on 30.11.2022.
//

import Foundation

enum OrderQuestions: CustomStringConvertible, CaseIterable {
    case serial
    case random
    
    var description: String {
        switch self {
        case .serial:
            return "Последовательный"
        case .random:
            return "Случайный"
        }
    }
}
