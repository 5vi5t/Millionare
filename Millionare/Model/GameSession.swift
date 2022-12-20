//
//  GameSession.swift
//  Millionare
//
//  Created by Константин on 29.11.2022.
//

import Foundation

class GameSession {
    
    // MARK: - Properties
    
    var questionNumber = Observable<Int>(0)
    var correctAnswers = Observable<Int>(0)
    var totalQuestions = Observable<Int>(0)
    var result: String {
        guard totalQuestions.value != 0 else { return "0 %" }
        return "\(correctAnswers.value * 100 / totalQuestions.value) %"
    }
    var hintFiftyFifty = true
    var hintCallFriend = true
    var hintHallHelp = true
    
}
