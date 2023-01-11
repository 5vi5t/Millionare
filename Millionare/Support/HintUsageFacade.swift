//
//  HintUsageFacade.swift
//  Millionare
//
//  Created by Константин on 09.01.2023.
//

import Foundation

class HintUsageFacade {
    
    var currentQuestion: Question?
    
    func callFriend() {
        guard let answers = currentQuestion?.answers else { return }
        let successRate = Int.random(in: 1...10)
        let success = 1...9
        if success.contains(successRate) {
            for index in 0 ..< answers.count {
                var modifiedAnswer = answers[index]
                if modifiedAnswer.type == .correct {
                    modifiedAnswer.hintType = .right
                } else {
                    modifiedAnswer.hintType = .wrong
                }
                currentQuestion?.answers[index] = modifiedAnswer
            }
        } else {
            let fakeHint = Int.random(in: 0 ..< answers.count)
            for index in 0 ..< answers.count {
                var modifiedAnswer = answers[index]
                if index == fakeHint {
                    modifiedAnswer.hintType = .right
                } else {
                    modifiedAnswer.hintType = .wrong
                }
                currentQuestion?.answers[index] = modifiedAnswer
            }
        }
    }
    
    func useAuditoryHelp() {
        guard let answers = currentQuestion?.answers else { return }
        let successRate = Int.random(in: 1...10)
        let success = 1...6
        if success.contains(successRate) {
            for index in 0 ..< answers.count {
                var modifiedAnswer = answers[index]
                if modifiedAnswer.type == .correct {
                    modifiedAnswer.hintType = .right
                } else {
                    modifiedAnswer.hintType = .wrong
                }
                currentQuestion?.answers[index] = modifiedAnswer
            }
        } else {
            let fakeHint = Int.random(in: 0..<answers.count)
            for index in 0 ..< answers.count {
                var modifiedAnswer = answers[index]
                if index == fakeHint {
                    modifiedAnswer.hintType = .right
                } else {
                    modifiedAnswer.hintType = .wrong
                }
                currentQuestion?.answers[index] = modifiedAnswer
            }
        }
    }
    
    func use50To50Hint() {
        guard let answers = currentQuestion?.answers else { return }
        var modifiedAnswers = answers
        let incorrectAnswersCount = answers.count / 2
        var counter = 0
        while counter < incorrectAnswersCount {
            for index in 0 ..< answers.count where counter < incorrectAnswersCount {
                var modifiedAnswer = modifiedAnswers[index]
                if modifiedAnswer.type == .incorrect && modifiedAnswer.hintType != .wrong {
                    if (1...5).contains(Int.random(in: (1...10))) {
                        modifiedAnswer.hintType = .wrong
                        counter += 1
                        modifiedAnswers[index] = modifiedAnswer
                    }
                }
            }
        }
        currentQuestion?.answers = modifiedAnswers
    }
}
