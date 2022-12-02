//
//  GameSession.swift
//  Millionare
//
//  Created by Константин on 29.11.2022.
//

import Foundation

class GameSession {
    
    // MARK: - Properties
    
    var questionNumber = 0
    var correctAnswers = 0
    var totalQuestions = 0
    var result: String {
        guard totalQuestions != 0 else { return "0 %" }
        return "\(correctAnswers * 100 / totalQuestions) %"
    }
    
}
