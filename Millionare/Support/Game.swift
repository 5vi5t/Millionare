//
//  Game.swift
//  Millionare
//
//  Created by Константин on 29.11.2022.
//

import Foundation

final class Game {
    
    // MARK: - Static properties
    
    static let shared = Game()
    
    // MARK: - Properties
    
    var gameSession: GameSession?
    
    // MARK: - Private properties
    
    private var result: String {
        guard let correctAnswers = gameSession?.correctAnswers,
              let totalQuestions = gameSession?.totalQuestions
        else {
            return ""
        }
        return "\(correctAnswers * 100 / totalQuestions)%"
    }
    private(set) var results: [String] {
        didSet {
            resultsCaretaker.save(results: self.results)
        }
    }
    private let resultsCaretaker = ResultsCaretaker()
    
    // MARK: - Construction
    
    private init() {
        self.results = resultsCaretaker.loadResults()
    }
    
    // MARK: - Functions
    
    func save() {
        results.append(result)
        gameSession = nil
    }
    
}
