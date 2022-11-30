//
//  ResultsCaretaker.swift
//  Millionare
//
//  Created by Константин on 29.11.2022.
//

import Foundation

class ResultsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "results"
    
    func save(results: [String]) {
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func loadResults() -> [String] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([String].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
