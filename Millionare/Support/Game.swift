//
//  Game.swift
//  Millionare
//
//  Created by Константин on 29.11.2022.
//

import Foundation

final class Game {
    
    static let shared = Game()
    var gameSession: GameSession?
    private var result: String {
        guard let correctAnswers = gameSession?.correctAnswers,
              let totalQuestions = gameSession?.totalQuestions
        else {
            return ""
        }
        return "\(correctAnswers * 100 / totalQuestions)%"
    }
    private(set) var results = [String]()
    
    private init() {}
    
    func save() {
        results.append(result)
        gameSession = nil
    }
    
}
