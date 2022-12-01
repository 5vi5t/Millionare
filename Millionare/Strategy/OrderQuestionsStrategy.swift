//
//  OrderQuestionsStrategy.swift
//  Millionare
//
//  Created by Константин on 01.12.2022.
//

import Foundation

protocol OrderQuestionsStrategy {
    func setOrder(questions: [Question]) -> [Question]
}
