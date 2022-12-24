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
    var orderQuestions: OrderQuestions = .serial
    
    // MARK: - Private properties
    
    private(set) var results: [String] {
        didSet {
            resultsCaretaker.save(results: results)
        }
    }
    private let resultsCaretaker = ResultsCaretaker()
    private(set) var userQuestions: [Question] {
        didSet {
            userQuestionsCaretaker.save(questions: userQuestions)
        }
    }
    private let userQuestionsCaretaker = UserQuestionsCaretaker()
    
    // MARK: - Construction
    
    private init() {
        self.results = resultsCaretaker.loadResults()
        self.userQuestions = userQuestionsCaretaker.loadUserQuestions()
    }
    
    // MARK: - Functions
    
    func saveResult() {
        if let result = gameSession?.result {
            results.append(result)
        }
    }
    
    func save(question: Question) {
        userQuestions.append(question)
    }
}
