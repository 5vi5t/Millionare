//
//  UserQuestionsCaretaker.swift
//  Millionare
//
//  Created by Константин on 24.12.2022.
//

import Foundation

class UserQuestionsCaretaker {
    
    // MARK: - Private properties
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "userQuestions"
    
    // MARK: - Functions
    
    func save(questions: [Question]) {
        do {
            let data = try encoder.encode(questions)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func loadUserQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
