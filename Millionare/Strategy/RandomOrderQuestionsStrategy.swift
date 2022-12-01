//
//  RandomOrderQuestionsStrategy.swift
//  Millionare
//
//  Created by Константин on 01.12.2022.
//

import Foundation

class RandomOrderQuestionsStrategy: OrderQuestionsStrategy {
    func setOrder(questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
